package code.salecar.controller.order;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import code.salecar.model.OrderItem;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "order-detail", value = "/order-detail")
public class OrderDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order"); // Nếu không có ID thì đá về trang danh sách đơn hàng
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam);
            OrderDAO orderDAO = new OrderDAO();

            Order order = orderDAO.getOrderById(orderId);

            if (order != null) {


                List<OrderItem> items = orderDAO.getOrderItemsByOrderId(orderId);
                order.setItems(items);

                request.setAttribute("order", order);
                request.getRequestDispatcher("/pages/order-detail.jsp").forward(request, response);
            } else {

                response.sendRedirect(request.getContextPath() + "/order");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/order");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}