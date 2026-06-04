package code.salecar.controller.order;

//import code.salecar.dao.NotificationDAO;
import code.salecar.model.Order;
import code.salecar.model.User;
import code.salecar.service.order.OrderService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "CancelOrderServlet", value = "/cancel-order")
public class CancelOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String cancelReason = request.getParameter("cancelReason");


        User user = (User) request.getSession().getAttribute("user");
        if(user != null){

            OrderService orderService = new OrderService();
            orderService.cancelOrder(orderId, user.getId(), cancelReason);

            // Tạo thông báo cho người dùng khi họ hủy đơn hàng
            String message = "Đơn hàng #" + orderId + " đã được hủy thành công.";
            if (cancelReason != null && !cancelReason.trim().isEmpty()) {
                message = "Đơn hàng #" + orderId + " của bạn đã bị hủy. Lý do: " + cancelReason;
            }
//            NotificationDAO notiDAO = new NotificationDAO();
//            notiDAO.insertNotification(user.getId(), message);
        }
        response.sendRedirect("order");
    }
}