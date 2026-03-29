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

    public boolean processOrder(User user, Cart cart, String name, String phone, String shippingAddress, String paymentMethod) {


        if (user == null || cart == null || cart.getItems().isEmpty()) {
            return false;
        }


        String fullInfor = name + " - SĐT: " + phone + " - Địa chỉ: " + shippingAddress;

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalAmount(cart.getTotal());
        order.setShippingAddress(fullInfor);
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus("Đang xử lý");


        try {
            ordDAO.insertOrder(order, cart);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public  void cancelOrder(int orderId, int userId, String reason){

        String finalStatus = "Đã huỷ (" + reason + ")";

        ordDAO.updateOrderStatusAndReason(orderId, userId, finalStatus);
    }
    public List<OrderItem> getOrderItem(int orderId){
        return ordDAO.getOrderItemsByOrderId(orderId);
    }

    public List<Order> getOrderByUserId(int userId){
        List<Order> result = ordDAO.getOrdersByUserId(userId);
        return result;
    }
}
