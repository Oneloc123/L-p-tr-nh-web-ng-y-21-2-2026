package code.salecar.controller.admin.banner;

import code.salecar.service.product.BannerService;
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
                bannerService.toggleStatus(id);
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        String redirectUrl = request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/banners");
        }
    }
}
