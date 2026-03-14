package code.salecar.controller.account;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ForgotPassword", value = "/forgotPassword")
public class ForgotPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/pages/forgot-password.jsp");
        }else{
            response.sendRedirect("/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        UserService us = new UserService();
        User user = us.getUserByUsername(username);
        if(!email.equals(user.getEmail())){
            response.sendRedirect("/pages/forgot-password.jsp");
            return;
        }
        HttpSession session = request.getSession();
        session.setAttribute("resetPasswordState","true");
        session.setAttribute("userTemp",user);
        response.sendRedirect("/resetPassword");
    }
}