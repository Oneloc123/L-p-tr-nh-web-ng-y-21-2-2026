package code.salecar.service.order;

import code.salecar.dao.OrderDAO;
import code.salecar.dao.UserDao;
import code.salecar.model.Cart;
import code.salecar.model.Order;
import code.salecar.model.OrderItem;
import code.salecar.model.User;
import code.salecar.service.user.UserService;

import java.util.List;

public class OrderService {
    OrderDAO ordDAO = new OrderDAO();
    UserService userSV = new UserService();


    public List<Order> getOrderByDays(int days){
        return ordDAO.getOrdersByLastDays(days);
    }
    public List<Order> getOrderByDaysPrevious(int days){
        return ordDAO.getOrdersByPreviousDays(days);
    }

    public Order processOrder(User user, Cart cart, String name, String phone, String shippingAddress, String paymentMethod, double shippingFee) {


        if (user == null || cart == null || cart.getItems().isEmpty()) {
            return null;
        }


        String fullInfor = name + " - SĐT: " + phone + " - Địa chỉ: " + shippingAddress;

        // Tổng tiền = tiền hàng + phí ship
        double totalAmount = cart.getTotal() + shippingFee;

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(fullInfor);
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus("Đang xử lý");
        order.setShippingFee(shippingFee);


        try {
            ordDAO.insertOrder(order, cart);
            return order;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean cancelOrder(int orderId, int userId, String reason){
        // Chặn hủy nếu đơn đang SHIPPING, DELIVERED hoặc đã CANCELLED
        Order order = ordDAO.getOrderById(orderId);
        if (order == null) return false;
        String currentStatus = order.getOrderStatus();
        if ("SHIPPING".equalsIgnoreCase(currentStatus)
                || "DELIVERED".equalsIgnoreCase(currentStatus)
                || "CANCELLED".equalsIgnoreCase(currentStatus)) {
            return false;
        }
        // Dùng "CANCELLED" đồng bộ với DashBoard, DashBoardAdmin, OrderAdmin
        ordDAO.updateOrderStatusAndReason(orderId, userId, "CANCELLED");
        return true;
    }
    public List<OrderItem> getOrderItem(int orderId){
        return ordDAO.getOrderItemsByOrderId(orderId);
    }

    public List<Order> getOrderByUserId(int userId){
        List<Order> result = ordDAO.getOrdersByUserId(userId);
        return result;
    }

    public  List<Order> getOrdByKeyWord(String Key){
        List<Order> orderList = ordDAO.getOrdByKeyWord(Key);
        for (Order ord : orderList){
            ord.setItems(ordDAO.getOrderItemsByOrderId(ord.getId()));
        }
        return orderList;
    }

    public List<Order> filterOrder(String status) {


            return ordDAO.filterOrd(status);

    }
}
