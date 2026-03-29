package code.salecar.controller.admin.order;

import code.salecar.dao.OrderDAO;
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

        int orderId =  Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        OrderDAO ordDAO = new OrderDAO();
        boolean isSuccess = ordDAO.updateOrderStatus(orderId, status);

        if(isSuccess == true){
            response.getWriter().write("success");
        }else {
            response.getWriter().write("error");
        }

    }
}