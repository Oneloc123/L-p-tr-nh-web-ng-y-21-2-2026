package code.salecar.controller.admin.category;

import code.salecar.model.category.Category;
import code.salecar.model.enumeration.Status;
import code.salecar.service.product.CategoryService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/categories/create")
public class category_create extends HttpServlet {
    private CategoryService categoryService = new CategoryService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /** Lấy tham số từ form */
        String name = request.getParameter("name");
        String icon = request.getParameter("icon");
        String description = request.getParameter("description");
        String statusStr = request.getParameter("status");

        /** Tạo đối tượng danh mục */
        Category category = new Category();
        category.setName(name);
        category.setIcon(icon);
        category.setDescription(description);
        category.setStatus(statusStr != null ? Status.INACTIVE : Status.ACTIVE);

        /** Kiểm tra dữ liệu đầu vào */
        Map<String, String> errors = new HashMap<>();
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Category name is required");
        } else if (name.length() > 100) {
            errors.put("name", "Category name must be less than 100 characters");
        }

        if (icon == null || icon.trim().isEmpty()) {
            errors.put("icon", "Icon is required");
        } else if (icon.length() > 50) {
            errors.put("icon", "Icon must be less than 50 characters");
        }

        if (description != null && description.length() > 500) {
            errors.put("description", "Description must be less than 500 characters");
        }

        /** Kiểm tra tên bị trùng nếu không có lỗi khác */
        if (errors.isEmpty() && name != null && !name.trim().isEmpty()) {
            try {
                Map<String, String> validationErrors = categoryService.validateCategory(category);
                if (!validationErrors.isEmpty()) {
                    errors.putAll(validationErrors);
                }
            } catch (Exception e) {
                errors.put("general", "Error validating category: " + e.getMessage());
            }
        }

        /** Nếu có lỗi xác thực, quay lại form */
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/admin/category/category-create.jsp").forward(request, response);
            return;
        }

        /** Thử tạo danh mục */
        try {
            boolean success = categoryService.createCategory(category);
            if (success) {
                NotificationUtil.setSuccess(request.getSession(), "Tạo danh mục thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/categories");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể tạo danh mục");
                response.sendRedirect(request.getContextPath() + "/admin/categories");
            }
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi tạo danh mục: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/category/category-create.jsp").forward(request, response);
    }
}
