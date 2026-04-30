package code.salecar.controller.admin.brand;

import code.salecar.model.brand.Brand;
import code.salecar.model.brand.BrandFilter;
import code.salecar.service.product.BrandService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/brands")
public class brand_list extends HttpServlet {
    BrandService brandService = new BrandService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        search=""
//        &status= "active" or "inactive"
//        &sort="product_count" or "id" or "name" or "status" or "crateAt"
//        &order="asc" or "desc"
//        &page=1
//        &limit=100

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

       BrandFilter brandFilter = new BrandFilter();
        brandFilter.setName(searchKeyword);
        brandFilter.setStatus(statusParam);
        brandFilter.setSort(sortParam);
        brandFilter.setOrder(orderParam);
        brandFilter.setLimit(limit);
        brandFilter.setPage(page);

        List<Brand> brands = brandService.getBrands(brandFilter);
        request.setAttribute("brands", brands);

        //CurrenURL
        String currentUrl = request.getRequestURI();
        String queryString = request.getQueryString();
        if (queryString != null) {
            currentUrl += "?" + queryString;
        }
        request.setAttribute("currentUrl", currentUrl);

        request.getRequestDispatcher("/admin/brand/brand-list.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}