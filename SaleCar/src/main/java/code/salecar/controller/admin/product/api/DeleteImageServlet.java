package code.salecar.controller.admin.product.api;

import code.salecar.config.AppConfig;
import code.salecar.model.User;
import code.salecar.service.Image.ImageService;
import code.salecar.service.file.ActivityLogger;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet(name = "DeleteImageServlet", value = "/admin/products/delete-image")
public class DeleteImageServlet extends HttpServlet {

    private final ImageService imageService = new ImageService();
    private final ActivityLogger activityLogger = new ActivityLogger();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        String imageUrl = request.getParameter("imageUrl");

        if (productIdParam == null || imageUrl == null || imageUrl.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Thiếu thông tin ảnh hoặc sản phẩm.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        long productId;
        try {
            productId = Long.parseLong(productIdParam);
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID sản phẩm không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        try {
            // Kiểm tra nếu ảnh đang là ảnh chính thì không cho xóa
            if (imageService.isMainImage(productId, imageUrl)) {
                NotificationUtil.setError(request.getSession(),
                        "Không thể xóa ảnh chính. Vui lòng chọn ảnh khác làm ảnh chính trước.");
                response.sendRedirect(request.getContextPath() + "/admin/products/edit?id=" + productId);
                return;
            }

            // Xóa khỏi database trước
            imageService.deleteProductImage(productId, imageUrl);

            // Log activity
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String userName = (user != null) ? user.getFullname() : "Admin";
            activityLogger.logImageAction(productId, userName, "Xoá ảnh", imageUrl);

            // Xóa file vật lý
            String baseDir = AppConfig.get("upload.base-dir");
            if (baseDir != null && !baseDir.isEmpty()) {
                Path filePath = Paths.get(baseDir, imageUrl);
                try {
                    Files.deleteIfExists(filePath);
                } catch (IOException e) {
                    // File không tồn tại hoặc lỗi xóa - không ảnh hưởng đến DB
                    System.err.println("Warning: Không thể xóa file vật lý: " + filePath);
                }
            }

            NotificationUtil.setSuccess(request.getSession(), "Xóa ảnh thành công!");

        } catch (Exception e) {
            e.printStackTrace();
            NotificationUtil.setError(request.getSession(), "Lỗi khi xóa ảnh: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/products/edit?id=" + productId);
    }
}
