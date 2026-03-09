package code.salecar.controller.product;

import code.salecar.model.Product;
import code.salecar.model.User;
import code.salecar.service.product.FavoritesService;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "favorites", value = "/favorites")
public class favorites extends HttpServlet {
    private FavoritesService favoritesService = new FavoritesService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        List<Product> favoritesProducts = favoritesService.getFavorites(user.getId());

        request.setAttribute("favorites", favoritesProducts);
        request.getRequestDispatcher("/pages/favorites.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String param = request.getParameter("productid");
            int productId = Integer.parseInt(param);



        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("/login");
            return;
        }
        boolean addProduct = favoritesService.addProduct(productId,user.getId());

        response.sendRedirect("/favorites");



    }
}