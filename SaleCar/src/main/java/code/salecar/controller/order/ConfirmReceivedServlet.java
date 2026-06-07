package code.salecar.controller.order;

import code.salecar.dao.NotificationDAO;
import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import code.salecar.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ConfirmReceivedServlet", value = "/confirm-received")
public class ConfirmReceivedServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam);

            OrderDAO ordDAO = new OrderDAO();

            // Chỉ cho phép user xác nhận đơn hàng của chính họ
            Order order = ordDAO.getOrderById(orderId);
            if (order == null || order.getUserId() != user.getId()) {
                request.getSession().setAttribute("toastMessage", "Không tìm thấy đơn hàng!");
                request.getSession().setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/order");
                return;
            }

            // Kiểm tra đơn hàng đang ở trạng thái SHIPPING/Đang vận chuyển
            String currentStatus = order.getOrderStatus();
            boolean isShipping = "SHIPPING".equals(currentStatus)
                    || (currentStatus != null && currentStatus.contains("Đang vận chuyển"));

            if (!isShipping) {
                request.getSession().setAttribute("toastMessage",
                        "Đơn hàng không ở trạng thái đang giao, không thể xác nhận!");
                request.getSession().setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/order-detail?id=" + orderId);
                return;
            }

            // Cập nhật trạng thái thành DELIVERED
            // Gọi trực tiếp DAO (không qua admin servlet) — hàm DAO chỉ chặn nếu
            // đơn đã CANCELLED/DELIVERED từ trước, không chặn SHIPPING → DELIVERED
            boolean success = ordDAO.updateOrderStatus(orderId, "DELIVERED");

            if (success) {
                // Tạo thông báo
                NotificationDAO notiDAO = new NotificationDAO();
                notiDAO.insertNotification(user.getId(),
                        "Đơn hàng #" + orderId + " đã được giao thành công! Cảm ơn bạn đã mua hàng.",
                        orderId);

                request.getSession().setAttribute("toastMessage",
                        "Cảm ơn bạn! Đơn hàng #" + orderId + " đã được xác nhận đã giao thành công!");
                request.getSession().setAttribute("toastType", "success");
            } else {
                request.getSession().setAttribute("toastMessage",
                        "Không thể xác nhận đơn hàng. Vui lòng thử lại sau!");
                request.getSession().setAttribute("toastType", "error");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("toastMessage", "Mã đơn hàng không hợp lệ!");
            request.getSession().setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/order-detail?id=" + idParam);
    }
}
