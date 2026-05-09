package code.salecar.controller.admin.product;

import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.product.entity.Product;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products/create")
public class product_create extends HttpServlet {
    CategoryService categoryService = new CategoryService();
    BrandService brandService = new BrandService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryService.getCategory();
        List<Brand> brands = brandService.getBrands();

        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher(request.getContextPath() + "/admin/product/product-create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nameParam = request.getParameter("name");
        String categoryIdParam = request.getParameter("categoryId");
        String brandIdParam = request.getParameter("brandId");
        String statusParam = request.getParameter("status");
        String priceParam = request.getParameter("price");
        String discountPercentParam = request.getParameter("discountPercent");

        String ratioParam = request.getParameter("ratio");
        String sizeParam = request.getParameter("size");
        String materialParam = request.getParameter("material");
        String originParam = request.getParameter("origin");

        String descriptionParam = request.getParameter("description");

        //validation name
        if (nameParam == null || nameParam.trim().isEmpty()) {
            request.setAttribute("error", "Tên sản phẩm không được để trống");
            doGet(request, response);
            return;
        }

        //validation categoryId, parse to int
        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Danh mục không hợp lệ");
            doGet(request, response);
            return;
        }

        //validation brandId, parse to int
        int brandId;
        try {
            brandId = Integer.parseInt(brandIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Thương hiệu không hợp lệ");
            doGet(request, response);
            return;
        }

        //validation status
        if (statusParam == null || statusParam.trim().isEmpty()) {
            request.setAttribute("error", "Trạng thái không được để trống");
            doGet(request, response);
            return;
        }
//        if (!statusParam.matches("^(active|inactive|hidden|draft)$")) {
//            request.setAttribute("error", "Trạng thái không hợp lệ");
//            doGet(request, response);
//            return;
//        }

        //validation price, parse to double
        double price;
        try {
            price = Double.parseDouble(priceParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Giá gốc không hợp lệ");
            doGet(request, response);
            return;
        }

        //validation discountPercent, parse to double
        double discountPercent;
        try {
            discountPercent = Double.parseDouble(discountPercentParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Phần trăm giảm giá không hợp lệ");
            doGet(request, response);
            return;
        }

        //validation ratio
        if (ratioParam == null || ratioParam.trim().isEmpty()) {
            request.setAttribute("error", "Tỉ lệ không được để trống");
            doGet(request, response);
            return;
        }

        //validation size
        if (sizeParam == null || sizeParam.trim().isEmpty()) {
            request.setAttribute("error", "Kích thước không được để trống");
            doGet(request, response);
            return;
        }

        //validation material
        if (materialParam == null || materialParam.trim().isEmpty()) {
            request.setAttribute("error", "Chất liệu không được để trống");
            doGet(request, response);
            return;
        }

        //validation origin
        if (originParam == null || originParam.trim().isEmpty()) {
            request.setAttribute("error", "Xuất xứ không được để trống");
            doGet(request, response);
            return;
        }

        //validation description
        if (descriptionParam == null || descriptionParam.trim().isEmpty()) {
            request.setAttribute("error", "Mô tả không được để trống");
            doGet(request, response);
            return;
        }

        // Map status to int
        int statusInt;
        switch (statusParam) {
            case "active":
                statusInt = 1;
                break;
            case "inactive":
                statusInt = 0;
                break;
            case "hidden":
                statusInt = 2;
                break;
            case "draft":
                statusInt = 3;
                break;
            default:
                statusInt = 1; // default to active
                break;
        }

        // Calculate final price
        double finalPrice = price * (1 - discountPercent / 100);

        // Create Product object
        Product product = new Product();
        product.setName(nameParam);
        product.setPrice(price);
        product.setFinalPrice(finalPrice);
        product.setDiscountPercent(discountPercent);
        product.setBrandId(brandId);
        product.setCategoryId(categoryId);
        product.setDescription(descriptionParam);
        product.setRatio(ratioParam);
        product.setSize(sizeParam);
        product.setMaterial(materialParam);
        product.setOrigin(originParam);
        product.setStatus(statusInt);

        // Create product using service
        ProductService productService = new ProductService();
        int productId = productService.createProduct(product);
        System.out.println(productId);

        if (productId > 0) {
            // Success, redirect to product list
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } else {
            request.setAttribute("error", "Không thể tạo sản phẩm");
            doGet(request, response);
        }
    }
}