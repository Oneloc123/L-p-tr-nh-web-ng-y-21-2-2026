package code.salecar.controller.checkout;

import code.salecar.config.VNPayConfig;
import code.salecar.dao.OrderDAO;
import code.salecar.service.inventory.InventoryService;
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

                // Lấy mã ord va ma phan hoi tu vnpay
                String orderIdStr = request.getParameter("vnp_TxnRef");
                String responseCode = request.getParameter("vnp_ResponseCode");

                OrderDAO orderDAO = new OrderDAO();
                int orderId = Integer.parseInt(orderIdStr);

                if (checkSignature.equalsIgnoreCase(vnp_SecureHash)) {
                    if ("00".equals(responseCode)) {

                        orderDAO.updateOrderStatus(orderId, "CONFIRMED");

                        /* VNPay thanh toán thành công → tự động trừ kho */
                        InventoryService invService = new InventoryService();
                        invService.deductStock(orderId, 0); // 0 = system

                        response.sendRedirect(request.getContextPath() + "/pages/thankyou.jsp");
                    } else {
                        //thanh toan false
                        orderDAO.updateOrderStatus(orderId, "CANCELLED");
                        response.sendRedirect(request.getContextPath() + "/order");
                    }
                } else {
                    response.getWriter().println("Chữ ký bảo mật không hợp lệ!");
                }
            }


        @Override
        protected void doPost (HttpServletRequest request, HttpServletResponse response) throws
        ServletException, IOException {

        }

}