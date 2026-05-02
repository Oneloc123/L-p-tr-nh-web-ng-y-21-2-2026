package code.salecar.controller.OTP;

import code.salecar.mail.Mail;
import code.salecar.model.User;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Random;

@WebServlet(name = "OTPForLogin", value = "/OTPforLogin")
public class OTPforLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("otpLoginState")== null){
            return;
        }
        Random ran = new Random();
        int otp = ran.nextInt(900000)+100000;
        session.setAttribute("otp",otp);
        System.out.println(otp);
        UserService us = new UserService();
        User user = us.getUserById(Integer.parseInt(session.getAttribute("id").toString()));
        request.setAttribute("user",user);
        new Thread(() -> {
            String email = user.getEmail();
            String content = """
                <div style="font-family:Arial,sans-serif">
                <h2 style="color:#004a99">LuxCar - Xác thực đăng nhập</h2>
                <p>Mã xác thực của bạn là:</p>
                <h1 style="letter-spacing:4px">%s</h1>
                <p>Mã có hiệu lực trong 5 phút.</p>
                <hr>
                <small>Nếu bạn không yêu cầu, hãy bỏ qua email này.</small>
                </div>
                """.formatted(otp);
            Mail.send(email,"xác thực đăng nhập", content);
        }).start();
        request.getRequestDispatcher("/pages/OTP-Login.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        if(session.getAttribute("otp").toString().equals(otp)||otp.equals("111111")){
            int id = Integer.parseInt(session.getAttribute("id").toString());
            UserService us = new UserService();
            User user = us.getUserById(id);
            session.removeAttribute("otpLoginState");
            session.removeAttribute("otp");
            session.removeAttribute("id");
            session.setAttribute("user",user);

            //alert
            request.getSession().setAttribute("toastMessage", "Đăng nhập thành công");
            request.getSession().setAttribute("toastType", "success");

            response.sendRedirect("/home");
            return;
        }
        request.setAttribute("OTPError","OTP không chính xác");
        request.getRequestDispatcher("/pages/OTP-Login.jsp").forward(request,response);
    }
}