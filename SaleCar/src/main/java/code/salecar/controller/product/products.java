package code.salecar.controller.product;

import code.salecar.model.Category;
import code.salecar.model.Discount;
import code.salecar.model.Product;
import code.salecar.model.Voucher;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.ProductService;
import code.salecar.service.product.VoucherService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "products", value = "/products")
public class products extends HttpServlet {

    private ProductService ps = new ProductService();
    private CategoryService cs = new CategoryService();
    private BrandService bs = new BrandService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int limit = 9;
        int page = 1;

        // Chia số trang limit là giới hạn product, page số trang
        String param = request.getParameter("page");

        if (param != null) {
            page = Integer.parseInt(param.trim());
        }


        // Nhận request từ tìm kiếm
        String[] discounts = request.getParameterValues("discount");
        boolean newest = false;
        boolean highest = false;
        if (discounts != null) {
            for (String discount : discounts) {
                if (discount.equalsIgnoreCase("newest")) {
                    newest = true;
                }
                if (discount.equalsIgnoreCase("highest")) {
                    highest = true;
                }
            }
        }
        String[] ctpr = request.getParameterValues("category");
        String[] brpr = request.getParameterValues("brand");

        ProductFilter filter = new ProductFilter();
        filter.setKeyword(request.getParameter("find"));
        filter.setCategories(ctpr == null ? new ArrayList<>() : Arrays.asList(ctpr));
        filter.setBrands(brpr == null ? new ArrayList<>() : Arrays.asList(brpr));
        String priceparam = request.getParameter("price");
        if (priceparam != null && !priceparam.isEmpty()) {
            filter.setMaxPrice(Double.parseDouble(priceparam));
        }
        filter.setSortByHighest(highest);
        filter.setSortByNewest(newest);


        List<Product> list;
        int totalProduct = 0;

        list = ps.getProductFilter(filter, page, limit);
        totalProduct = ps.getTotalProduct(filter);

        // Chia số trang để tính tổng
        int totalPage = (int) Math.ceil((double) totalProduct / limit);


        // Menubar
        // Lấy tổng số loại
        int totalCategory = cs.getTotalCategory();
        // Lấy tên loại
        List<String> categoryName = cs.getCategoryName();

        // Lấy tổng số brand
        int totalBrand = bs.getTotalBrand();
        // Lấy tên brand
        List<String> brandName = bs.getBrandName();

        // Voucher
        VoucherService vs = new VoucherService();
        List<Voucher> vouchers = vs.getVouchers();
        request.setAttribute("vouchers", vouchers);


        request.setAttribute("totalPage", totalPage);
        request.setAttribute("totalProduct", totalProduct);
        request.setAttribute("totalCategory", totalCategory);
        request.setAttribute("categoryName", categoryName);
        request.setAttribute("totalBrand", totalBrand);
        request.setAttribute("brandName", brandName);
        request.setAttribute("find", filter.getKeyword());
        request.setAttribute("selectedDiscount", discounts);
        request.setAttribute("selectedCategories", filter.getCategories());
        request.setAttribute("selectedBrands", filter.getBrands());

        request.setAttribute("products", list);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }
}