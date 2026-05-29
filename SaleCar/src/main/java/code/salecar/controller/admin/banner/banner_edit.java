package code.salecar.controller.admin.banner;

import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Banner;
import code.salecar.service.product.BannerService;
import code.salecar.util.BannerUploadUtil;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/admin/banners/edit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class banner_edit extends HttpServlet {
    private final BannerService bannerService = new BannerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                long id = BannerUploadUtil.parseLongSafe(idParam, -1L);
                if (id < 0) { response.sendRedirect(request.getContextPath() + "/admin/banners"); return; }
                Banner banner = bannerService.getBannerById(id);
                if (banner != null) {
                    request.setAttribute("banner", banner);
                    request.getRequestDispatcher("/admin/banner/banner-edit.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // ignore
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/banners");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        long id = BannerUploadUtil.parseLongSafe(idParam, -1L);
        if (id < 0) {
            response.sendRedirect(request.getContextPath() + "/admin/banners");
            return;
        }

        Banner banner = bannerService.getBannerById(id);
        if (banner == null) {
            NotificationUtil.setError(request.getSession(), "Banner không tồn tại");
            response.sendRedirect(request.getContextPath() + "/admin/banners");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String redirectUrl = request.getParameter("link");
        String statusParam = request.getParameter("status");
        String orderParam = request.getParameter("displayOrder");

        /** Kiểm tra tiêu đề */
        if (title == null || title.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Tiêu đề banner không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/banners/edit?id=" + id);
            return;
        }

        /** Kiểm tra link */
        if (!BannerUploadUtil.isValidLink(redirectUrl)) {
            NotificationUtil.setError(request.getSession(), "Link điều hướng không hợp lệ. Phải bắt đầu bằng http://, https:// hoặc /");
            response.sendRedirect(request.getContextPath() + "/admin/banners/edit?id=" + id);
            return;
        }

        int displayOrder = BannerUploadUtil.parseIntSafe(orderParam, 0);

        /** Xử lý upload ảnh (giữ ảnh cũ nếu không có file mới) */
        try {
            Part filePart = request.getPart("image");
            String oldImageUrl = banner.getImageUrl();
            String newImageUrl = BannerUploadUtil.uploadImage(filePart, request.getContextPath(), oldImageUrl);
            if (newImageUrl == null) {
                NotificationUtil.setError(request.getSession(), "Chỉ chấp nhận file ảnh JPG, PNG, WEBP");
                response.sendRedirect(request.getContextPath() + "/admin/banners/edit?id=" + id);
                return;
            }

            /** Nếu có ảnh mới được upload (URL thay đổi), xoá file cũ */
            if (!newImageUrl.equals(oldImageUrl) && oldImageUrl != null && !oldImageUrl.isEmpty()) {
                BannerUploadUtil.deleteImageFile(oldImageUrl);
            }
            banner.setImageUrl(newImageUrl);
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi upload ảnh: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/banners/edit?id=" + id);
            return;
        }

        banner.setTitle(title.trim());
        banner.setDescription(description != null ? description.trim() : null);
        banner.setRedirectUrl(redirectUrl != null ? redirectUrl.trim() : null);
        banner.setSortOrder(displayOrder);
        banner.setStatus(Status.fromString(statusParam));
        banner.setUpdatedAt(LocalDateTime.now());

        boolean updated = bannerService.updateBanner(banner);
        if (updated) {
            NotificationUtil.setSuccess(request.getSession(), "Cập nhật banner thành công");
        } else {
            NotificationUtil.setError(request.getSession(), "Cập nhật banner thất bại");
        }
        response.sendRedirect(request.getContextPath() + "/admin/banners");
    }
}
