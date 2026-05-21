package code.salecar.controller.checkout;

import code.salecar.model.Cart;
import code.salecar.model.Order;
import code.salecar.model.User;
import code.salecar.service.order.OrderService;
import code.salecar.service.buyNCart.VNPayService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ProcessCheckout", value = "/process-checkout")
public class ProcessCheckout extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String type = request.getParameter("type");
        Cart targetCart = null;

        // check type
        if("buynow".equals(type)){
            targetCart = (Cart) session.getAttribute("buyNowCart");
        } else {
            targetCart = (Cart) session.getAttribute("cart");
        }

        if (targetCart == null || targetCart.getItems().isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        String name = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        OrderService orderService = new OrderService();

        // CHÚ Ý: Hàm này giờ sẽ trả về đối tượng Order thay vì boolean isSuccess
        Order newOrder = orderService.processOrder(user, targetCart, name, phone, shippingAddress, paymentMethod);

        // Nếu tạo đơn hàng thành công (newOrder != null và đã có ID từ Database)
        if (newOrder != null && newOrder.getId() > 0) {

            // Xóa giỏ hàng
            if ("buynow".equals(type)) {
                session.removeAttribute("buyNowCart");
            } else {
                session.removeAttribute("cart");
            }

            // PHÂN LUỒNG THANH TOÁN
            if ("VNPAY".equals(paymentMethod)) {
                // Gọi Service tạo link VNPay
                VNPayService vnPayService = new VNPayService();
                String paymentUrl = vnPayService.createPaymentUrl(request, newOrder);

                // Chuyển hướng người dùng qua giao diện của VNPay
                response.sendRedirect(paymentUrl);
            } else {
                // Thanh toán COD (Thanh toán khi nhận hàng) như cũ
                response.sendRedirect(request.getContextPath() + "/pages/thankyou.jsp");
            }

        } else {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("Hệ thống quá tải hoặc có lỗi xảy ra. Vui lòng thử lại!");
        }
    }
}