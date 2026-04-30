package code.salecar.controller.admin.category;

import code.salecar.model.Category;
import code.salecar.model.brand.Brand;
import code.salecar.service.product.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories/edit")
public class category_edit extends HttpServlet {
    CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId;
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            categoryId = Integer.parseInt(idParam.trim());
            Category categories = categoryService.getCategoryById(categoryId);
            request.setAttribute("category", categories);


            request.getRequestDispatcher("/admin/category/category-edit.jsp").forward(request, response);

        } else {
            response.sendRedirect("/admin/categories");
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Category category = new Category();
        
        String  idParam = request.getParameter("id");
        if (idParam != null  && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam.trim());
            category.setId(id);
        }
        String  nameParam = request.getParameter("name");
        if (nameParam != null  && !nameParam.isEmpty()) {
            category.setName(nameParam);
        }
    }
}