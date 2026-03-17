package code.salecar.controller.account;

import code.salecar.model.User;
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

        if(!newPassword.equals(confirmPassword)){
            response.sendRedirect("/resetPassword");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("confirmPassword",confirmPassword);
        response.sendRedirect("/OTPforForgotPassword");
    }
}