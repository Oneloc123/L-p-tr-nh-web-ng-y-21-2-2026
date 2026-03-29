package code.salecar.controller.admin.product;

import code.salecar.model.Brand;
import code.salecar.model.Category;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products/create")
public class productCreate extends HttpServlet {
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

    }
}