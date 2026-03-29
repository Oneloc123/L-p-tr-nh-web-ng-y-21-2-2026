package code.salecar.controller.account;

import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
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
        User user = (User) session.getAttribute("userTemp");
        request.setAttribute("user",user);
        request.getRequestDispatcher("/pages/reset-password.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String newPasswordError = UserInvalidate.checkPassword(newPassword);
        if(!newPasswordError.equals("true")){
            request.setAttribute("newPasswordError",newPasswordError);
            request.getRequestDispatcher("/pages/register.jsp").forward(request,response);
            return;
        }

        if(!newPassword.equals(confirmPassword)){
            request.setAttribute("confirmPasswordError","mật khẩu không khớp");
            request.getRequestDispatcher("/pages/register.jsp").forward(request,response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("confirmPassword",confirmPassword);
        response.sendRedirect("/OTPforForgotPassword");
    }
}