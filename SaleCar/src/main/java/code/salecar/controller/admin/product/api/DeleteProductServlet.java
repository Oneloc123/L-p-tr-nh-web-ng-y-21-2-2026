package code.salecar.controller.admin.product.api;

import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.User;
import code.salecar.service.file.ActivityLogger;
import code.salecar.service.product.ProductService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "DeleteProductServlet", value = "/admin/products/delete")
public class DeleteProductServlet extends HttpServlet {
    ProductService productService = new ProductService();
    ActivityLogger activityLogger = new ActivityLogger();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Không tìm thấy ID sản phẩm");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        try {
            long id = Long.parseLong(idParam);
            boolean deleted = productService.deleteProduct(id);

            if (deleted) {
                /** Ghi log hoạt động */
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");
                String userName = (user != null) ? user.getFullname() : "Admin";
                activityLogger.logProductDeleted(id, "Product #" + id, userName);
                NotificationUtil.setSuccess(request.getSession(), "Xóa sản phẩm thành công!");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể xóa sản phẩm");
            }
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID sản phẩm không hợp lệ");
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi xóa sản phẩm: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}