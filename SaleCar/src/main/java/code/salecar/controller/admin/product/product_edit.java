package code.salecar.controller.admin.product;

import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.service.file.ActivityLogger;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.ProductService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import code.salecar.model.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

@WebServlet("/admin/products/edit")
public class product_edit extends HttpServlet {
    ProductService  productService = new ProductService();
    CategoryService categoryService = new CategoryService();
    BrandService brandService = new BrandService();
    code.salecar.service.product.ProductVariantsService variantService = new code.salecar.service.product.ProductVariantsService();
    ActivityLogger activityLogger = new ActivityLogger();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        System.out.println("Product ID param: " + idParam);

        int id;

        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        // Lấy errors từ session (nếu có từ UpdateProductBasicServlet)
        HttpSession session = request.getSession();
        Map<String, String> errors = (Map<String, String>) session.getAttribute("errors");

        if (errors != null) {
            request.setAttribute("errors", errors);
            session.removeAttribute("errors");
        }

        ProductDetailDTO productDetail = productService.getProductByID(id);
        List<Category> categories = categoryService.getCategory();
        List<Brand> brands = brandService.getBrands();

        request.setAttribute("product", productDetail);
        request.setAttribute("categoryList", categories);
        request.setAttribute("brandList", brands);

        request.getRequestDispatcher("/admin/product/product-edit.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String productIdStr = request.getParameter("productId");
        String name = request.getParameter("name");
        String categoryIdStr = request.getParameter("categoryId");
        String brandIdStr = request.getParameter("brandId");
        String statusStr = request.getParameter("status");
        String ratio = request.getParameter("ratio");
        String size = request.getParameter("size");
        String material = request.getParameter("material");
        String origin = request.getParameter("origin");
        String description = request.getParameter("description");

        // Parse variant arrays
        String[] variantIds = request.getParameterValues("variantId[]");
        String[] variantNames = request.getParameterValues("variantName[]");
        String[] variantSkus = request.getParameterValues("variantSku[]");
        String[] variantPrices = request.getParameterValues("variantPrice[]");

        // --- VALIDATION ---
        Map<String, String> errors = new HashMap<>();

        long productId = 0;
        try {
            productId = Long.parseLong(productIdStr);
        } catch (NumberFormatException | NullPointerException e) {
            errors.put("productId", "ID sản phẩm không hợp lệ");
        }

        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Tên sản phẩm không được để trống");
        }

        int categoryId = 0;
        try {
            categoryId = Integer.parseInt(categoryIdStr);
            if (categoryId <= 0) errors.put("categoryId", "Vui lòng chọn danh mục");
        } catch (NumberFormatException | NullPointerException e) {
            errors.put("categoryId", "Vui lòng chọn danh mục");
        }

        int brandId = 0;
        try {
            brandId = Integer.parseInt(brandIdStr);
            if (brandId <= 0) errors.put("brandId", "Vui lòng chọn thương hiệu");
        } catch (NumberFormatException | NullPointerException e) {
            errors.put("brandId", "Vui lòng chọn thương hiệu");
        }

        int status = 1;
        try {
            status = Integer.parseInt(statusStr);
        } catch (NumberFormatException | NullPointerException e) {
            errors.put("status", "Trạng thái không hợp lệ");
        }

        // Validate variants
        Set<String> variantNameSet = new HashSet<>();
        if (variantIds != null) {
            for (int i = 0; i < variantIds.length; i++) {
                String vName = (variantNames != null && i < variantNames.length) ? variantNames[i] : "";
                String vSku = (variantSkus != null && i < variantSkus.length) ? variantSkus[i] : "";
                String vPrice = (variantPrices != null && i < variantPrices.length) ? variantPrices[i] : "";

                if (vName.trim().isEmpty()) {
                    errors.put("variant_" + i, "Tên biến thể không được để trống");
                } else if (!variantNameSet.add(vName.trim().toLowerCase())) {
                    errors.put("variant_" + i, "Tên biến thể '" + vName.trim() + "' bị trùng");
                }

                if (vPrice.trim().isEmpty()) {
                    errors.put("variantPrice_" + i, "Giá biến thể không được để trống");
                } else {
                    try {
                        BigDecimal price = new BigDecimal(vPrice);
                        if (price.compareTo(BigDecimal.ZERO) <= 0) {
                            errors.put("variantPrice_" + i, "Giá biến thể phải > 0");
                        }
                    } catch (NumberFormatException e) {
                        errors.put("variantPrice_" + i, "Giá biến thể không hợp lệ");
                    }
                }
            }
        }

