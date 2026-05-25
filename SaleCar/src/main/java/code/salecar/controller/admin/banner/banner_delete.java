package code.salecar.controller.admin.banner;

import code.salecar.model.product.entity.Banner;
import code.salecar.service.product.BannerService;
import code.salecar.util.BannerUploadUtil;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/banners/delete")
public class banner_delete extends HttpServlet {
    private final BannerService bannerService = new BannerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                long id = Long.parseLong(idParam.trim());

                // Get banner before deleting to retrieve image URL for file deletion
                Banner banner = bannerService.getBannerById(id);

                boolean deleted = bannerService.deleteBanner(id);
                if (deleted) {
                    // Delete associated image file if exists
                    if (banner != null) {
                        BannerUploadUtil.deleteImageFile(banner.getImageUrl());
                    }
                    NotificationUtil.setSuccess(request.getSession(), "Xóa banner thành công");
                } else {
                    NotificationUtil.setError(request.getSession(), "Xóa banner thất bại");
                }
            } catch (NumberFormatException e) {
                NotificationUtil.setError(request.getSession(), "ID banner không hợp lệ");
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
