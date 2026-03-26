package code.salecar.controller.admin.user;

import code.salecar.model.User;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "FilterUser", value = "/filterUser")
public class FilterUser extends HttpServlet {
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
            UserService us = new UserService();
            List<User> listUser =  us.getUserBykeyWord(keyword);
            request.setAttribute("listUser",listUser);
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String role = request.getParameter("role");
            String status = request.getParameter("status");
            UserService us = new UserService();
            List<User> listUser = us.filterUser(role,status);
            request.setAttribute("listUser",listUser);
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
    }
}