package code.salecar.service.order;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Cart;
import code.salecar.model.Order;
import code.salecar.model.User;

public class OrderService {
    OrderDAO ordDAO = new OrderDAO();

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
}
