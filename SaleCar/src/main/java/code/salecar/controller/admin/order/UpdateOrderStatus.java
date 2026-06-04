package code.salecar.controller.admin.order;

import code.salecar.dao.OrderDAO;
import code.salecar.model.User;
import code.salecar.service.inventory.InventoryService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UpdateOrderStatus", value = "/update-order-status")
public class UpdateOrderStatus extends HttpServlet {

    private final InventoryService invService = new InventoryService();

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
            /**
             * Nếu admin xác nhận đơn (CONFIRMED), thực hiện trừ kho.
             * Lấy admin userId từ session (người đang thao tác).
             */
            if ("CONFIRMED".equalsIgnoreCase(status)) {
                User admin = (User) request.getSession().getAttribute("user");
                int adminUserId = admin != null ? admin.getId() : 0;
                invService.deductStock(orderId, adminUserId);
            }

            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }

    }


}