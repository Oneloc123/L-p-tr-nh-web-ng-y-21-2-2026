package code.salecar.controller.checkout;

import code.salecar.config.VNPayConfig;
import code.salecar.dao.OrderDAO;
import code.salecar.model.Cart;
import code.salecar.model.Order;
import code.salecar.model.OrderItem;
import code.salecar.model.User;
import code.salecar.model.product.dto.ProductItemDTO;
import code.salecar.service.inventory.InventoryService;
import code.salecar.service.product.ProductService;
import code.salecar.service.product.VoucherService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.*;

@WebServlet(name = "VNPayReturnServlet", value = "/vnpay-return")
public class VNPayReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

                String vnp_SecureHash = request.getParameter("vnp_SecureHash");
                fields.remove("vnp_SecureHashType");
                fields.remove("vnp_SecureHash");

                List<String> fieldNames = new ArrayList<>(fields.keySet());
                Collections.sort(fieldNames);
                StringBuilder signData = new StringBuilder();
                Iterator<String> itr = fieldNames.iterator();
                while (itr.hasNext()) {
                    String fieldName = itr.next();
                    String fieldValue = fields.get(fieldName);
                    if ((fieldValue != null) && (fieldValue.length() > 0)) {
                        signData.append(fieldName);
                        signData.append('=');
                        signData.append(java.net.URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        if (itr.hasNext()) {
                            signData.append('&');
                        }
                    }
                }

                // Kiểm tra chữ ký bảo mật
                String checkSignature = VNPayConfig.hmacSHA512(VNPayConfig.vnp_HashSecret, signData.toString());

                String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");

                if (!checkSignature.equalsIgnoreCase(vnp_SecureHash)) {
                    response.getWriter().println("Chữ ký bảo mật không hợp lệ!");
                    return;
                }

                // Chỉ xử lý khi signature hợp lệ
                String orderIdStr = request.getParameter("vnp_TxnRef");
                String responseCode = request.getParameter("vnp_ResponseCode");

                int orderId;
                try {
                    orderId = Integer.parseInt(orderIdStr);
                } catch (NumberFormatException e) {
                    response.getWriter().println("Mã đơn hàng không hợp lệ!");
                    return;
                }

                // MAJOR-04: Kiểm tra order có thuộc về user không
                OrderDAO orderDAO = new OrderDAO();
                Order order = orderDAO.getOrderById(orderId);
                if (order == null) {
                    response.getWriter().println("Đơn hàng không tồn tại!");
                    return;
                }
                HttpSession session = request.getSession(false);
                if (session != null) {
                    User user = (User) session.getAttribute("user");
                    if (user != null && order.getUserId() != user.getId()) {
                        response.getWriter().println("Đơn hàng không thuộc về bạn!");
                        return;
                    }
                }

                VoucherService voucherService = new VoucherService();

                if ("00".equals(responseCode)) {
                    orderDAO.updateOrderStatus(orderId, "CONFIRMED");
                    // VNPay thành công: tăng usedCount voucher, dọn cart backup
                    if (session != null) {
                        // Tăng usedCount nếu có voucher pending
                        Long pendingVoucherId = (Long) session.getAttribute("pendingVoucherId");
                        if (pendingVoucherId != null) {
                            voucherService.incrementUsedCount(pendingVoucherId);
                        }
                        session.removeAttribute("pendingVoucherId");
                        session.removeAttribute("selectedVoucherId");
                        session.removeAttribute("pendingCartBackup");
                        // Xóa cart chính nếu user đã dùng cart đó để thanh toán
                        session.removeAttribute("cart");
                        session.removeAttribute("buyNowCart");
                    }
                   InventoryService invService = new InventoryService();
                        invService.deductStock(orderId, 0); // 0 = system

                    // Lưu sản phẩm gợi ý vào session
                    try {
                        ProductService productService = new ProductService();
                        List<OrderItem> orderItems = orderDAO.getOrderItemsByOrderId(orderId);
                        List<Long> categoryIds = new ArrayList<>();
                        List<Integer> excludeProductIds = new ArrayList<>();
                        Set<Long> seenCategories = new HashSet<>();

                        for (OrderItem item : orderItems) {
                            if (item.getProduct() != null) {
                                long catId = item.getProduct().getCategoryId();
                                if (seenCategories.add(catId)) {
                                    categoryIds.add(catId);
                                }
                                excludeProductIds.add(item.getProductId());
                            }
                        }

                        List<ProductItemDTO> suggestedProducts = productService.getSuggestedProducts(categoryIds, excludeProductIds);
                        if (session != null) {
                            session.setAttribute("suggestedProducts", suggestedProducts);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    response.sendRedirect(request.getContextPath() + "/pages/thankyou.jsp");
                } else {
                    orderDAO.updateOrderStatus(orderId, "CANCELLED");
                    // VNPay thất bại: khôi phục cart từ backup + giữ nguyên voucher đã chọn
                    if (session != null) {
                        Cart backupCart = (Cart) session.getAttribute("pendingCartBackup");
                        if (backupCart != null) {
                            session.setAttribute("cart", backupCart);
                        }
                        // Khôi phục selectedVoucherId từ pendingVoucherId
                        Long pendingVoucherId = (Long) session.getAttribute("pendingVoucherId");
                        if (pendingVoucherId != null) {
                            session.setAttribute("selectedVoucherId", pendingVoucherId);
                        }
                        session.removeAttribute("pendingVoucherId");
                        session.removeAttribute("pendingCartBackup");
                    }
                    response.sendRedirect(request.getContextPath() + "/order");
                }
            }


        @Override
        protected void doPost (HttpServletRequest request, HttpServletResponse response) throws
        ServletException, IOException {
            // Xử lý IPN (Instant Payment Notification) từ VNPay server
            // Dùng chung logic với doGet
            doGet(request, response);
        }

}