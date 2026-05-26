package code.salecar.controller.admin.banner;

import code.salecar.service.product.BannerService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/banners/toggle-status")
public class banner_toggle_status extends HttpServlet {
    private final BannerService bannerService = new BannerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                long id = Long.parseLong(idParam.trim());
                boolean toggled = bannerService.toggleStatus(id);
                if (toggled) {
                    NotificationUtil.setSuccess(request.getSession(), "Chuyển đổi trạng thái banner thành công");
                } else {
                    NotificationUtil.setError(request.getSession(), "Chuyển đổi trạng thái banner thất bại");
                }
            } catch (NumberFormatException e) {
                NotificationUtil.setError(request.getSession(), "ID banner không hợp lệ");
            }
        } else {
            NotificationUtil.setError(request.getSession(), "Thiếu ID banner");
        }

        String redirectUrl = request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/banners");
        }
    }
}
