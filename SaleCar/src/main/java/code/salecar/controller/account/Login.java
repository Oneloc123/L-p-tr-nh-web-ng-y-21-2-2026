package code.salecar.controller.account;

import code.salecar.model.User;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

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
        String responseForLogin = "";
        if(user == null){
 //           responseForLogin = "tên đăng nhập không tồn tại";
//            request.setAttribute("response",responseForLogin);
            request.getRequestDispatcher("/pages/login.jsp").forward(request,response);
            return;
        }
        if(!user.getPassword().equals(password)){
  //          responseForLogin = "sai mật khẩu hoặc tên đăng nhập";
 //           request.setAttribute("response",responseForLogin);
            request.getRequestDispatcher("/pages/login.jsp").forward(request,response);
            return;
        }
        HttpSession session = request.getSession();
        session.setAttribute("user",user);
        response.sendRedirect("/home");
    }
}