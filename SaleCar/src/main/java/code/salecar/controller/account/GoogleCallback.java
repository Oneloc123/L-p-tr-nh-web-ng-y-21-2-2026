package code.salecar.controller.account;

import code.salecar.model.User;
import code.salecar.service.user.UserService;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/googleCallback")
public class GoogleCallback extends HttpServlet {
    private static final String CLIENT_ID = "";
    private static final String CLIENT_SECRET = "";
    private static final String REDIRECT_URI = "http://localhost:8080/saleCar/googleCallback";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String authorizationCode = request.getParameter("code");
        if (authorizationCode != null) {
            try {
                GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                new NetHttpTransport(), new JacksonFactory(), CLIENT_ID, CLIENT_SECRET, authorizationCode, REDIRECT_URI).execute();
                GoogleIdToken idToken = tokenResponse.parseIdToken();
                GoogleIdToken.Payload payload = idToken.getPayload();
                String userId = payload.getSubject();
                String email = payload.getEmail();
                String name = (String) payload.get("name");
                UserService us = new UserService();
                User user = us.getUserByEmail(email);
                if(user == null){
                    user = new User();
                    user.setUsername(email);
                    user.setPassword("111111");
                    user.setFullname(name);
                    user.setEmail(email);
                    user.setDescription("");
                    user.setPhonenumber("");
                    user.setRole("user");
                    user.setAddressid("");
                    user.setStatus(true);
                    user.setCreatedat(new Date(System.currentTimeMillis()));
                    user.setUpdatedat(new Date(System.currentTimeMillis()));
                    us.register(user);
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user",user);
                    response.sendRedirect("/home");
                    return;
                }
                HttpSession session = request.getSession(true);
                session.setAttribute("user",user);
                response.sendRedirect("/home");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("/dang-nhap?loi=Xac thuc that bai");
            }
        } else {
            String error = request.getParameter("error");
            response.sendRedirect("/dang-nhap?loi=" + error);
        }
    }
}