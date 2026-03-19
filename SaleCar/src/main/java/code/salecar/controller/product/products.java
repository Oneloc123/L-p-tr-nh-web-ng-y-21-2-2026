package code.salecar.controller.product;

import code.salecar.model.product.dto.ProductItem;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.Voucher;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.ProductService;
import code.salecar.service.product.VoucherService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "products", value = "/products")
public class products extends HttpServlet {

    private ProductService ps = new ProductService();
    private CategoryService cs = new CategoryService();
    private BrandService bs = new BrandService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* =========================
           PAGINATION
        ========================= */
        int limit = 9;
        int page = 1;

        String param = request.getParameter("page");
        if (param != null) {
            page = Integer.parseInt(param.trim());
        }

        /* =========================
           SORT DISCOUNT
        ========================= */
//        String[] discounts = request.getParameterValues("discount");
//
//        boolean newest = false;
//        boolean highest = false;
//
//        if (discounts != null) {
//            for (String discount : discounts) {
//                if (discount.equalsIgnoreCase("newest")) {
//                    newest = true;
//                }
//
//                if (discount.equalsIgnoreCase("highest")) {
//                    highest = true;
//                }
//            }
//        }

        /* =========================
           FILTER PARAMS
        ========================= */


        String[] scaleParam = request.getParameterValues("scale");
        String[] categoryParam = request.getParameterValues("category");
        String[] brandParam = request.getParameterValues("brand");
        String maxParam = request.getParameter("maxPrice");
        String minParam = request.getParameter("minPrice");


        ProductFilter filter = new ProductFilter();


        filter.setKeyword(request.getParameter("keyword"));


        String sortBy = request.getParameter("sort");

        if (maxParam != null) {
            BigDecimal maxPrice = new BigDecimal(maxParam);
            filter.setMaxPrice(maxPrice);
        }
        if (minParam != null) {
            BigDecimal minPrice = new BigDecimal(minParam);
            filter.setMinPrice(minPrice);
        }


        if (sortBy != null) {
            switch (sortBy) {
                case "newest":
                    filter.setSortBy(ProductFilter.sortBy.NEWEST);
                    break;
                case "price_asc":
                    filter.setSortBy(ProductFilter.sortBy.PRICE_ASC);
                    break;
                case "price_desc":
                    filter.setSortBy(ProductFilter.sortBy.PRICE_DESC);
                    break;
            }
        }

        filter.setCategories(
                categoryParam == null
                        ? new ArrayList<>()
                        : Arrays.asList(categoryParam)
        );

        filter.setBrands(
                brandParam == null
                        ? new ArrayList<>()
                        : Arrays.asList(brandParam)
        );
        filter.setScale(
                scaleParam == null ? new ArrayList<>() : Arrays.asList(scaleParam)
        );

//        String priceParam = request.getParameter("price");
//        if (priceParam != null && !priceParam.isEmpty()) {
//            filter.setMaxPrice(Double.parseDouble(priceParam));
//        }

//        filter.setSortByHighestDiscount(highest);
//        filter.setSortByNewestDiscount(newest);

        /* =========================
           GET PRODUCT DATA
        ========================= */
        List<ProductItem> list = ps.getProductFilter(filter, page, limit);
        int totalProduct = ps.getTotalProduct(filter);

        int totalPage = (int) Math.ceil((double) totalProduct / limit);

        /* =========================
           MENU BAR DATA
        ========================= */

        //Scale
        int totalScale = ps.getTotalScale();
        List<String> scaleName = ps.getScaleName();
        // Category
        int totalCategory = cs.getTotalCategory();
        List<String> categoryName = cs.getCategoryName();

        // Brand
        int totalBrand = bs.getTotalBrand();
        List<String> brandName = bs.getBrandName();

        BigDecimal maxPrice = ps.getMaxPrice();


        /* =========================
           VOUCHER DATA
        ========================= */
        VoucherService vs = new VoucherService();
        List<Voucher> vouchers = vs.getVouchers();

        request.setAttribute("vouchers", vouchers);

        /* =========================
           SET ATTRIBUTE FOR VIEW
        ========================= */
        request.setAttribute("products", list);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("totalProduct", totalProduct);

        request.setAttribute("totalScale", totalScale);
        request.setAttribute("scaleName", scaleName);

        request.setAttribute("totalCategory", totalCategory);
        request.setAttribute("categoryName", categoryName);

        request.setAttribute("totalBrand", totalBrand);
        request.setAttribute("brandName", brandName);
        request.setAttribute("maxPrice", maxPrice);

        request.setAttribute("find", filter.getKeyword());
//        request.setAttribute("selectedDiscount", discounts);
        request.setAttribute("selectedCategories", filter.getCategories());
        request.setAttribute("selectedBrands", filter.getBrands());

        /* =========================
           FORWARD VIEW
        ========================= */
        request.getRequestDispatcher("/pages/products.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}