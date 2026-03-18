package code.salecar.controller.product;

import code.salecar.model.Product;
import code.salecar.model.Voucher;
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

        if(idParam==null){
            response.sendRedirect("/products");
            return;
        }

        int id = Integer.parseInt(idParam);

        ProductService ps  = new ProductService();
        Product product = ps.getProductByID(id);

        if(product==null){
            response.sendRedirect("/home");
            return;
        }

        List<Product> list1 = ps.getRelatedProductMaterial(product.getMaterial());
        request.setAttribute("related", list1);

        // Voucher
        VoucherService vs = new VoucherService();
        List<Voucher> vouchers = vs.getVouchers();
        request.setAttribute("vouchers", vouchers);

        String returnUrl = request.getHeader("Referer");
        request.setAttribute("returnUrl", returnUrl);

        request.setAttribute("product", product);
        request.getRequestDispatcher("/pages/product-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {





    }
}