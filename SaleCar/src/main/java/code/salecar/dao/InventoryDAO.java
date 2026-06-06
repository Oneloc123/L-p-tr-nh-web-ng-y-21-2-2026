package code.salecar.dao;

import code.salecar.config.DBConnection;

import java.sql.*;

public class InventoryDAO {

    /**
     * Cập nhật tồn kho theo delta (cộng hoặc trừ).
     * Nếu chưa có record inventory thì INSERT mới với quantity = delta.
     * Nếu đã có thì UPDATE quantity = quantity + delta.
     * Dùng cho cả nhập kho (+delta) và xuất kho (-delta).
     *
     * @param productId ID sản phẩm
     * @param variantId ID biến thể
     * @param delta     Số lượng thay đổi (dương = nhập, âm = xuất)
     */
    public void adjustQuantity(long productId, long variantId, int delta) {
        String sql = "INSERT INTO inventory (product_id, variant_id, quantity, last_updated) " +
                "VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE quantity = quantity + ?, last_updated = VALUES(last_updated)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, productId);
            ps.setLong(2, variantId);
            ps.setInt(3, delta); // INSERT: quantity = delta
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            ps.setInt(5, delta); // UPDATE: quantity = quantity + delta

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi cập nhật tồn kho: " + e.getMessage());
        }
    }

    public int getQuantity(long variantId) {
        String sql = "select quantity from inventory where variant_id = ? ";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setLong(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }
}
