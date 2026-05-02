package code.salecar.controller.account;

import code.salecar.dao.UserDao;
import code.salecar.model.GoogleUser;
import code.salecar.model.GoogleUtils;
import code.salecar.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "GoogleLogin", value = "/login/GoogleLoginServlet")
public class GoogleLogin extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        String accessToken = GoogleUtils.getToken(code);
        GoogleUser userInfo = GoogleUtils.getUserInfo(accessToken);
        UserDao userDAO = new UserDao();
        User user = userDAO.getUserByEmail(userInfo.getEmail());
        if (user == null) {
            user = new User();
            user.setUsername(userInfo.getEmail());
            user.setPassword("1");
            user.setFullname(userInfo.getName());
            user.setEmail(userInfo.getEmail());
            user.setDescription("");
            user.setPhonenumber("");
            user.setRole("user");
            user.setAddressid("");
            user.setStatus(true);
            user.setCreatedat(new Date(System.currentTimeMillis()));
            user.setUpdatedat(new Date(System.currentTimeMillis()));
            userDAO.register(user);
        }
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        response.sendRedirect("/home");

    }
}