package code.salecar.controller.admin.user;

import code.salecar.model.User;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DeleteUser", value = "/deleteUser")
public class DeleteUser extends HttpServlet {
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
            int id = Integer.parseInt(request.getParameter("id"));
            UserService us = new UserService();
            us.deleteUserById(id);
            response.sendRedirect("/userAdmin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}