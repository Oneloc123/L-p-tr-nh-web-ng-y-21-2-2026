package code.salecar.controller.notification;

import code.salecar.dao.NotificationDAO;
import code.salecar.model.Notification;
import code.salecar.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "NotificationApiServlet", value = "/api/notifications")
public class NotificationApiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Unauthorized\"}");
            return;
        }

        try {
            String action = request.getParameter("action");
            NotificationDAO notiDAO = new NotificationDAO();
            PrintWriter out = response.getWriter();

            if ("markRead".equals(action)) {
                notiDAO.markAllAsRead(user.getId());
                out.write("{\"success\":true}");
                return;
            }

            // Default: action=summary
            int count = notiDAO.getUnreadCount(user.getId());
            List<Notification> top5 = notiDAO.getTop5Notifications(user.getId());

            StringBuilder json = new StringBuilder();
            json.append("{\"count\":").append(count).append(",\"notifications\":[");

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            for (int i = 0; i < top5.size(); i++) {
                Notification n = top5.get(i);
                if (i > 0) json.append(",");
                json.append("{");
                json.append("\"id\":").append(n.getId()).append(",");
                json.append("\"message\":\"").append(escapeJson(n.getMessage())).append("\",");
                json.append("\"isRead\":").append(n.isIsRead()).append(",");
                json.append("\"createdAt\":\"").append(sdf.format(n.getCreatedAt())).append("\"");
                json.append("}");
            }

            json.append("]}");
            out.write(json.toString());
        } catch (Exception e) {
            // Return safe fallback JSON to avoid breaking navbar
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"count\":0,\"notifications\":[]}");
        }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
