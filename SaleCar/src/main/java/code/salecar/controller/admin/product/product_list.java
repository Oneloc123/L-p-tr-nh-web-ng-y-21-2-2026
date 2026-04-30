package code.salecar.controller.admin.product;

import code.salecar.model.category.Category;
import code.salecar.model.product.dto.ProductItem;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/admin/products")
public class product_list extends HttpServlet {
    ProductService productService = new ProductService();
    CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int limit = 20;
        int page = 1;
        String param = request.getParameter("page");
        if (param != null) {
            page = Integer.parseInt(param.trim());
        }

        String searchKeyword = request.getParameter("keyword");
        String[] filterCategoryParam = request.getParameterValues("categoryId");
        List<Integer> filterCategory = filterCategoryParam == null ? new ArrayList<>()
                : Arrays.stream(filterCategoryParam)
                .filter(s -> s != null && !s.isBlank())
                .map(Integer::parseInt)
                .toList();
        String[] filterBrandParam = request.getParameterValues("brandId");
        List<Integer> filterBrand = filterBrandParam == null ? new ArrayList<>()
                : Arrays.stream(filterBrandParam)
                .filter(s -> s != null && !s.isBlank())
                .map(Integer::parseInt)
                .toList();
        String filterStatus = request.getParameter("status"); // active , inactive , draft
        int status = -1;
        if (filterStatus != null) {
            switch (filterStatus) {
                case "active":
                    status = 1;
                    break;
                case "inactive":
                    status = 0;
                    break;
                case "draft":
                    status = 2;
                    break;
            }
        }
        String filterStock = request.getParameter("stockStatus"); // high , medium , low
        String minPriceParam = request.getParameter("minPrice");
        BigDecimal minPrice = null;
        if (minPriceParam != null && !minPriceParam.isBlank()) {
            minPrice = new BigDecimal(minPriceParam);
        }
        String maxPriceParam = request.getParameter("maxPrice");
        BigDecimal maxPrice = null;
        if (maxPriceParam != null && !maxPriceParam.isBlank()) {
            maxPrice = new BigDecimal(maxPriceParam);
        }
        String fromDateParam = request.getParameter("fromDate");
        java.sql.Date fromDate = null;
        if (fromDateParam != null && !fromDateParam.isEmpty()) {
            LocalDate localDate = LocalDate.parse(fromDateParam);
            fromDate = java.sql.Date.valueOf(localDate);
        }
        String toDateParam = request.getParameter("toDate");
        java.sql.Date toDate = null;
        if (toDateParam != null && !toDateParam.isEmpty()) {
            LocalDate localDate = LocalDate.parse(toDateParam);
            toDate = Date.valueOf(localDate);
        }
        String sortByParam = request.getParameter("sortBy"); // name_asc , name_desc , price_asc , price_desc , createdAt_desc , createdAt_asc
        ProductFilter.sortBy sortBy = null;
        if (sortByParam != null && !sortByParam.isEmpty()) {
            switch (sortByParam) {
                case "name_asc":
                    sortBy = ProductFilter.sortBy.NAME_ASC;
                    break;
                case "name_desc":
                    sortBy = ProductFilter.sortBy.NAME_DESC;
                    break;
                case "price_asc":
                    sortBy = ProductFilter.sortBy.PRICE_ASC;
                    break;
                case "price_desc":
                    sortBy = ProductFilter.sortBy.PRICE_DESC;
                    break;
                case "createdAt_desc":
                    sortBy = ProductFilter.sortBy.CREATED_DESC;
                    break;
                case "createdAt_asc":
                    sortBy = ProductFilter.sortBy.CREATED_ASC;
                    break;
            }
        }

        List<Category> categories = categoryService.getCategory();

        ProductFilter productFilter = new ProductFilter(searchKeyword, filterCategory, filterBrand, status, filterStock, maxPrice, minPrice, fromDate, toDate, sortBy);
        List<ProductItem> list = productService.getProductForAdmin(productFilter, page, limit);

        int totalProduct = productService.getTotalProductForAdmin(productFilter);
        int totalPage = (int) Math.ceil((double) totalProduct / limit);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        request.setAttribute("products", list);
        request.setAttribute("categories", categories);
        request.setAttribute("totalProduct", totalProduct);
        request.setAttribute("totalPages", totalPage);
        request.setAttribute("currentPage", page);


        request.getRequestDispatcher("/admin/product/product-list.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}