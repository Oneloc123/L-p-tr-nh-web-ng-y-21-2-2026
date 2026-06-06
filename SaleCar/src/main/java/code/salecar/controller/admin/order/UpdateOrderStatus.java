package code.salecar.controller.admin.order;

import code.salecar.dao.NotificationDAO;
import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import code.salecar.model.User;
import code.salecar.service.inventory.InventoryService;
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

        // Admin KHÔNG được tự ý đặt trạng thái "Đã giao/DELIVERED"
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
            //  Xử lý tồn kho qua InventoryService
            InventoryService invService = new InventoryService();
            User adminUser = (User) request.getSession().getAttribute("user");
            int adminUserId = (adminUser != null) ? adminUser.getId() : 0;

            if ("CONFIRMED".equals(status)) {
                // Trừ kho + tạo phiếu xuất khi xác nhận đơn
                invService.deductStock(orderId, adminUserId);
            } else if ("CANCELLED".equals(status) && invService.isInventoryDeducted(orderId)) {
                // Hoàn kho khi hủy đơn đã trừ kho trước đó
                invService.restoreStock(orderId);
            }

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