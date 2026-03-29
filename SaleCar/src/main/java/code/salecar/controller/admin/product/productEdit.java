package code.salecar.controller.admin.product;

import code.salecar.model.Brand;
import code.salecar.model.Category;
import code.salecar.model.product.dto.ProductDetail;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products/edit")
public class productEdit extends HttpServlet {
    ProductService  productService = new ProductService();
    CategoryService categoryService = new CategoryService();
    BrandService brandService = new BrandService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        System.out.println("Product ID param: " + idParam);

        int id;

        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        ProductDetail productDetail = productService.getProductByID(id);
        List<Category> categories = categoryService.getCategory();
        List<Brand> brands = brandService.getBrands();

        request.setAttribute("product", productDetail);
        request.setAttribute("categoryList", categories);
        request.setAttribute("brandList", brands);

        request.getRequestDispatcher(request.getContextPath() + "/admin/product/product-edit.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}