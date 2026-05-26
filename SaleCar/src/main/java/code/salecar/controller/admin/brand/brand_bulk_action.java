package code.salecar.controller.admin.brand;

import code.salecar.model.enumeration.Status;
import code.salecar.service.product.BrandService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/admin/brands/bulk-action")
public class brand_bulk_action extends HttpServlet {
    BrandService brandService = new BrandService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Thiếu hành động");
            response.sendRedirect("/admin/brands");
            return;
        }

        String[] idsParam = request.getParameterValues("ids");
        List<Integer> ids = idsParam == null ? new ArrayList<>()
                : Arrays.stream(idsParam)
                .filter(s -> s != null && !s.isBlank())
                .map(Integer::parseInt)
                .toList();
        if (ids == null || ids.isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Vui lòng chọn ít nhất một thương hiệu");
            response.sendRedirect(request.getContextPath() + "/admin/brands");
            return;
        }

        try {
            int successCount = 0;
            if ("active".equals(action)) {
                for (int id : ids) {
                    if (brandService.toggleStatus(id, Status.ACTIVE)) {
                        successCount++;
                    }
                }
            } else if ("inactive".equals(action)) {
                for (int id : ids) {
                    if (brandService.toggleStatus(id, Status.INACTIVE)) {
                        successCount++;
                    }
                }
            }

            if (successCount > 0) {
                NotificationUtil.setSuccess(request.getSession(),
                        "Đã chuyển trạng thái " + successCount + "/" + ids.size() + " thương hiệu thành công!");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể chuyển trạng thái thương hiệu");
            }
        } catch (Exception ex) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi xử lý: " + ex.getMessage());
        }

        String redirectUrl = request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/brands");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
