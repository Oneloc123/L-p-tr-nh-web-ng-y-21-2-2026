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

@WebServlet("/admin/banners/create")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class banner_create extends HttpServlet {
    private final BannerService bannerService = new BannerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/banner/banner-create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String redirectUrl = request.getParameter("link");
        String statusParam = request.getParameter("status");
        String orderParam = request.getParameter("displayOrder");

        /** Kiểm tra tiêu đề */
        if (title == null || title.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Tiêu đề banner không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/banners/create");
            return;
        }

        /** Kiểm tra link */
        if (!BannerUploadUtil.isValidLink(redirectUrl)) {
            NotificationUtil.setError(request.getSession(), "Link điều hướng không hợp lệ. Phải bắt đầu bằng http://, https:// hoặc /");
            response.sendRedirect(request.getContextPath() + "/admin/banners/create");
            return;
        }

        int displayOrder = BannerUploadUtil.parseIntSafe(orderParam, 0);

        /** Xử lý upload ảnh */
        try {
            Part filePart = request.getPart("image");
            String imageUrl = BannerUploadUtil.uploadImage(filePart, request.getContextPath(), "");
            if (imageUrl == null) {
                NotificationUtil.setError(request.getSession(), "Chỉ chấp nhận file ảnh JPG, PNG, WEBP");
                response.sendRedirect(request.getContextPath() + "/admin/banners/create");
                return;
            }

            Banner banner = new Banner();
            banner.setTitle(title.trim());
            banner.setDescription(description != null ? description.trim() : null);
            banner.setImageUrl(imageUrl);
            banner.setRedirectUrl(redirectUrl != null ? redirectUrl.trim() : null);
            banner.setSortOrder(displayOrder);
            banner.setStatus(Status.fromString(statusParam));
            banner.setCreatedAt(LocalDateTime.now());
            banner.setUpdatedAt(LocalDateTime.now());

            long id = bannerService.insertBanner(banner);
            if (id > 0) {
                NotificationUtil.setSuccess(request.getSession(), "Thêm banner thành công");
            } else {
                NotificationUtil.setError(request.getSession(), "Thêm banner thất bại");
            }
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi upload ảnh: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/banners");
    }
}
