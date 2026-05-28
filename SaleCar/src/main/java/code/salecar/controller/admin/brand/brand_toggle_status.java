package code.salecar.controller.admin.brand;

import code.salecar.service.product.BrandService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/brands/toggle-status")
public class brand_toggle_status extends HttpServlet {
    BrandService brandService = new BrandService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam.trim());
                boolean toggled = brandService.toggleStatus(id);
                if (toggled) {
                    NotificationUtil.setSuccess(request.getSession(), "Chuyển đổi trạng thái thương hiệu thành công!");
                } else {
                    NotificationUtil.setError(request.getSession(), "Không thể chuyển đổi trạng thái thương hiệu");
                }
            } else {
                NotificationUtil.setError(request.getSession(), "Thiếu ID thương hiệu");
            }
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID thương hiệu không hợp lệ");
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi chuyển đổi trạng thái: " + e.getMessage());
        }

        String redirectUrl = request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/brands");
        }
    }
}
