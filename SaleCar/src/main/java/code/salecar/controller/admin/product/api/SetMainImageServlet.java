package code.salecar.controller.admin.product.api;

import code.salecar.model.User;
import code.salecar.service.Image.ImageService;
import code.salecar.service.file.ActivityLogger;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "SetMainImageServlet", value = "/admin/products/set-main-image")
public class SetMainImageServlet extends HttpServlet {

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
            imageService.setMainImage(productId, imageUrl);

            // Log activity
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String userName = (user != null) ? user.getFullname() : "Admin";
            activityLogger.logImageAction(productId, userName, "Đặt ảnh chính", imageUrl);

            NotificationUtil.setSuccess(request.getSession(), "Đã đặt ảnh chính thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            NotificationUtil.setError(request.getSession(), "Lỗi khi đặt ảnh chính: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/products/edit?id=" + productId);
    }
}
