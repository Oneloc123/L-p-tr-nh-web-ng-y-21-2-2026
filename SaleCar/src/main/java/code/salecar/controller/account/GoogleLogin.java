package code.salecar.controller.account;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "GoogleLogin", value = "/googleLogin")
public class GoogleLogin extends HttpServlet {
    private static final String CLIENT_ID = "";
    private static final String REDIRECT_URI = "http://localhost:8080/saleCar/googleCallback";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String googleLoginUrl = "https://accounts.google.com/o/oauth2/v2/auth?"
        + "client_id=" + CLIENT_ID + "&redirect_uri=" + REDIRECT_URI + "&response_type=code" + "&scope=openid%20email%20profile";
        response.sendRedirect(googleLoginUrl);
    }
}