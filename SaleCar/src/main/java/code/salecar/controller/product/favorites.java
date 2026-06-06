package code.salecar.controller.product;

import code.salecar.model.product.dto.ProductDetailDTO;
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
    private final FavoritesService favoritesService = new FavoritesService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            request.getSession().setAttribute("toastMessage", "Vui lòng đăng nhập để xem sản phẩm yêu thích");
            request.getSession().setAttribute("toastType", "warning");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<ProductDetailDTO> favoritesProducts = favoritesService.getFavorites(user.getId());
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
        filter.setCategories(category == null || category.equals("all") ? new ArrayList<>() : List.of(category));
        filter.setBrands(brand == null || brand.equals("all") ? new ArrayList<>() : List.of(brand));
        if (priceParam != null && !priceParam.isEmpty() && !priceParam.equals("-1")) {
            try {
                int price = Integer.parseInt(priceParam);
                filter.setMaxPrice(new BigDecimal(price));
            } catch (NumberFormatException ignored) {}
        }
        filter.setSortByHighestDiscount(discountpr != null && !discountpr.isEmpty());
        filter.setSortByNewestDiscount(newestpr != null && !newestpr.isEmpty());

        ProductService productService = new ProductService();
        List<ProductDetailDTO> products = productService.sortProducFilter(favoritesProducts, filter);

        // Voucher
        VoucherService vs = new VoucherService();
        List<Voucher> vouchers = vs.getVouchers();

        request.setAttribute("favorites", products);
        request.setAttribute("brand", favoritesBrands);
        request.setAttribute("category", favoritesCategory);
        request.setAttribute("vouchers", vouchers);
        request.getRequestDispatcher("/pages/favorites.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Auth check
        if (user == null) {
            session.setAttribute("toastMessage", "Vui lòng đăng nhập để thêm sản phẩm vào yêu thích");
            session.setAttribute("toastType", "warning");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String referer = request.getHeader("Referer");

        // Add to wishlist
        String addParam = request.getParameter("productid");
        if (addParam != null && !addParam.isEmpty()) {
            try {
                int productId = Integer.parseInt(addParam);
                boolean added = favoritesService.addProduct(productId, user.getId());
                if (added) {
                    session.setAttribute("toastMessage", "Đã thêm vào danh sách yêu thích");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Sản phẩm đã có trong danh sách yêu thích");
                    session.setAttribute("toastType", "warning");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("toastMessage", "Mã sản phẩm không hợp lệ");
                session.setAttribute("toastType", "error");
            }
        }

        // Remove from wishlist
        String removeParam = request.getParameter("remove");
        if (removeParam != null && !removeParam.isEmpty()) {
            try {
                int productId = Integer.parseInt(removeParam);
                boolean removed = favoritesService.removeFavoritesProduct(productId, user.getId());
                if (removed) {
                    session.setAttribute("toastMessage", "Đã xóa khỏi danh sách yêu thích");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Không tìm thấy sản phẩm trong danh sách yêu thích");
                    session.setAttribute("toastType", "warning");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("toastMessage", "Mã sản phẩm không hợp lệ");
                session.setAttribute("toastType", "error");
            }
        }

        // Redirect: về trang referer nếu có, nếu không thì về /favorites
        if (referer != null && !referer.isEmpty() && !referer.contains("/favorites")) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/favorites");
        }
    }
}