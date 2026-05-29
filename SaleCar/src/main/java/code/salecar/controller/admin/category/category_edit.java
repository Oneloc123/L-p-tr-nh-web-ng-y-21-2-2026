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

@WebServlet("/admin/categories/edit")
public class category_edit extends HttpServlet {
    CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(idParam.trim());
                Category category = categoryService.getCategoryById(categoryId);
                if (category == null) {
                    NotificationUtil.setError(request.getSession(), "Không tìm thấy danh mục");
                    response.sendRedirect("/admin/categories");
                    return;
                }
                request.setAttribute("category", category);
                request.getRequestDispatcher("/admin/category/category-edit.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                NotificationUtil.setError(request.getSession(), "ID danh mục không hợp lệ");
                response.sendRedirect("/admin/categories");
            }
        } else {
            response.sendRedirect("/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Thiếu ID danh mục");
            response.sendRedirect("/admin/categories");
            return;
        }

        try {
            Category category = new Category();
            category.setId(Integer.parseInt(idParam.trim()));

            String nameParam = request.getParameter("name");
            if (nameParam == null || nameParam.trim().isEmpty()) {
                NotificationUtil.setError(request.getSession(), "Tên danh mục không được để trống");
                response.sendRedirect("/admin/categories/edit?id=" + idParam);
                return;
            }
            category.setName(nameParam.trim());

            String iconParam = request.getParameter("icon");
            if (iconParam == null || iconParam.trim().isEmpty()) {
                NotificationUtil.setError(request.getSession(), "Icon không được để trống");
                response.sendRedirect("/admin/categories/edit?id=" + idParam);
                return;
            }
            category.setIcon(iconParam.trim());

            String descriptionParam = request.getParameter("description");
            category.setDescription(descriptionParam != null ? descriptionParam.trim() : "");

            String statusParam = request.getParameter("status");
            if (statusParam == null || statusParam.isEmpty()) {
                category.setStatus(Status.ACTIVE);
            } else {
                category.setStatus(statusParam.equals("active") ? Status.ACTIVE : Status.INACTIVE);
            }

            boolean updated = categoryService.updateCategory(category);
            if (updated) {
                NotificationUtil.setSuccess(request.getSession(), "Cập nhật danh mục thành công!");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể cập nhật danh mục");
            }
            response.sendRedirect("/admin/categories");

        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID danh mục không hợp lệ");
            response.sendRedirect("/admin/categories");
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi cập nhật danh mục: " + e.getMessage());
            response.sendRedirect("/admin/categories");
        }
    }
}