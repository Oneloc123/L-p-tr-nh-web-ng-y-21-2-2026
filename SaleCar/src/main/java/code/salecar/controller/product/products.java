package code.salecar.controller.product;

import code.salecar.model.Category;
import code.salecar.model.Product;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
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
            page = Integer.parseInt(param);
        }


        // Nhận request từ tìm kiếm
        String find = request.getParameter("find");
        String[] discounts  = request.getParameterValues("discount");
        String[] categories = request.getParameterValues("category");
        String[] brands = request.getParameterValues("brand");


        List<Product> list;
        int totalProduct = 0;
        if ((categories == null || categories.length == 0) &&
                (brands == null || brands.length == 0) &&
                (find == null || find.isEmpty())) {

            list = ps.getProductsByPage(page, limit);
            totalProduct = ps.getTotalProduct();

        } else {

            list = ps.getProductFilter(find, categories, brands, page, limit);
            totalProduct = ps.getTotalProduct(find, categories, brands);
        }

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


        request.setAttribute("totalPage", totalPage);
        request.setAttribute("totalProduct", totalProduct);
        request.setAttribute("totalCategory", totalCategory);
        request.setAttribute("categoryName", categoryName);
        request.setAttribute("totalBrand", totalBrand);
        request.setAttribute("brandName", brandName);
        request.setAttribute("find", find);
        request.setAttribute("selectedDiscount", discounts);
        request.setAttribute("selectedCategories", categories);
        request.setAttribute("selectedBrands", brands);

        request.setAttribute("products", list);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }
}