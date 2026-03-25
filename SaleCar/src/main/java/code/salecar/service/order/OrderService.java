package code.salecar.service.order;

import code.salecar.dao.OrderDAO;

public class OrderService {
    OrderDAO ordDAO = new OrderDAO();

    public  void cancelOrder(int orderId, int userId, String reason){

        String finalStatus = "Đã huỷ (" + reason + ")";

        ordDAO.updateOrderStatusAndReason(orderId, userId, finalStatus);
    }
}
