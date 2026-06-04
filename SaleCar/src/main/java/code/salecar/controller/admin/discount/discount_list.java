package code.salecar.controller.admin.discount;

import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.filter.DiscountFilter;
import code.salecar.service.product.DiscountService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/discounts")
public class discount_list extends HttpServlet {
    private final DiscountService discountService = new DiscountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /** Đọc tham số phân trang */
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam.trim());
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {}
        }

        int limit = 20;
        String limitParam = request.getParameter("limit");
        if (limitParam != null && !limitParam.isEmpty()) {
            try {
                limit = Integer.parseInt(limitParam.trim());
                if (limit < 1) limit = 20;
            } catch (NumberFormatException ignored) {}
        }

        /** Tạo bộ lọc từ tham số request */
        DiscountFilter filter = new DiscountFilter();
        filter.setTimeStatus(request.getParameter("timeStatus"));
        filter.setBrandId(request.getParameter("brandId"));
        filter.setCategoryId(request.getParameter("categoryId"));
        filter.setProductId(request.getParameter("productId"));
        filter.setPage(page);
        filter.setLimit(limit);

        /** Lấy danh sách discount và tổng số */
        List<Discount> discounts = discountService.getAllDiscounts(filter);
        int totalDiscounts = discountService.getTotalDiscounts(filter);
        int totalPages = (int) Math.ceil((double) totalDiscounts / limit);

        /** Lấy danh sách cho filter dropdown */
        List<Brand> brands = discountService.getBrandsHaveDiscount();
        List<Category> categories = discountService.getCategoriesHaveDiscount();
        List<Product> products = discountService.getProductsHaveDiscount();

        /** Đặt thuộc tính cho JSP */
        request.setAttribute("discounts", discounts);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.setAttribute("products", products);
        request.setAttribute("totalDiscounts", totalDiscounts);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", limit);

        /** URL hiện tại cho phân trang */
        String currentUrl = request.getRequestURI();
        String queryString = request.getQueryString();
        if (queryString != null) {
            currentUrl += "?" + queryString;
        }
        request.setAttribute("currentUrl", currentUrl);

        request.getRequestDispatcher("/admin/discount/discount-list.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    long id = Long.parseLong(idParam.trim());
                    boolean deleted = discountService.deleteDiscount(id);
                    if (deleted) {
                        NotificationUtil.setSuccess(request.getSession(), "Xóa discount thành công!");
                    } else {
                        NotificationUtil.setError(request.getSession(), "Không tìm thấy discount để xóa");
                    }
                } catch (NumberFormatException e) {
                    NotificationUtil.setError(request.getSession(), "ID discount không hợp lệ");
                }
            }
        } else {
            NotificationUtil.setError(request.getSession(), "Hành động không hợp lệ");
        }

        String redirectUrl = request.getContextPath() + "/admin/discounts";
        response.sendRedirect(redirectUrl);
    }
}
