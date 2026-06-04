package code.salecar.controller.admin.order;

import code.salecar.dao.NotificationDAO;
import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UpdateOrderStatus", value = "/update-order-status")
public class UpdateOrderStatus extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        OrderDAO ordDAO = new OrderDAO();
        boolean isSuccess = ordDAO.updateOrderStatus(orderId, status);

        if (isSuccess) {
            // Lấy thông tin đơn hàng để biết userId
            Order order = ordDAO.getOrderById(orderId);
            if (order != null) {
                NotificationDAO notiDAO = new NotificationDAO();
                String message = buildNotificationMessage(orderId, status, request);
                notiDAO.insertNotification(order.getUserId(), message);
            }
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }

    }

    private String buildNotificationMessage(int orderId, String status, HttpServletRequest request) {
        switch (status.toUpperCase()) {
            case "CONFIRMED":
                return "Đơn hàng #" + orderId + " của bạn đã được xác nhận.";
            case "SHIPPING":
                return "Đơn hàng #" + orderId + " đã được giao cho đơn vị vận chuyển.";
            case "DELIVERED":
                return "Đơn hàng #" + orderId + " đã được giao thành công!";
            case "CANCELLED":
                String cancelReason = request.getParameter("cancelReason");
                if (cancelReason != null && !cancelReason.trim().isEmpty()) {
                    return "Đơn hàng #" + orderId + " đã bị hủy. Lý do: " + cancelReason;
                }
                return "Đơn hàng #" + orderId + " đã bị hủy.";
            default:
                return "Đơn hàng #" + orderId + " đã được cập nhật trạng thái: " + status;
        }
    }
}