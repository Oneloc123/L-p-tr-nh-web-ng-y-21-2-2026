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

        // 🔴 Bảo mật: Admin KHÔNG được tự ý đặt trạng thái "Đã giao/DELIVERED"
        if ("DELIVERED".equalsIgnoreCase(status)
                || "Đã giao".equals(status)
                || "Đã giao thành công".equals(status)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("error: Admin không có quyền tự chuyển trạng thái Đã giao!");
            return;
        }

        OrderDAO ordDAO = new OrderDAO();
        boolean isSuccess = ordDAO.updateOrderStatus(orderId, status);

        if (isSuccess) {
            // Tạo thông báo cho khách hàng khi admin thay đổi trạng thái
            try {
                Order order = ordDAO.getOrderById(orderId);
                if (order != null) {
                    String notifMessage = "";
                    if ("CONFIRMED".equals(status)) {
                        notifMessage = "Đơn hàng #" + orderId + " của bạn đã được xác nhận.";
                    } else if ("SHIPPING".equals(status)) {
                        notifMessage = "Đơn hàng #" + orderId + " của bạn đã được bàn giao cho đơn vị vận chuyển.";
                    } else if ("CANCELLED".equals(status)) {
                        notifMessage = "Đơn hàng #" + orderId + " của bạn đã bị hủy bởi quản trị viên.";
                    }
                    if (!notifMessage.isEmpty()) {
                        NotificationDAO notiDAO = new NotificationDAO();
                        notiDAO.insertNotification(order.getUserId(), notifMessage, orderId);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }

    }


}