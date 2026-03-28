package code.salecar.dao;

import code.salecar.model.*;

import code.salecar.model.product.entity.Product;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class OrderDAO {
    public void insertOrder(Order order, Cart cart) {

       try(Connection conn = DBConnection.getConnection()){
           conn.setAutoCommit(false);
           try{
               String sql = "insert into `order` " +
                       "(user_id, total_price, address, payment_method, payment_status, order_status) " +
                       "values " +
                       "(?,?,?,?,?,?)";
               PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
               pstmt.setInt(1, order.getUserId());
               pstmt.setDouble(2,order.getTotalAmount());
               pstmt.setString(3, order.getShippingAddress());
               pstmt.setString(4, order.getPaymentMethod());
               pstmt.setString(5, "chưa thanh toán");
               pstmt.setString(6, order.getOrderStatus());

               pstmt.executeUpdate();
               ResultSet rs = pstmt.getGeneratedKeys();
               if(rs.next()){
                   int orderId = rs.getInt(1);

                   for(CartItem item : cart.getItems()){
                       String sql1 = "insert into order_item (order_id, product_id, quantity, price, total_price) values (?, ?, ?, ?, ?)";
                       PreparedStatement pstmtItem = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);

                       pstmtItem.setInt(1, orderId);
                       pstmtItem.setInt(2,item.getProductId());
                       pstmtItem.setInt(3, item.getQuantity());
                       pstmtItem.setDouble(4, item.getPrice());
                       pstmtItem.setDouble(5, item.getTotalPrice());

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
        String querry = "select * from `order` where user_id = ? ";
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
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));



                Product product = productDAO.getProductByID(rs.getInt("product_id"));


                item.setProduct(product);

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

    // HÀM MỚI BỔ SUNG: Lấy tất cả đơn hàng cho Admin
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

                lstOrder.add(ord);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lstOrder;
    }

}
