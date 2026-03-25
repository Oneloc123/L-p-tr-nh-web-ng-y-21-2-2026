package code.salecar.controller.order;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import code.salecar.model.OrderItem;
import code.salecar.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.imageio.IIOException;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "order", value = "/order")
public class order extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        User user = (User) request.getSession().getAttribute("user");
        if (user == null){
            response.sendRedirect("login");
            return;
        }

        OrderDAO ordDAO = new OrderDAO();
        List<Order> lstOrder = ordDAO.getOrdersByUserId(user.getId());

        for(Order order : lstOrder){
            List<OrderItem> items = ordDAO.getOrderItemsByOrderId(order.getId());
            order.setItems(items);
            System.out.println(order.getOrderStatus());
        }

        request.setAttribute("orders", lstOrder);
        request.getRequestDispatcher("/pages/order.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
