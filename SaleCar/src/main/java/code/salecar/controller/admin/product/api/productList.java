package code.salecar.controller.admin.product.api;

import code.salecar.model.product.dto.ProductItem;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.service.product.ProductService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/api/products")
public class productList extends HttpServlet {

    ProductService productService = new ProductService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int limit = 10;
        int page = 1;
        String param = request.getParameter("page");
        if (param != null) {
            page = Integer.parseInt(param.trim());
        }

        String searchKeyword = request.getParameter("keyword");
        String[] filterCategoryParam = request.getParameterValues("categoryId");
        List<Integer> filterCategory = filterCategoryParam == null ? new ArrayList<>() : Arrays.stream(filterCategoryParam).map(Integer::parseInt).toList();
        String[] filterBrandParam = request.getParameterValues("brandId");
        List<Integer> filterBrand = filterBrandParam == null ? new ArrayList<>() : Arrays.stream(filterBrandParam).map(Integer::parseInt).toList();
        String filterStatus = request.getParameter("status"); // active , inactive , draft
        String filterStock = request.getParameter("stockStatus"); // high , medium , low
        String minPriceParam = request.getParameter("minPrice");
        BigDecimal minPrice = null;
        if (minPriceParam != null) {
            minPrice = new BigDecimal(minPriceParam);
        }
        String maxPriceParam = request.getParameter("maxPrice");
        BigDecimal maxPrice = null;
        if (maxPriceParam != null) {
            maxPrice = new BigDecimal(maxPriceParam);
        }
        String fromDateParam = request.getParameter("fromDate");
        Date fromDate = null;
        if (fromDateParam != null && !fromDateParam.isEmpty()) {
            LocalDate localDate = LocalDate.parse(fromDateParam);
            fromDate = Date.valueOf(localDate);
        }
        String toDateParam = request.getParameter("toDate");
        Date toDate = null;
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

        ProductFilter productFilter = new ProductFilter(searchKeyword, filterCategory, filterBrand, 1, filterStock, maxPrice, minPrice, fromDate, toDate, sortBy);
        List<ProductItem> list = productService.getProductForAdmin(productFilter, page, limit);

        int totalProduct = 200;//ps.getTotalProduct(filter);
        int totalPage = (int) Math.ceil((double) totalProduct / limit);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();
        result.put("page", page);
        result.put("totalPages", totalPage);
        result.put("totalItems", totalProduct);
        result.put("products", list);

        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(response.getOutputStream(), result);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}