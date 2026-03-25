package code.salecar.controller.product;

import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.Voucher;
import code.salecar.service.product.ProductService;
import code.salecar.service.product.VoucherService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "product-detail", value = "/product-detail")
public class product_detail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        System.out.println("Product ID param: " + idParam);

        int id;

        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        ProductService ps  = new ProductService();
        ProductDetail product = ps.getProductByID(id);
        System.out.println("Product: " + product);
        if(product==null){
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

//        List<ProductDetail> list1 = ps.getRelatedProductMaterial(product.getProduct().getMaterial());
//        request.setAttribute("related", list1);

        // Voucher
        VoucherService vs = new VoucherService();
        List<Voucher> vouchers = vs.getVouchers();

        request.setAttribute("vouchers", vouchers);

        String returnUrl = request.getHeader("Referer");
        request.setAttribute("returnUrl", returnUrl);

        request.setAttribute("product", product);
        request.setAttribute("rating", product.getRating());

        request.getRequestDispatcher("/pages/product-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {





    }
}