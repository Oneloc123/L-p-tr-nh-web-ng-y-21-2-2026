package code.salecar.controller.admin.category;

import code.salecar.model.brand.BrandFilter;
import code.salecar.model.category.Category;
import code.salecar.model.category.CategoryFilter;
import code.salecar.service.product.CategoryService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class category_list extends HttpServlet {
    CategoryService categoryService = new CategoryService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int limit = 10;
        int page = 1;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam.trim());
        }

        String limitParam = request.getParameter("limit");
        if (limitParam != null  && !limitParam.isEmpty()) {
            limit = Integer.parseInt(limitParam.trim());
        }

        String searchKeyword = request.getParameter("search");
        String statusParam = request.getParameter("status");
        String sortParam = request.getParameter("sort");
        String orderParam = request.getParameter("order");

        CategoryFilter categoryFilter = new CategoryFilter();
        categoryFilter.setName(searchKeyword);
        categoryFilter.setStatus(statusParam);
        categoryFilter.setSort(sortParam);
        categoryFilter.setOrder(orderParam);
        categoryFilter.setLimit(limit);
        categoryFilter.setPage(page);


        List<Category> categories = categoryService.getCategories(categoryFilter);
        request.setAttribute("categories", categories);

        //CurrenURL
        String currentUrl = request.getRequestURI();
        String queryString = request.getQueryString();
        if (queryString != null) {
            currentUrl += "?" + queryString;
        }
        request.setAttribute("currentUrl", currentUrl);

        request.getRequestDispatcher("/admin/category/category-list.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}