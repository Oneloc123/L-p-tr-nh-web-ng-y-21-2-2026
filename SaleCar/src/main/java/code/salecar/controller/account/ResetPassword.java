package code.salecar.controller.account;

import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ResetPassword", value = "/resetPassword")
public class ResetPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("resetPasswordState").toString()==null){
            return;
        }
        User user = (User) session.getAttribute("user");
        request.setAttribute("user",user);
        request.getRequestDispatcher("/pages/reset-password.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();
        String newPasswordError = UserInvalidate.checkPassword(newPassword);
        if(!newPasswordError.equals("true")){
            User user = (User) session.getAttribute("user");
            request.setAttribute("user",user);
            request.setAttribute("newPasswordError",newPasswordError);
            request.getRequestDispatcher("/pages/reset-password.jsp").forward(request,response);
            return;
        }

        if(!newPassword.equals(confirmPassword)){
            User user = (User) session.getAttribute("user");
            request.setAttribute("user",user);
            request.setAttribute("confirmPasswordError","mật khẩu không khớp");
            request.getRequestDispatcher("/pages/reset-password.jsp").forward(request,response);
            return;
        }
        User user = (User)session.getAttribute("userTemp");
        UserService us = new UserService();
        user.setPassword(newPassword);
        us.UpdateProfile(user);
        session.removeAttribute("resetPasswordState");
        session.removeAttribute("userTemp");

        //alert
        request.getSession().setAttribute("toastMessage", "Đặt lại mật khẩu thành công vui lòng đăng nhập lại");
        request.getSession().setAttribute("toastType", "success");
        response.sendRedirect("/login");
    }
}