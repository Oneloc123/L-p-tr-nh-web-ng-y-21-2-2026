package code.salecar.dao;

import code.salecar.model.*;

import code.salecar.model.product.entity.Product;
import code.salecar.config.DBConnection;

import java.sql.*;
import java.util.*;


public class OrderDAO {


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
                       "(user_id, total_price, address, payment_method, payment_status, order_status, shipping_fee) " +
                       "values " +
                       "(?,?,?,?,?,?,?)";
               PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
               pstmt.setInt(1, order.getUserId());
               pstmt.setDouble(2,order.getTotalAmount());
               pstmt.setString(3, order.getShippingAddress());
               pstmt.setString(4, order.getPaymentMethod());
               pstmt.setString(5, "chưa thanh toán");
               pstmt.setString(6, order.getOrderStatus());
               pstmt.setDouble(7, order.getShippingFee());

               pstmt.executeUpdate();
               ResultSet rs = pstmt.getGeneratedKeys();
               if(rs.next()){
                   int orderId = rs.getInt(1);
                   order.setId(orderId);


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
                ord.setShippingFee(rs.getDouble("shipping_fee"));

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

    public boolean updateOrderStatus(int orderId, String status){

        String checkQuery = "SELECT order_status FROM `order` WHERE id = ?";

        String query = "UPDATE `order` SET order_status = ? WHERE id = ?";


        try(Connection conn = DBConnection.getConnection();
        PreparedStatement psCheck = conn.prepareStatement(checkQuery)){

            psCheck.setInt(1, orderId);

            ResultSet rs = psCheck.executeQuery();
            if(rs.next()){
                String crrStatus = rs.getString("order_status");
                if("CANCELLED".equals(crrStatus) || "DELIVERED".equals(crrStatus)){
                    return false;
                }else {
                    try(PreparedStatement ps =conn.prepareStatement(query)){
                        ps.setString(1, status);
                        ps.setInt(2, orderId);

                        int row = ps.executeUpdate();
                        return row > 0;
                    }
                }
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return false;

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

                list.add(o);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return  list;
    }

    }



