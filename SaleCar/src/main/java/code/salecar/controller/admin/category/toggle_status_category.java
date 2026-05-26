package code.salecar.controller.admin.category;

import code.salecar.service.product.CategoryService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/categories/toggle-status")
public class toggle_status_category extends HttpServlet {
    CategoryService categoryService = new CategoryService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam.trim());
                boolean toggled = categoryService.toggleStatus(id);
                if (toggled) {
                    NotificationUtil.setSuccess(request.getSession(), "Chuyển đổi trạng thái danh mục thành công!");
                } else {
                    NotificationUtil.setError(request.getSession(), "Không thể chuyển đổi trạng thái danh mục");
                }
            } else {
                NotificationUtil.setError(request.getSession(), "Thiếu ID danh mục");
            }
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID danh mục không hợp lệ");
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi chuyển đổi trạng thái: " + e.getMessage());
        }

        String redirectUrl = request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }
}
