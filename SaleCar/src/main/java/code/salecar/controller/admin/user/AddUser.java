package code.salecar.controller.admin.user;

import code.salecar.model.User;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "AddUser", value = "/addUser")
public class AddUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phonenumber");
        String role = request.getParameter("role");
        String statusStr = request.getParameter("status");
        boolean status = true;
        if(statusStr.equals("false")){
            status = false;
        }
        String imgURL = request.getParameter("imgURL");
        User u = new User();
        u.setUsername(username);
        u.setPassword(password);
        u.setFullname(fullname);
        u.setEmail(email);
        u.setPhonenumber(phone);
        u.setRole(role);
        u.setStatus(status);
        u.setImgURL(imgURL);
        u.setCreatedat(new Date(System.currentTimeMillis()));
        u.setUpdatedat(new Date(System.currentTimeMillis()));
        UserService us  = new UserService();
        us.register(u);
        response.sendRedirect("/userAdmin");
    }
}