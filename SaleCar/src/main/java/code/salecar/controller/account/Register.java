package code.salecar.controller.account;

import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "Register", value = "/register")
public class Register extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/pages/register.jsp");
        }else{
            response.sendRedirect("/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String phonenumber = request.getParameter("phonenumber");

    //    System.out.println(fullname+" "+username+" "+email+" "+password+" "+confirmPassword+" "+phonenumber);
        if(!password.equals(confirmPassword)){
  //          request.setAttribute("response","mật khẩu không khớp");
            request.getRequestDispatcher("/pages/register.jsp").forward(request,response);
            return;
        }
        UserService us = new UserService();
        AddressService as = new AddressService();
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setEmail(email);
        user.setDescription("");
        user.setPhonenumber(phonenumber);
        user.setRole("user");
        user.setAddressid("");
        user.setStatus(true);
        user.setCreatedat(new Date(System.currentTimeMillis()));
        user.setUpdatedat(new Date(System.currentTimeMillis()));
        HttpSession session = request.getSession();
        session.setAttribute("otpRegisterState","true");
        session.setAttribute("userTemp",user);
        response.sendRedirect("/OTPforRegister");
    }
}