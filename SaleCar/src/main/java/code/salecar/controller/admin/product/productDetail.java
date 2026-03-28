package code.salecar.controller.admin.product;

import code.salecar.model.product.dto.ProductDetail;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/admin/products/detail")
public class productDetail extends HttpServlet {
    ProductService productService = new ProductService();
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
        request.setAttribute("product", productDetail);
        request.getRequestDispatcher(request.getContextPath() + "/admin/product/product-detail.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}