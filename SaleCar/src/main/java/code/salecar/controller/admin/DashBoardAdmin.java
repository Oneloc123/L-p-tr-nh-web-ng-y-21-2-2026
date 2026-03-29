package code.salecar.controller.admin;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import code.salecar.model.User;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashBoardAdmin", value = "/admin/dashboard")
public class DashBoardAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us = new UserService();
        List<User> listUser = us.getList();
        int totalUser = 0;
        int activeUsers = 0;
        int inactiveUsers = 0;
        int totalAdmins = 0;
        for(User u : listUser){
            totalUser++;
            if(u.getStatus()){
                activeUsers++;
            }else{
                inactiveUsers++;
            }
//            if(u.getRole().equals("admin")||u.getRole()!=null){
//                totalAdmins++;
//            }
        }
        request.setAttribute("totalUser",totalUser);
        request.setAttribute("activeUsers",activeUsers);
        request.setAttribute("inactiveUsers",inactiveUsers);
//        request.setAttribute("totalAdmins",totalAdmins);
        OrderDAO od = new OrderDAO();
        List<Order> listOrder = od.getAllOrders();
        int totalOrders = 0;
        double totalSpending = 0;
        for (Order o : listOrder){
            totalOrders++;
            totalSpending+= o.getTotalAmount();
        }
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalSpending",totalSpending);
        request.setAttribute("listOrder",listOrder);
        request.getRequestDispatcher("/admin/dashBoardAdmin.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}