package code.salecar.controller.notification;

import code.salecar.dao.NotificationDAO;
import code.salecar.model.Notification;
import code.salecar.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "NotificationServlet", value = "/notifications")
public class NotificationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        NotificationDAO notiDAO = new NotificationDAO();
        List<Notification> notifications = notiDAO.getAllNotifications(user.getId());
        int unreadCount = notiDAO.getUnreadCount(user.getId());

        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);
        request.getRequestDispatcher("/pages/notifications.jsp").forward(request, response);
    }
}