        // --- HANDLE ERRORS ---
        if (!errors.isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("errors", errors);
            NotificationUtil.setError(session, "Vui lòng kiểm tra lại thông tin");
            response.sendRedirect(request.getContextPath()
                    + "/admin/products/edit?id=" + productIdStr);
            return;
        }

        // --- UPDATE PRODUCT ---
        try {
            // 1. Update product details (basic info + attributes + description)
            productService.updateProductDetails(productId, name.trim(), categoryId, brandId,
                    status, ratio, size, material, origin, description);

            // 2. Handle variants
            // 2a. Get existing variant IDs from DB
            List<code.salecar.model.product.entity.ProductVariants> existingVariants =
                    variantService.getVariantById(productId);
            Set<Long> submittedVariantIds = new HashSet<>();

            if (variantIds != null) {
                for (int i = 0; i < variantIds.length; i++) {
                    String vIdStr = variantIds[i];
                    String vName = (variantNames != null && i < variantNames.length) ? variantNames[i].trim() : "";
                    String vSku = (variantSkus != null && i < variantSkus.length) ? variantSkus[i].trim() : "";
                    String vPrice = (variantPrices != null && i < variantPrices.length) ? variantPrices[i] : "0";

                    BigDecimal price = new BigDecimal(vPrice);
                    long vId;
                    try {
                        vId = Long.parseLong(vIdStr);
                    } catch (NumberFormatException e) {
                        vId = 0;
                    }

                    if (vId > 0) {
                        // Update existing variant
                        submittedVariantIds.add(vId);
                        productService.updateVariantInfo(vId, vName, vSku, price);
                    } else {
                        // Insert new variant
                        productService.addVariant(productId, vName, vSku, price);
                    }
                }
            }

            // 2b. Delete variants that were removed
            StringBuilder variantDetails = new StringBuilder();
            for (code.salecar.model.product.entity.ProductVariants ev : existingVariants) {
                if (!submittedVariantIds.contains(ev.getId())) {
                    productService.removeVariant(ev.getId());
                    variantDetails.append("[Xoá: ").append(ev.getVariantName()).append("] ");
                }
            }

            // 3. Log activity
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String userName = (user != null) ? user.getFullname() : "Admin";

            // Build details string
            StringBuilder details = new StringBuilder();
            details.append("Tên: ").append(name);
            details.append(" | Danh mục ID: ").append(categoryId);
            details.append(" | Thương hiệu ID: ").append(brandId);
            details.append(" | Trạng thái: ").append(status == 1 ? "Active" : "Inactive");
            if (ratio != null && !ratio.isEmpty()) details.append(" | Tỷ lệ: ").append(ratio);
            if (size != null && !size.isEmpty()) details.append(" | Kích thước: ").append(size);
            if (material != null && !material.isEmpty()) details.append(" | Chất liệu: ").append(material);
            if (origin != null && !origin.isEmpty()) details.append(" | Xuất xứ: ").append(origin);

            // Log variant changes
            if (variantIds != null) {
                for (int i = 0; i < variantIds.length; i++) {
                    String vName = (variantNames != null && i < variantNames.length) ? variantNames[i].trim() : "";
                    String vPrice = (variantPrices != null && i < variantPrices.length) ? variantPrices[i] : "0";
                    long vId;
                    try { vId = Long.parseLong(variantIds[i]); } catch (NumberFormatException e) { vId = 0; }
                    if (vId > 0) {
                        activityLogger.logVariantChange(productId, userName, vName, "Sửa", "Giá: " + vPrice);
                    } else {
                        activityLogger.logVariantChange(productId, userName, vName, "Thêm", "Giá: " + vPrice);
                    }
                }
            }
            if (variantDetails.length() > 0) {
                activityLogger.log(productId, "Xoá biến thể", userName, variantDetails.toString().trim());
            }

            activityLogger.logProductUpdate(productId, userName, details.toString());

            NotificationUtil.setSuccess(request.getSession(), "Cập nhật sản phẩm thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            NotificationUtil.setError(request.getSession(),
                    "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath()
                + "/admin/products/edit?id=" + productIdStr);
    }
}