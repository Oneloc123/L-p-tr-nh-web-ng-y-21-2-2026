package code.salecar.controller.admin.product.api;

import code.salecar.model.User;
import code.salecar.model.product.entity.ProductImage;
import code.salecar.service.Image.ImageService;
import code.salecar.service.file.FileStorageService;
import code.salecar.service.file.ActivityLogger;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Collection;

@WebServlet(name = "UploadProductImageServlet", value = "/admin/products/upload-image")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 25
)
public class UploadProductImageServlet extends HttpServlet {

    private final FileStorageService storageService = new FileStorageService();
    private final ImageService imageService = new ImageService();
    private final ActivityLogger activityLogger = new ActivityLogger();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");

        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Không tìm thấy ID sản phẩm");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        long productId;
        try {
            productId = Long.parseLong(productIdParam);
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID sản phẩm không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        // Kiểm tra xem có ảnh chính chưa
        boolean hasMainImage = imageService.getMainImage(productId) != null;

        try {
            Collection<Part> parts = request.getParts();
            boolean hasUploaded = false;

            for (Part part : parts) {
                if ("imageFile".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = part.getSubmittedFileName();
                    if (fileName == null || fileName.trim().isEmpty()) continue;

                    /** Kiểm tra định dạng file */
                    String ext = getFileExtension(fileName).toLowerCase();
                    if (!isAllowedExtension(ext)) {
                        NotificationUtil.setError(request.getSession(),
                                "Định dạng file không hỗ trợ: " + ext + ". Chỉ chấp nhận JPG, PNG, WEBP.");
                        response.sendRedirect(request.getContextPath() + "/admin/products/edit?id=" + productId);
                        return;
                    }

                    /** Kiểm tra kích thước file (tối đa 5MB mỗi file) */
                    if (part.getSize() > 5 * 1024 * 1024) {
                        NotificationUtil.setError(request.getSession(),
                                "File " + fileName + " vượt quá 5MB.");
                        response.sendRedirect(request.getContextPath() + "/admin/products/edit?id=" + productId);
                        return;
                    }

                    // Lưu file vật lý
                    String relativePath = storageService.saveProductImage(productId, part, "gallery");

                    // Nếu chưa có ảnh chính, ảnh đầu tiên sẽ làm ảnh chính
                    ProductImage image = ProductImage.builder()
                            .productId(productId)
                            .imageUrl(relativePath)
                            .isPrimary(!hasMainImage)
                            .build();

                    imageService.createProductImage(image);
                    hasMainImage = true;
                    hasUploaded = true;
                }
            }

            if (hasUploaded) {
                // Log activity
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");
                String userName = (user != null) ? user.getFullname() : "Admin";
                activityLogger.logImageAction(productId, userName, "Tải lên", "Đã upload hình ảnh cho sản phẩm");
                NotificationUtil.setSuccess(request.getSession(), "Tải ảnh lên thành công!");
            } else {
                NotificationUtil.setWarning(request.getSession(), "Không có ảnh nào được chọn.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            NotificationUtil.setError(request.getSession(), "Lỗi khi tải ảnh lên: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/products/edit?id=" + productId);
    }

    private String getFileExtension(String fileName) {
        int lastDot = fileName.lastIndexOf(".");
        if (lastDot >= 0) {
            return fileName.substring(lastDot + 1);
        }
        return "";
    }

    private boolean isAllowedExtension(String ext) {
        return "jpg".equals(ext) || "jpeg".equals(ext) || "png".equals(ext) || "webp".equals(ext);
    }
}