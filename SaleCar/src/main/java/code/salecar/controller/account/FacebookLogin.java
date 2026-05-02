package code.salecar.controller.account;

import code.salecar.dao.UserDao;
import code.salecar.model.FacebookUser;
import code.salecar.model.NetUtils;
import code.salecar.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;


@WebServlet(name = "FacebookLogin", value = "/login/loginFacebook")
public class FacebookLogin extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            response.sendRedirect(request.getContextPath());
        } else {
            String accessToken = NetUtils.getToken(code);
            FacebookUser userFb = NetUtils.getUserInfo(accessToken);
            UserDao userDAO = new UserDao();
            User user = userDAO.getUserByEmail(userFb.getEmail());
            if (user == null) {
                user = new User();
                user.setUsername(userFb.getEmail());
                user.setPassword("1");
                user.setFullname(userFb.getName());
                user.setEmail(userFb.getEmail());
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
            session.setAttribute("user", userFb);
            response.sendRedirect("/home");
        }
    }
}