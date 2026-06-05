package code.salecar.service.inventory;

import code.salecar.config.DBConnection;
import code.salecar.dao.OrderDAO;
import code.salecar.model.OrderItem;

import java.sql.*;
import java.util.List;

/**
 * Service xử lý logic tồn kho.
 * <ul>
 *   <li>deductStock: trừ kho khi admin xác nhận đơn hàng (status → CONFIRMED)</li>
 *   <li>restoreStock: hoàn kho khi đơn hàng bị hủy (đã trừ kho trước đó)</li>
 *   <li>hasEnoughStock: kiểm tra tồn kho variant</li>
 * </ul>
 */
public class InventoryService {

    private final OrderDAO ordDAO = new OrderDAO();

    /**
     * Kiểm tra 1 variant cụ thể có đủ stock không.
     * Dùng ở OrderService.processOrder() để validate trước khi tạo order.
     *
     * @param variantId ID biến thể ( > 0 )
     * @param quantity  Số lượng yêu cầu
     * @return true nếu còn đủ hàng
     */
    public boolean hasEnoughStock(int variantId, int quantity) {
        String sql = "SELECT quantity FROM inventory WHERE variant_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("quantity") >= quantity;
            }
            return false; // Không có record inventory = hết hàng
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Trừ kho — gọi khi admin xác nhận đơn hàng (status → CONFIRMED).
     * <p>
     * Flow:
     * <ol>
     *   <li>Tạo export_receipt</li>
     *   <li>Tạo export_receipt_items cho từng item trong order</li>
     *   <li>Trừ inventory.quantity</li>
     *   <li>Đánh dấu order.inventory_deducted = 1</li>
     * </ol>
     * Tất cả trong 1 transaction — nếu lỗi rollback toàn bộ.
     */
    public boolean deductStock(int orderId, int adminUserId) {
        List<OrderItem> items = ordDAO.getOrderItemsByOrderId(orderId);

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 1. Tạo export_receipt
            int receiptId = createExportReceipt(con, adminUserId);
            if (receiptId <= 0) {
                throw new SQLException("Không thể tạo phiếu xuất kho");
            }

            // 2. Tạo export_receipt_items + trừ inventory (chỉ với variant có ID > 0)
            for (OrderItem item : items) {
                createExportReceiptItem(con, receiptId, item);
                if (item.getVariantId() > 0) {
                    deductInventory(con, item.getVariantId(), item.getQuantity());
                }
            }

            // 3. Đánh dấu order đã trừ kho
            markInventoryDeducted(con, orderId, true);

            con.commit();
            return true;

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Hoàn kho — gọi khi hủy đơn hàng đã được xác nhận (đã trừ kho).
     * <p>
     * Flow:
     * <ol>
     *   <li>Cộng lại inventory.quantity</li>
     *   <li>Đánh dấu order.inventory_deducted = 0</li>
     * </ol>
     */
    public boolean restoreStock(int orderId) {
        // Chỉ hoàn kho nếu đã trừ trước đó
        if (!isInventoryDeducted(orderId)) {
            return true; // Chưa trừ thì không cần hoàn
        }

        List<OrderItem> items = ordDAO.getOrderItemsByOrderId(orderId);

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Cộng lại inventory (chỉ với variant có ID > 0)
            for (OrderItem item : items) {
                if (item.getVariantId() > 0) {
                    restoreInventory(con, item.getVariantId(), item.getQuantity());
                }
            }

            // Đánh dấu đã hoàn kho
            markInventoryDeducted(con, orderId, false);

            con.commit();
            return true;

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Kiểm tra order đã được trừ kho hay chưa.
     */
    public boolean isInventoryDeducted(int orderId) {
        String sql = "SELECT inventory_deducted FROM `order` WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("inventory_deducted") == 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===================== PRIVATE HELPERS =====================

    private int createExportReceipt(Connection con, int adminUserId) throws SQLException {
        String sql = "INSERT INTO export_receipts (created_by, type, status, created_at) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, adminUserId);
            ps.setString(2, "order");
            ps.setString(3, "completed");
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    private void createExportReceiptItem(Connection con, int receiptId, OrderItem item) throws SQLException {
        String sql = "INSERT INTO export_receipt_items (receipt_id, product_id, variant_id, quantity, export_price) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, receiptId);
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getVariantId());
            ps.setInt(4, item.getQuantity());
            ps.setDouble(5, item.getPrice());
            ps.executeUpdate();
        }
    }

    /**
     * Trừ inventory — ném SQLException nếu không đủ stock (chống overselling).
     */
    private void deductInventory(Connection con, int variantId, int quantity) throws SQLException {
        String sql = "UPDATE inventory SET quantity = quantity - ? WHERE variant_id = ? AND quantity >= ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, variantId);
            ps.setInt(3, quantity);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Không đủ tồn kho để xuất: variant_id=" + variantId);
            }
        }
    }

    /**
     * Cộng lại inventory (khi cancel/hủy đơn).
     */
    private void restoreInventory(Connection con, int variantId, int quantity) throws SQLException {
        String sql = "UPDATE inventory SET quantity = quantity + ? WHERE variant_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, variantId);
            ps.executeUpdate();
        }
    }

    private void markInventoryDeducted(Connection con, int orderId, boolean deducted) throws SQLException {
        String sql = "UPDATE `order` SET inventory_deducted = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, deducted ? 1 : 0);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
    }
}
