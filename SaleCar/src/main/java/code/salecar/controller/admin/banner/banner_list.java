package code.salecar.controller.admin.banner;

import code.salecar.model.product.entity.Banner;
import code.salecar.service.product.BannerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/banners")
public class banner_list extends HttpServlet {
    private final BannerService bannerService = new BannerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int limit = 10;
        int page = 1;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam.trim());
            }
            String limitParam = request.getParameter("limit");
            if (limitParam != null && !limitParam.isEmpty()) {
                limit = Integer.parseInt(limitParam.trim());
            }
        } catch (NumberFormatException e) {
            page = 1;
            limit = 10;
        }

        String searchKeyword = request.getParameter("search");
        String statusParam = request.getParameter("status");
        String sortParam = request.getParameter("sort");
        String orderParam = request.getParameter("order");

        List<Banner> banners = bannerService.getBanners(searchKeyword, statusParam, sortParam, orderParam, limit, page);
        int totalItems = bannerService.countBanners(searchKeyword, statusParam);
        int totalPages = (int) Math.ceil((double) totalItems / limit);

        request.setAttribute("banners", banners);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", limit);

        /** URL hiện tại để chuyển hướng */
        String currentUrl = request.getRequestURI();
        String queryString = request.getQueryString();
        if (queryString != null) {
            currentUrl += "?" + queryString;
        }
        request.setAttribute("currentUrl", currentUrl);

        request.getRequestDispatcher("/admin/banner/banner-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
