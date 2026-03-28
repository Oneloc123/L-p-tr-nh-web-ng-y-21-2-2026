package code.salecar.controller.admin.order;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderAdmin", value = "/orderAdmin")
public class OrderAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO ordDAO = new OrderDAO();
        List<Order> lstOrder = ordDAO.getAllOrders();

        request.setAttribute("orders",lstOrder);

        request.getRequestDispatcher("/admin/order-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}