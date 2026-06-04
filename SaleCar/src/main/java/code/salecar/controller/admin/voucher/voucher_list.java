package code.salecar.controller.admin.voucher;

import code.salecar.model.product.entity.Voucher;
import code.salecar.model.product.entity.VoucherScope;
import code.salecar.model.product.filter.VoucherFilter;
import code.salecar.service.product.VoucherService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/vouchers")
public class voucher_list extends HttpServlet {
    private final VoucherService voucherService = new VoucherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pageParam = request.getParameter("page");
        int page = 1;
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

        // Xây dựng bộ lọc từ tham số request
        VoucherFilter filter = new VoucherFilter();
        filter.setSearch(request.getParameter("search"));
        filter.setStatus(request.getParameter("status"));
        filter.setTimeStatus(request.getParameter("timeStatus"));
        filter.setSort(request.getParameter("sort"));
        filter.setOrder(request.getParameter("order"));
        filter.setPage(page);
        filter.setLimit(limit);

        // Lấy dữ liệu
        List<Voucher> vouchers = voucherService.getVouchers(filter);
        int totalVouchers = voucherService.getTotalVouchers(filter);
        int totalPages = (int) Math.ceil((double) totalVouchers / limit);

        // Tải thông tin phạm vi cho từng voucher
        Map<Long, List<VoucherScope>> scopeMap = new HashMap<>();
        for (Voucher v : vouchers) {
            List<VoucherScope> scopes = voucherService.getScopes(v.getId());
            scopeMap.put(v.getId(), scopes);
        }

        // Đặt thuộc tính cho request
        request.setAttribute("vouchers", vouchers);
        request.setAttribute("scopeMap", scopeMap);
        request.setAttribute("totalVouchers", totalVouchers);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", limit);

        // URL hiện tại cho phân trang
        String currentUrl = request.getRequestURI();
        String queryString = request.getQueryString();
        if (queryString != null) {
            currentUrl += "?" + queryString;
        }
        request.setAttribute("currentUrl", currentUrl);

        request.getRequestDispatcher("/admin/voucher/voucher-list.jsp")
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
                    boolean deleted = voucherService.deleteVoucher(id);
                    if (deleted) {
                        NotificationUtil.setSuccess(request.getSession(), "Xóa voucher thành công!");
                    } else {
                        NotificationUtil.setError(request.getSession(), "Không tìm thấy voucher để xóa");
                    }
                } catch (NumberFormatException e) {
                    NotificationUtil.setError(request.getSession(), "ID voucher không hợp lệ");
                }
            }
        } else if ("toggle-status".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    long id = Long.parseLong(idParam.trim());
                    voucherService.toggleStatus(id);
                    NotificationUtil.setSuccess(request.getSession(), "Chuyển trạng thái voucher thành công!");
                } catch (NumberFormatException e) {
                    NotificationUtil.setError(request.getSession(), "ID voucher không hợp lệ");
                }
            }
        }

        String redirectUrl = request.getContextPath() + "/admin/vouchers";
        response.sendRedirect(redirectUrl);
    }
}
