package code.salecar.dao;

import code.salecar.model.*;

import code.salecar.model.product.entity.Product;
import code.salecar.config.DBConnection;

import java.sql.*;
import java.util.*;


public class OrderDAO {
    public List<Order> getOrdersByPreviousDays(int days) {
        List<Order> orders = new ArrayList<>();

        String query = "SELECT * FROM `order` " +
                "WHERE order_date >= DATE_SUB(NOW(), INTERVAL ? DAY) " +
                "AND order_date < DATE_SUB(NOW(), INTERVAL ? DAY) " +
                "ORDER BY order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, days * 2);
            ps.setInt(2, days);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order ord = new Order();
                ord.setId(rs.getInt("id"));
                ord.setUserId(rs.getInt("user_id"));
                ord.setOrderDate(rs.getTimestamp("order_date"));
                ord.setTotalAmount(rs.getDouble("total_price"));
                ord.setShippingAddress(rs.getString("address"));
                ord.setPaymentMethod(rs.getString("payment_method"));
                ord.setOrderStatus(rs.getString("order_status"));
                ord.setShippingFee(rs.getDouble("shipping_fee"));
                ord.setNote(rs.getString("note"));
                ord.setShippingMethod(rs.getString("shipping_method"));

                orders.add(ord);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    public List<Order> getOrdersByLastDays(int days) {
        List<Order> orders = new ArrayList<>();

        String query = "SELECT * FROM `order` " +
                "WHERE order_date >= DATE_SUB(NOW(), INTERVAL ? DAY) " +
                "ORDER BY order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, days);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order ord = new Order();

                ord.setId(rs.getInt("id"));
                ord.setUserId(rs.getInt("user_id"));
                ord.setOrderDate(rs.getTimestamp("order_date"));
                ord.setTotalAmount(rs.getDouble("total_price"));
                ord.setShippingAddress(rs.getString("address"));
                ord.setPaymentMethod(rs.getString("payment_method"));
                ord.setOrderStatus(rs.getString("order_status"));
                ord.setShippingFee(rs.getDouble("shipping_fee"));
                ord.setNote(rs.getString("note"));
                ord.setShippingMethod(rs.getString("shipping_method"));

                orders.add(ord);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public Order getOrderById(int orderId) {
        String query = "SELECT * FROM `order` WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Order ord = new Order();
                ord.setId(rs.getInt("id"));
                ord.setUserId(rs.getInt("user_id"));
                ord.setOrderDate(rs.getTimestamp("order_date"));
                ord.setTotalAmount(rs.getDouble("total_price"));
                ord.setShippingAddress(rs.getString("address"));
                ord.setPaymentMethod(rs.getString("payment_method"));
                ord.setOrderStatus(rs.getString("order_status"));
                ord.setShippingFee(rs.getDouble("shipping_fee"));
                ord.setNote(rs.getString("note"));
                ord.setShippingMethod(rs.getString("shipping_method"));

                return ord;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertOrder(Order order, Cart cart) {

        try(Connection conn = DBConnection.getConnection()){
            conn.setAutoCommit(false);
            try{
                String sql = "insert into `order` " +
                        "(user_id, total_price, address, payment_method, payment_status, order_status, shipping_fee, note, shipping_method) " +
                        "values " +
                        "(?,?,?,?,?,?,?,?,?)";
                PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setInt(1, order.getUserId());
                pstmt.setDouble(2,order.getTotalAmount());
                pstmt.setString(3, order.getShippingAddress());
                pstmt.setString(4, order.getPaymentMethod());
                pstmt.setString(5, "chưa thanh toán");
                pstmt.setString(6, order.getOrderStatus());
                pstmt.setDouble(7, order.getShippingFee());
                pstmt.setString(8, order.getNote());
                pstmt.setString(9, order.getShippingMethod());

                pstmt.executeUpdate();
                ResultSet rs = pstmt.getGeneratedKeys();
                if(rs.next()){
                    int orderId = rs.getInt(1);
                    order.setId(orderId);


                    for(CartItem item : cart.getItems()){
                        /**
                         * Insert order_item với variant_id (nếu có).
                         * @variantId: 0 nếu không có variant.
                         */
                        String sql1 = "insert into order_item (order_id, product_id, variant_id, quantity, price, total_price) values (?, ?, ?, ?, ?, ?)";
                        PreparedStatement pstmtItem = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);

                        pstmtItem.setInt(1, orderId);
                        pstmtItem.setInt(2,item.getProductId());
                        pstmtItem.setInt(3, item.getVariantId());
                        pstmtItem.setInt(4, item.getQuantity());
                        pstmtItem.setDouble(5, item.getPrice());
                        pstmtItem.setDouble(6, item.getTotalPrice());

                        pstmtItem.executeUpdate();
                        pstmtItem.close();
                    }
                    conn.commit();
                }
            }catch (Exception e){
                conn.rollback();
                e.printStackTrace();
            }



        }catch (Exception e){

            throw new RuntimeException();
        }

    }

    public List<Order> getOrdersByUserId(int userId){
        ArrayList<Order> lstOrder = new ArrayList<>();
        String querry = "select * from `order` where user_id = ? order by id desc";
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(querry)){
            ps.setInt(1,userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Order ord = new Order();

                ord.setId(rs.getInt("id"));
                ord.setUserId(rs.getInt("user_id"));
                ord.setOrderDate(rs.getTimestamp("order_date"));
                ord.setTotalAmount(rs.getDouble("total_price"));
                ord.setShippingAddress(rs.getString("address"));
                ord.setPaymentMethod(rs.getString("payment_method"));
                ord.setOrderStatus(rs.getString("order_status"));
                ord.setShippingFee(rs.getDouble("shipping_fee"));
                ord.setNote(rs.getString("note"));
                ord.setShippingMethod(rs.getString("shipping_method"));

                lstOrder.add(ord);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return lstOrder;
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> listItems = new ArrayList<>();

        ProductDAO productDAO = new ProductDAO();
        ProductImageDAO productImageDAO = new ProductImageDAO();


        String query = "SELECT * FROM order_item WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();


                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setVariantId(rs.getInt("variant_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));

                Product product = productDAO.getProductByID(rs.getInt("product_id"));
                item.setProduct(product);

                // Lấy ảnh chính của sản phẩm từ bảng image
                String mainImage = productImageDAO.getMainImage(product.getId());
                item.setImageUrl(mainImage);

                listItems.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listItems;
    }

    public void updateOrderStatusAndReason(int orderId, int userId, String newStatus) {
        String query = "UPDATE `order` SET order_status = ? WHERE id = ? AND user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            ps.setInt(3, userId);

            ps.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật trạng thái đơn hàng.
     * <p>
     * Chỉ validate status và update, KHÔNG xử lý inventory ở đây.
     * Việc trừ kho/hoàn kho do {@link code.salecar.service.inventory.InventoryService}
     * đảm nhiệm, gọi từ Controller layer.
     *
     * @param orderId ID đơn hàng
     * @param status  Trạng thái mới
     * @return true nếu thành công, false nếu không hợp lệ hoặc lỗi
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String checkQuery = "SELECT order_status FROM `order` WHERE id = ?";
        String updateQuery = "UPDATE `order` SET order_status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            // ── Bước 1: Kiểm tra trạng thái hiện tại ──
            String crrStatus;
            try (PreparedStatement psCheck = conn.prepareStatement(checkQuery)) {
                psCheck.setInt(1, orderId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (!rs.next()) {
                        return false; // Không tìm thấy đơn hàng
                    }
                    crrStatus = rs.getString("order_status");
                }
            }

            // Nếu đã CANCELLED, DELIVERED, hoặc các biến thể tiếng Việt → không cho đổi nữa
            if ("CANCELLED".equals(crrStatus) || "DELIVERED".equals(crrStatus)
                    || (crrStatus != null && crrStatus.startsWith("Đã huỷ"))
                    || (crrStatus != null && crrStatus.startsWith("Đã hủy"))
                    || (crrStatus != null && (crrStatus.contains("Đã giao") || crrStatus.contains("Đã giao thành công")))) {
                System.out.println("[OrderDAO.updateOrderStatus] Đơn hàng #" + orderId
                        + " đã ở trạng thái cuối (" + crrStatus + "), từ chối cập nhật.");
                return false;
            }

            // ── Bước 2: Cập nhật trạng thái ──
            try (PreparedStatement ps = conn.prepareStatement(updateQuery)) {
                ps.setString(1, status);
                ps.setInt(2, orderId);
                ps.executeUpdate();
            }

            return true;

        } catch (Exception e) {
            System.out.println("[OrderDAO.updateOrderStatus] LỖI: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }



    public List<Order> getAllOrders() {
        List<Order> lstOrder = new ArrayList<>();

        String query = "SELECT * FROM `order` ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order ord = new Order();

                ord.setId(rs.getInt("id"));
                ord.setUserId(rs.getInt("user_id"));
                ord.setOrderDate(rs.getTimestamp("order_date"));
                ord.setTotalAmount(rs.getDouble("total_price"));
                ord.setShippingAddress(rs.getString("address"));
                ord.setPaymentMethod(rs.getString("payment_method"));
                ord.setOrderStatus(rs.getString("order_status"));
                ord.setShippingFee(rs.getDouble("shipping_fee"));
                ord.setNote(rs.getString("note"));
                ord.setShippingMethod(rs.getString("shipping_method"));

                lstOrder.add(ord);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lstOrder;
    }


    public List<Order> getOrdByKeyWord(String keyword) {
        List<Order> list = new ArrayList<>();
        String query = "select * from order where order_status like ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setTotalAmount(rs.getDouble("total_price"));
                o.setShippingAddress(rs.getString("address"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setShippingFee(rs.getDouble("shipping_fee"));
                o.setNote(rs.getString("note"));
                o.setShippingMethod(rs.getString("shipping_method"));

                list.add(o);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return  list;
    }

    public List<Order> filterOrd(String status) {
        List<Order> list = new ArrayList<>();
        String query = "select * from order where order_status like ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + status + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setTotalAmount(rs.getDouble("total_price"));
                o.setShippingAddress(rs.getString("address"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setShippingFee(rs.getDouble("shipping_fee"));
                o.setNote(rs.getString("note"));
                o.setShippingMethod(rs.getString("shipping_method"));

                list.add(o);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return  list;
    }

}