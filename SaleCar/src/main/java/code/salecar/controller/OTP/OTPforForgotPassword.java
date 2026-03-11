package code.salecar.controller.OTP;

import code.salecar.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Random;

@WebServlet(name = "OTPforForgotPassword", value = "/OTPforForgotPassword")
public class OTPforForgotPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("otpForgotPasswordState")== null){
            return;
        }
        Random ran = new Random();
        int otp = ran.nextInt(900000)+100000;
        session.setAttribute("otp",otp);
        System.out.println(otp);
        User user = (User) session.getAttribute("userTemp");
        request.setAttribute("user",user);
//        new Thread(() -> {
//            Random ran = new Random();
//            session.setAttribute("otp",otp);
//            String email = user.getEmail();
        // String password = user.getPassword();
//            String content = """
//                <div style="font-family:Arial,sans-serif">
//                <h2 style="color:#004a99">TechX - Xác thực đăng nhập</h2>
//                <p>Mật khẩu của bạn là:</p>
//                <h1 style="letter-spacing:4px">%s</h1>
//                <p>Mã có hiệu lực trong 5 phút.</p>
//                <hr>
//                <small>Nếu bạn không yêu cầu, hãy bỏ qua email này.</small>
//                </div>
//                """.formatted(password);
//            Mail.send(email,"xác thực đăng nhập", content);
//        }).start();
        request.getRequestDispatcher("/pages/OTP-forgot-password.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}