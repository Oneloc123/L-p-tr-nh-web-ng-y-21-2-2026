package code.salecar.controller.account;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ChangePassword", value = "/changePassword")
public class ChangePassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            request.getRequestDispatcher("/pages/change-password.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPass = request.getParameter("current_password");
        String newPass = request.getParameter("new_password");
        String confirmPass = request.getParameter("confirm_password");
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        if(!currentPass.equals(user.getPassword())){
            request.setAttribute("currPasswordError","sai mật khẩu hiện tại");
            request.getRequestDispatcher("/pages/change-password.jsp").forward(request,response);
            return;
        }

        String newPasswordError = UserInvalidate.checkPassword(newPass);
        if(!newPasswordError.equals("true")){
            request.setAttribute("newPasswordError",newPasswordError);
            request.getRequestDispatcher("/pages/change-password.jsp").forward(request,response);
            return;
        }

        if(!newPass.equals(confirmPass)){
            request.setAttribute("confirmPasswordError","mật khẩu không hớp");
            request.getRequestDispatcher("/pages/change-password.jsp").forward(request,response);
            return;
        }
        UserService us =new UserService();

        session.setAttribute("otpChangePasswordState","true");
        user.setPassword(confirmPass);
        session.setAttribute("userTemp",user);
        response.sendRedirect("/OTPforChangePassword");
    }
}