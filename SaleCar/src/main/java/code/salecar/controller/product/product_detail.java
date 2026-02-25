package code.salecar.controller.product;

import code.salecar.model.Product;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "product-detail", value = "/product-detail")
public class product_detail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idpr = request.getParameter("id");

        if(idpr==null){
            response.sendRedirect("/home");
            return;
        }

        int id = Integer.parseInt(idpr);

        ProductService ps  = new ProductService();
        Product product = ps.getProductByID(id);

        if(product==null){
            response.sendRedirect("/home");
            return;
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("/pages/product-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {





    }
}