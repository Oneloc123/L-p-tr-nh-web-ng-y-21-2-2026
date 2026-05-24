package code.salecar.controller.admin.product.api;

import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.service.product.ProductService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/product/update-basic-info")
public class UpdateProductBasicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String productIdStr = request.getParameter("productId");
        String name = request.getParameter("name");
        String sku = request.getParameter("sku");
        String categoryIdStr = request.getParameter("categoryId");
        String brandIdStr = request.getParameter("brandId");
        String statusStr = request.getParameter("status");

        // validate
        Map<String, String> error = new HashMap<>();
        if (productIdStr == null || productIdStr.equals("")) {
            error.put("productId", "Chưa nhân được Id sản phẩm");
        }
        if (name == null || name.equals("")) {
            error.put("name", "Sản phẩm phải được đặt tên");
        }
        if (sku == null || sku.equals("")) {
            error.put("sku", "Sản phẩm phải được đặt mã vận hàng");
        }
        if (categoryIdStr == null || categoryIdStr.equals("")) {
            error.put("categoryId", "Sản phẩm phải được chọn loai");
        }
        if (brandIdStr == null || brandIdStr.equals("")) {
            error.put("brandId", "Sản phẩm phải được chọn thương hiệu");
        }
        if (statusStr == null || statusStr.equals("")) {
            error.put("status", "Sản phẩm phải được chọn trạng thái hoạt động");
        }

        // Parse integer
        Integer id = null;
        try {
            id = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            error.put("fmtId", "Id sản phẩm phải là số");
        }
        Integer categoryId = null;
        try {
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            error.put("fmtCategoryId", "Id loại phải là số");
        }
        Integer brandId = null;
        try {
            brandId = Integer.parseInt(brandIdStr);
        } catch (NumberFormatException e) {
            error.put("fmtBrandId", "Id thương hiệu phải là số");
        }
        Integer status = null;
        try {
            status = Integer.parseInt(statusStr);
        } catch (NumberFormatException e) {
            error.put("fmtStatus", "Trạng thái sản phẩm phải là số");
        }

        if (!error.isEmpty()) {

            HttpSession session = request.getSession();
            session.setAttribute("errors", error);
            NotificationUtil.setError(session, "Vui lòng kiểm tra lại thông tin");

            response.sendRedirect(request.getContextPath()
                    + "/admin/products/edit?id=" + productIdStr);
            return;
        }

        ProductService productService = new ProductService();
//        Cập nhật thông tin cơ bản của sản phẩm

//        ProductDetailDTO product = new ProductDetailDTO();
//        product.setId(id);
//        product.setName(name);
//        product.setCategoryId(categoryId);
//        product.setBrandId(brandId);
//        product.setStatus(status);
//        productService.updateBasicInfo(product);

        response.sendRedirect(request.getContextPath()
                + "/admin/products/detail?id=" + productIdStr);
        return;

    }
}