package code.salecar.controller.order;

import code.salecar.model.Order;
import code.salecar.model.User;
import code.salecar.service.order.OrderService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "CancelOrderServlet", value = "/cancel-order")
public class CancelOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String cancelReason = request.getParameter("cancelReason");


        User user = (User) request.getSession().getAttribute("user");
        if(user != null){

            OrderService orderService = new OrderService();
            orderService.cancelOrder(orderId, user.getId(), cancelReason);
        }
        response.sendRedirect("order");
    }
}