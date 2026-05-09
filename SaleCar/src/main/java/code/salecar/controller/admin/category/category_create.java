package code.salecar.controller.admin.category;

import code.salecar.model.category.Category;
import code.salecar.service.product.CategoryService;
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
        // Get form parameters
        String name = request.getParameter("name");
        String icon = request.getParameter("icon");
        String description = request.getParameter("description");
        String statusStr = request.getParameter("status");

        // Create category object
        Category category = new Category();
        category.setName(name);
        category.setIcon(icon);
        category.setDescription(description);
        category.setStatus(statusStr != null ? statusStr : "active");

        // Validate input
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

        // Check for duplicate name if no other errors
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

        // If validation errors, return to form
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/admin/category/category-create.jsp").forward(request, response);
            return;
        }

        // Try to create category
        try {
            boolean success = categoryService.createCategory(category);
            if (success) {
                request.setAttribute("successMessage", "Category created successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/categories?success=create");
            } else {
                request.setAttribute("errorMessage", "Failed to create category. Please try again.");
                request.setAttribute("category", category);
                request.getRequestDispatcher("/admin/category/category-create.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error creating category: " + e.getMessage());
            request.setAttribute("category", category);
            request.getRequestDispatcher("/admin/category/category-create.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/category/category-create.jsp").forward(request, response);
    }
}
