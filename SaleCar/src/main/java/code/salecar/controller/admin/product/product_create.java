package code.salecar.controller.admin.product;

import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.enumeration.DiscountEntityType;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.ProductVariants;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.DiscountService;
import code.salecar.service.product.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/products/create")
@MultipartConfig
public class product_create extends HttpServlet {
    CategoryService categoryService = new CategoryService();
    BrandService brandService = new BrandService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryService.getCategory();
        List<Brand> brands = brandService.getBrands();

        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("/admin/product/product-create.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nameParam = request.getParameter("name");
        String categoryIdParam = request.getParameter("categoryId");
        String brandIdParam = request.getParameter("brandId");
        String statusParam = request.getParameter("status");
        String discountPercentParam = request.getParameter("discountPercent");

        String ratioParam = request.getParameter("ratio");
        String sizeParam = request.getParameter("size");
        String materialParam = request.getParameter("material");
        String originParam = request.getParameter("origin");

        String descriptionParam = request.getParameter("description");

        String[] variantNameParams = request.getParameterValues("variantName[]");
        String[] skuParams = request.getParameterValues("sku[]");
        String[] priceParams = request.getParameterValues("price[]");

        // Discount parameters
        String discountNameParam = request.getParameter("discountName");
        String discountValueTypeParam = request.getParameter("discountValueType");
        String discountValueParam = request.getParameter("discountPercent");
        String discountStartDateParam = request.getParameter("discountStartDate");
        String discountEndDateParam = request.getParameter("discountEndDate");


        // Print all variables
//        System.out.println("====== ALL PARAMETERS ======");
//        System.out.println("nameParam: " + nameParam);
//        System.out.println("categoryIdParam: " + categoryIdParam);
//        System.out.println("brandIdParam: " + brandIdParam);
//        System.out.println("statusParam: " + statusParam);
//        System.out.println("ratioParam: " + ratioParam);
//        System.out.println("sizeParam: " + sizeParam);
//        System.out.println("materialParam: " + materialParam);
//        System.out.println("originParam: " + originParam);
//        System.out.println("descriptionParam: " + descriptionParam);
//        System.out.println("variantNameParams: " + Arrays.toString(variantNameParams));
//        System.out.println("skuParams: " + Arrays.toString(skuParams));
//        System.out.println("priceParams: " + Arrays.toString(priceParams));
//        System.out.println("discountPercentParam: " + discountPercentParam);
//        System.out.println("=============================");

        // Validation for variants
        if (variantNameParams == null || variantNameParams.length == 0) {
            request.setAttribute("error", "Phải có ít nhất một biến thể");
            doGet(request, response);
            return;
        }
        if (skuParams == null || skuParams.length != variantNameParams.length) {
            request.setAttribute("error", "Số lượng SKU phải khớp với số biến thể");
            doGet(request, response);
            return;
        }
        if (priceParams == null || priceParams.length != variantNameParams.length) {
            request.setAttribute("error", "Số lượng giá biến thể phải khớp với số biến thể");
            doGet(request, response);
            return;
        }

        for (int i = 0; i < variantNameParams.length; i++) {
            if (variantNameParams[i] == null || variantNameParams[i].trim().isEmpty()) {
                request.setAttribute("error", "Tên biến thể không được để trống");
                doGet(request, response);
                return;
            }
            if (skuParams[i] == null || skuParams[i].trim().isEmpty()) {
                request.setAttribute("error", "SKU không được để trống");
                doGet(request, response);
                return;
            }
            try {
                Double.parseDouble(priceParams[i]);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Giá biến thể không hợp lệ");
                doGet(request, response);
                return;
            }
        }


        //validation name
        if (nameParam == null || nameParam.trim().isEmpty()) {
            request.setAttribute("error", "Tên sản phẩm không được để trống");
            doGet(request, response);
            return;
        }

        //validation categoryId, parse to int
        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Danh mục không hợp lệ");
            doGet(request, response);
            return;
        }

