package code.salecar.controller.home;

import code.salecar.model.Discount;
import code.salecar.model.Product;
import code.salecar.service.home.HomeService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "home", value = "/home")
public class home extends HttpServlet {

    HomeService hs = new HomeService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Product> productNew = hs.getProductNew();
        request.setAttribute("productNew", productNew);

        List<Product> productHot = hs.getProductHot();
        request.setAttribute("productHot", productHot);

        List<Product> productByCategory = hs.getProductByCategory(0);
        request.setAttribute("productByCategory", productByCategory);

        List<Product> productByFavorites = hs.getProductByFavorites(1);
        request.setAttribute("productByFavorites", productByFavorites);

        List<Product> productSale = hs.getProductSale();
        request.setAttribute("productSale", productSale);

        List<Discount> discounts = hs.getVoucher();
        request.setAttribute("discounts", discounts);



        request.getRequestDispatcher("index.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}