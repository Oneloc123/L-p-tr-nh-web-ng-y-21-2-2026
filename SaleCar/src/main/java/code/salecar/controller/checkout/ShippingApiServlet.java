package code.salecar.controller.checkout;

import code.salecar.service.GHNService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ShippingApiServlet", value = "/api/shipping")
public class    ShippingApiServlet extends HttpServlet {

    private GHNService ghnService = new GHNService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("provinces".equals(action)) {
            // Lấy danh sách tỉnh/thành phố
            String json = ghnService.getProvinces();
            response.getWriter().print(json);

        } else if ("districts".equals(action)) {
            // Lấy danh sách quận/huyện theo province_id
            String provinceIdStr = request.getParameter("provinceId");
            if (provinceIdStr != null && !provinceIdStr.isEmpty()) {
                try {
                    int provinceId = Integer.parseInt(provinceIdStr);
                    String json = ghnService.getDistricts(provinceId);
                    response.getWriter().print(json);
                } catch (NumberFormatException e) {
                    response.getWriter().print("{\"code\":400,\"message\":\"quận/huyện không hợp lệ\"}");
                }
            } else {
                response.getWriter().print("{\"code\":400,\"message\":\"Thiếu quận/huyện\"}");
            }

        } else if ("wards".equals(action)) {
            // Lấy danh sách phường/xã theo district_id
            String districtIdStr = request.getParameter("districtId");
            if (districtIdStr != null && !districtIdStr.isEmpty()) {
                try {
                    int districtId = Integer.parseInt(districtIdStr);
                    String json = ghnService.getWards(districtId);
                    response.getWriter().print(json);
                } catch (NumberFormatException e) {
                    response.getWriter().print("{\"code\":400,\"message\":\"tỉnh/tp không hợp lệ\"}");
                }
            } else {
                response.getWriter().print("{\"code\":400,\"message\":\"Thiếu tỉnh/tp\"}");
            }

        } else if ("fee".equals(action)) {
            // Tính phí vận chuyển
            String districtIdStr = request.getParameter("districtId");
            String wardCode = request.getParameter("wardCode");

            if (districtIdStr != null && !districtIdStr.isEmpty() && wardCode != null && !wardCode.isEmpty()) {
                try {
                    int districtId = Integer.parseInt(districtIdStr);
                    long fee = ghnService.calculateFee(districtId, wardCode);
                    response.getWriter().print("{\"code\":200,\"data\":{\"total\":" + fee + "}}");
                } catch (NumberFormatException e) {
                    response.getWriter().print("{\"code\":400,\"message\":\"tỉnh/tp không hợp lệ\"}");
                }
            } else {
                response.getWriter().print("{\"code\":400,\"message\":\"Thiếu tỉnh/tp hoặc quận\"}");
            }

        } else {
            response.getWriter().print("{\"code\":400,\"message\":\" không hợp lệ.\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
