package code.salecar.controller.account;

import code.salecar.mail.Mail;
import code.salecar.model.User;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Random;

@WebServlet(name = "Login", value = "/login")
public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // kiểm tra session
            HttpSession session = request.getSession();
            if(session==null||session.getAttribute("user")==null){
                response.sendRedirect("/pages/login.jsp");
            }else{
                response.sendRedirect("/home");
            }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
        System.out.println(username+" "+password);
        UserService us = new UserService();
        User user = us.getUserByUsername(username);
        if(user == null){
            request.getRequestDispatcher("/pages/login.jsp").forward(request,response);
            return;
        }
        if(!user.getPassword().equals(password)){
            request.getRequestDispatcher("/pages/login.jsp").forward(request,response);
            return;
        }
        HttpSession session = request.getSession();
        session.setAttribute("otpLoginState","true");
        session.setAttribute("id",user.getId());
        response.sendRedirect("/OTPforLogin");
    }
}