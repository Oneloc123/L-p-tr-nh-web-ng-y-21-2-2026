package code.salecar.controller.admin.order;

import code.salecar.model.Order;
import code.salecar.model.User;
import code.salecar.service.order.OrderService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "FilterOrd", value = "/FilterOrd")
public class FilterOrd extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            User user = (User)session.getAttribute("user");
            if(!user.getRole().equals("admin")){
                response.sendRedirect("/login");
                return;
            }
            String keyword = request.getParameter("keyword");
            OrderService os = new OrderService();
            List<Order> listOrd =  os.getOrdByKeyWord(keyword);
            request.setAttribute("listUser",listOrd);
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        String status = request.getParameter("orderStatus");
        OrderService os = new OrderService();
        List<Order> listOrd = os.filterOrder(status);
        request.setAttribute("listOrd",listOrd);
        request.getRequestDispatcher("/admin/order-admin.jsp").forward(request,response);
    }
}