        //validation brandId, parse to int
        int brandId;
        try {
            brandId = Integer.parseInt(brandIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Thương hiệu không hợp lệ");
            doGet(request, response);
            return;
        }

        //validation status
        if (statusParam == null || statusParam.trim().isEmpty()) {
            request.setAttribute("error", "Trạng thái không được để trống");
            doGet(request, response);
            return;
        }
        if (!statusParam.matches("^(active|inactive|hidden|draft)$")) {
            request.setAttribute("error", "Trạng thái không hợp lệ");
            doGet(request, response);
            return;
        }

        //validation price, parse to double
//        double price;
//        try {
//            price = Double.parseDouble(priceParam);
//        } catch (NumberFormatException e) {
//            request.setAttribute("error", "Giá gốc không hợp lệ");
//            doGet(request, response);
//            return;
//        }

        //validation discountPercent, parse to double
//        double discountPercent;
//        try {
//            discountPercent = Double.parseDouble(discountPercentParam);
//        } catch (NumberFormatException e) {
//            request.setAttribute("error", "Phần trăm giảm giá không hợp lệ");
//            doGet(request, response);
//            return;
//        }

        //validation ratio
        if (ratioParam == null || ratioParam.trim().isEmpty()) {
            request.setAttribute("error", "Tỉ lệ không được để trống");
            doGet(request, response);
            return;
        }

        //validation size
        if (sizeParam == null || sizeParam.trim().isEmpty()) {
            request.setAttribute("error", "Kích thước không được để trống");
            doGet(request, response);
            return;
        }

        //validation material
        if (materialParam == null || materialParam.trim().isEmpty()) {
            request.setAttribute("error", "Chất liệu không được để trống");
            doGet(request, response);
            return;
        }

        //validation origin
        if (originParam == null || originParam.trim().isEmpty()) {
            request.setAttribute("error", "Xuất xứ không được để trống");
            doGet(request, response);
            return;
        }

        //validation description
        if (descriptionParam == null || descriptionParam.trim().isEmpty()) {
            request.setAttribute("error", "Mô tả không được để trống");
            doGet(request, response);
            return;
        }

        // Map status to int
        int statusInt;
        switch (statusParam) {
            case "active":
                statusInt = 1;
                break;
            case "inactive":
                statusInt = 0;
                break;
            case "hidden":
                statusInt = 2;
                break;
            case "draft":
                statusInt = 3;
                break;
            default:
                statusInt = 1; // default to active
                break;
        }

        //validation discountPercent
        if (discountPercentParam == null || discountPercentParam.trim().isEmpty()) {
            request.setAttribute("error", "Phần trăm giảm giá không được để trống");
            doGet(request, response);
            return;
        }
        double discountPercent;
        try {
            discountPercent = Double.parseDouble(discountPercentParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Phần trăm giảm giá không hợp lệ");
            doGet(request, response);
            return;
        }

        // Create list of ProductVariants
        List<ProductVariants> variants = new ArrayList<>();
        for (int i = 0; i < variantNameParams.length; i++) {
            ProductVariants variant = ProductVariants.builder().variantName(variantNameParams[i]).sku(skuParams[i]).price(new BigDecimal(priceParams[i])).build();
            variants.add(variant);
        }


        // Create Product object
//        ProductDetailDTO product = new ProductDetailDTO();
//        product.setName(nameParam);
//        product.setBrandId(brandId);
//        product.setCategoryId(categoryId);
//        product.setDescription(descriptionParam);
//        product.setRatio(ratioParam);
//        product.setSize(sizeParam);
//        product.setMaterial(materialParam);
//        product.setOrigin(originParam);
//        product.setStatus(statusInt);
//        product.setVariants(variants);
//        product.setDiscountPercent(discountPercent);

        // Create product using service
        ProductService productService = new ProductService();
//        int productId = productService.createProduct(product);

        if (/*productId*/1 > 0) {
            // Create discount if provided
            if (discountNameParam != null && !discountNameParam.trim().isEmpty()
                    && discountValueParam != null && !discountValueParam.trim().isEmpty()
                    && discountValueTypeParam != null && !discountValueTypeParam.trim().isEmpty()) {
                try {
                    Discount discount = new Discount();
                    discount.setName(discountNameParam);
                    discount.setValueType(DiscountValueType.valueOf(discountValueTypeParam.toUpperCase()));
                    discount.setValue(new BigDecimal(discountValueParam));
                    discount.setEntityType(DiscountEntityType.PRODUCT);
                    discount.setEntityId(/*productId*/402);

                    // Parse dates if provided
                    if (discountStartDateParam != null && !discountStartDateParam.trim().isEmpty()) {
                        discount.setStartAt(LocalDateTime.parse(discountStartDateParam));
                    } else {
                        // Mặc định là ngày tạo
                        discount.setStartAt(LocalDateTime.now());
                    }

                    if (discountEndDateParam != null && !discountEndDateParam.trim().isEmpty()) {
                        discount.setEndAt(LocalDateTime.parse(discountEndDateParam));
                    } else {
                        // Thiết lập mặc định là 30 ngày
                        long thirtyDaysMs = 30 * 24 * 60 * 60 * 1000L;
                        discount.setEndAt(LocalDateTime.now().plusDays(30));
                    }

                    DiscountService discountService = new DiscountService();
                    int discountId = discountService.createProductDiscount(discount);

                    if (discountId > 0) {
                        System.out.println("Discount created successfully with ID: " + discountId);
                    }
                } catch (IllegalArgumentException e) {
                    System.err.println("Invalid discount value type or date format: " + e.getMessage());
                } catch (Exception e) {
                    System.err.println("Error creating discount: " + e.getMessage());
                }
            }

            // Success, redirect to product list
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } else {
            request.setAttribute("error", "Không thể tạo sản phẩm");
            doGet(request, response);
        }
    }
}

