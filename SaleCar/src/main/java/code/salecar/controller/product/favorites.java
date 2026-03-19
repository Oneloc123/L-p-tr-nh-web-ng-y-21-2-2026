package code.salecar.controller.product;

import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.entity.Product;
import code.salecar.model.User;
import code.salecar.model.product.entity.Voucher;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.service.product.FavoritesService;
import code.salecar.service.product.ProductService;
import code.salecar.service.product.VoucherService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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
        List<ProductDetail> favoritesProducts = favoritesService.getFavorites(user.getId());
        Set<String> favoritesBrands = favoritesService.getFavoritesBrand(favoritesProducts);
        Set<String> favoritesCategory = favoritesService.getFavoritesCategory(favoritesProducts);

        // Search, filter favorites
        String keyWord = request.getParameter("keyword");
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String priceParam = request.getParameter("price");
        String discountpr = request.getParameter("discount");
        String newestpr = request.getParameter("newest");

        ProductFilter filter = new ProductFilter();
        filter.setKeyword(keyWord);
        filter.setCategories(category == null ? new ArrayList<>() : List.of(category));
        filter.setBrands(brand == null ? new ArrayList<>() : List.of(brand));
        if (priceParam != null && !priceParam.isEmpty()) {
            int price = Integer.parseInt(priceParam);
            filter.setMaxPrice(new BigDecimal(price));
        }
        boolean highest = false;
        if (discountpr != null && !discountpr.isEmpty()) {
            highest = true;
        }
        filter.setSortByHighestDiscount(highest);
        boolean newest = false;
        if (newestpr != null && !newestpr.isEmpty()) {
            newest = true;
        }
        filter.setSortByNewestDiscount(newest);

        ProductService productService = new ProductService();
        List<ProductDetail> products = productService.sortProducFilter(favoritesProducts, filter);

        // Voucher
        VoucherService vs = new VoucherService();
        List<Voucher> vouchers = vs.getVouchers();
        request.setAttribute("vouchers", vouchers);

        request.setAttribute("favorites", products);
        request.setAttribute("brand", favoritesBrands);
        request.setAttribute("category", favoritesCategory);
        request.getRequestDispatcher("/pages/favorites.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Add favorites
        String add = request.getParameter("productid");
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("/login");
            return;
        }
        if (add != null && !add.isEmpty()) {
            int productId = Integer.parseInt(add);
            favoritesService.addProduct(productId, user.getId());
        }


        // Remove favorites
        String parameter = request.getParameter("remove");
        if (parameter != null && !parameter.isEmpty()) {
            int favoriteProductId = Integer.parseInt(parameter);
            favoritesService.removeFavoritesProduct(favoriteProductId);
        }


        response.sendRedirect("/favorites");
    }
}