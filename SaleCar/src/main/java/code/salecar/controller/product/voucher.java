package code.salecar.controller.product;

import code.salecar.model.Cart;
import code.salecar.model.product.entity.Voucher;
import code.salecar.service.product.VoucherService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "voucher", value = "/voucher")
public class voucher extends HttpServlet {

    private final VoucherService voucherService = new VoucherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String type = request.getParameter("type");
        String action = request.getParameter("action"); // "apply" or "remove"

        Cart cart = null;
        if ("buynow".equals(type)) {
            cart = (Cart) session.getAttribute("buyNowCart");
        } else {
            cart = (Cart) session.getAttribute("cart");
        }

        if (cart == null || cart.getItems().isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Giỏ hàng trống\"}");
            return;
        }

        // ========== ACTION: REMOVE VOUCHER ==========
        if ("remove".equals(action)) {
            cart.setFinalTotal(cart.getTotal());
            session.removeAttribute("selectedVoucherId");
            session.removeAttribute("appliedVoucherCode");
            response.getWriter().write("{\"success\":true,\"finalTotal\":" + cart.getTotal() + ",\"message\":\"Đã hủy voucher\"}");
            return;
        }

        // ========== ACTION: APPLY VOUCHER ==========
        String voucherCode = request.getParameter("voucherCode");
        if (voucherCode == null || voucherCode.trim().isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Vui lòng nhập mã voucher\"}");
            return;
        }

        voucherCode = voucherCode.trim().toUpperCase();

        // Tìm voucher theo code
        Voucher voucher = voucherService.getVoucherByCode(voucherCode);
        if (voucher == null) {
            response.getWriter().write("{\"success\":false,\"message\":\"Mã voucher \'" + voucherCode + "\' không tồn tại\"}");
            return;
        }

        // Validate voucher
        if (!voucherService.isValidForCart(voucher, cart)) {
            // Reset cart về giá gốc + xóa session khi voucher không hợp lệ
            cart.setFinalTotal(cart.getTotal());
            session.removeAttribute("selectedVoucherId");
            session.removeAttribute("appliedVoucherCode");
            response.getWriter().write("{\"success\":false,\"message\":\"Mã voucher không hợp lệ hoặc đã hết lượt sử dụng\"}");
            return;
        }

        // Áp dụng voucher: tính giá sau giảm
        double finalTotal = voucherService.getFinalPrice((int) voucher.getId(), cart);

        // Lưu vào session (dùng cho VNPay backup)
        session.setAttribute("selectedVoucherId", voucher.getId());
        session.setAttribute("appliedVoucherCode", voucher.getCode());

        // Build response JSON (escape code để tránh special chars)
        String safeCode = voucher.getCode().replace("\\","\\\\").replace("\"","\\\"");
        String json = String.format(
            "{\"success\":true,\"finalTotal\":%.0f,\"voucherId\":%d,\"voucherCode\":\"%s\",\"discountValue\":%.0f,\"valueType\":\"%s\"}",
            finalTotal,
            voucher.getId(),
            safeCode,
            voucher.getValue().doubleValue(),
            voucher.getValueType().name()
        );
        response.getWriter().write(json);
    }
}