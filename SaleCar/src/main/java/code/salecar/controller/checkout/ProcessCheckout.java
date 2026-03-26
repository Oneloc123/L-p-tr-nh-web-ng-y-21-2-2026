package code.salecar.controller.checkout;

import code.salecar.model.Cart;
import code.salecar.model.User;

import code.salecar.service.order.OrderService;
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
        boolean isSuccess = orderService.processOrder(user, targetCart, name, phone, shippingAddress, paymentMethod);

        if (isSuccess) {

            if ("buynow".equals(type)) {
                session.removeAttribute("buyNowCart");
            } else {
                session.removeAttribute("cart");
            }
            response.sendRedirect(request.getContextPath() + "/pages/thankyou.jsp");
        } else {
            response.getWriter().println("Hệ thống quá tải hoặc có lỗi xảy ra. Vui lòng thử lại!");
        }
    }
}