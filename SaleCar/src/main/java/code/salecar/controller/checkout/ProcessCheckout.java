package code.salecar.controller.checkout;

import code.salecar.model.Cart;
import code.salecar.model.Order;
import code.salecar.model.User;
import code.salecar.service.order.OrderService;
import code.salecar.service.product.VoucherService;
import code.salecar.service.buyNCart.VNPayService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ProcessCheckout", value = "/process-checkout")
public class ProcessCheckout extends HttpServlet {

    private final VoucherService voucherService = new VoucherService();

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
        String note = request.getParameter("note");
        String shippingMethod = request.getParameter("shippingMethod");

        // Lấy phí vận chuyển từ form
        double shippingFee = 0;
        String shippingFeeStr = request.getParameter("shippingFee");
        if (shippingFeeStr != null && !shippingFeeStr.isEmpty()) {
            try {
                shippingFee = Double.parseDouble(shippingFeeStr);
            } catch (NumberFormatException e) {
                shippingFee = 0;
            }
        }

        OrderService orderService = new OrderService();


        Order newOrder = orderService.processOrder(user, targetCart, name, phone, shippingAddress, paymentMethod, shippingFee, note, shippingMethod);


        if (newOrder != null && newOrder.getId() > 0) {

            // Lấy voucherId đã chọn từ session
            Long selectedVoucherId = (Long) session.getAttribute("selectedVoucherId");

            if ("VNPAY".equals(paymentMethod)) {
                // VNPay: backup cart + voucher, chưa tăng usedCount ngay
                if ("buynow".equals(type)) {
                    session.setAttribute("pendingCartBackup", session.getAttribute("buyNowCart"));
                } else {
                    session.setAttribute("pendingCartBackup", session.getAttribute("cart"));
                }
                // Backup voucherId để VNPayReturnServlet xử lý sau
                if (selectedVoucherId != null) {
                    session.setAttribute("pendingVoucherId", selectedVoucherId);
                }

                VNPayService vnPayService = new VNPayService();
                String paymentUrl = vnPayService.createPaymentUrl(request, newOrder);
                response.sendRedirect(paymentUrl);
            } else {
                // COD: tăng usedCount ngay, xóa cart
                if (selectedVoucherId != null) {
                    voucherService.incrementUsedCount(selectedVoucherId);
                }
                session.removeAttribute("selectedVoucherId");

                if ("buynow".equals(type)) {
                    session.removeAttribute("buyNowCart");
                } else {
                    session.removeAttribute("cart");
                }
                response.sendRedirect(request.getContextPath() + "/pages/thankyou.jsp");
            }

        } else {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("Hệ thống quá tải hoặc có lỗi xảy ra. Vui lòng thử lại!");
        }
    }
}