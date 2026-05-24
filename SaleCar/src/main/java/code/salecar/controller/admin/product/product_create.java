package code.salecar.controller.admin.product;

import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.enumeration.DiscountEntityType;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.ProductImage;
import code.salecar.model.product.entity.ProductVariants;
import code.salecar.service.Image.ImageService;
import code.salecar.service.file.FileStorageService;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.DiscountService;
import code.salecar.service.product.ProductService;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet("/admin/products/create")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 25
)

public class product_create extends HttpServlet {
    private final CategoryService categoryService = new CategoryService();
    private final BrandService brandService = new BrandService();
    private final FileStorageService storageService = new FileStorageService();
    private final ProductService productService = new ProductService();

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
            NotificationUtil.setError(request.getSession(), "Phải có ít nhất một biến thể");
            doGet(request, response);
            return;
        }
        if (skuParams == null || skuParams.length != variantNameParams.length) {
            NotificationUtil.setError(request.getSession(), "Số lượng SKU phải khớp với số biến thể");
            doGet(request, response);
            return;
        }
        if (priceParams == null || priceParams.length != variantNameParams.length) {
            NotificationUtil.setError(request.getSession(), "Số lượng giá biến thể phải khớp với số biến thể");
            doGet(request, response);
            return;
        }

        for (int i = 0; i < variantNameParams.length; i++) {
            if (variantNameParams[i] == null || variantNameParams[i].trim().isEmpty()) {
                NotificationUtil.setError(request.getSession(), "Tên biến thể không được để trống");
                doGet(request, response);
                return;
            }
            if (skuParams[i] == null || skuParams[i].trim().isEmpty()) {
                NotificationUtil.setError(request.getSession(), "SKU không được để trống");
                doGet(request, response);
                return;
            }
            try {
                Double.parseDouble(priceParams[i]);
            } catch (NumberFormatException e) {
                NotificationUtil.setError(request.getSession(), "Giá biến thể không hợp lệ");
                doGet(request, response);
                return;
            }
        }


        //validation name
        if (nameParam == null || nameParam.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Tên sản phẩm không được để trống");
            doGet(request, response);
            return;
        }

        //validation categoryId, parse to int
        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "Danh mục không hợp lệ");
            doGet(request, response);
            return;
        }

        //validation brandId, parse to int
        int brandId;
        try {
            brandId = Integer.parseInt(brandIdParam);
        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "Thương hiệu không hợp lệ");
            doGet(request, response);
            return;
        }
        //validation status
        if (statusParam == null || statusParam.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Trạng thái không được để trống");
            doGet(request, response);
            return;
        }
        if (!statusParam.matches("^(active|inactive|hidden|draft)$")) {
            NotificationUtil.setError(request.getSession(), "Trạng thái không hợp lệ");
            doGet(request, response);
            return;
        }

        double price = new Double(priceParams[0]);
        double discountPercent = 0;
        if (discountValueParam != null && !discountValueParam.trim().isEmpty()) {
            try {
                discountPercent = Double.parseDouble(discountValueParam);
            } catch (NumberFormatException e) {
                discountPercent = 0;
            }
        }
        double finalPrice = price;
        if (discountPercent > 0) {
            finalPrice = price * (100 - discountPercent) / 100;
        }

        // Tạo product object
        Product product = Product.builder()
                .name(nameParam)
                .price(price)
                .finalPrice(finalPrice)
                .discountPercent(discountPercent)
                .brandId(brandId)
                .categoryId(categoryId)
                .description(descriptionParam)
                .ratio(ratioParam)
                .size(sizeParam)
                .material(materialParam)
                .origin(originParam)
                .status(Status.fromString(statusParam))
                .build();

        // Create list of ProductVariants
        List<ProductVariants> variants = new ArrayList<>();
        for (int i = 0; i < variantNameParams.length; i++) {
            ProductVariants variant = ProductVariants.builder().variantName(variantNameParams[i]).sku(skuParams[i]).price(new BigDecimal(priceParams[i])).build();
            variants.add(variant);
        }

        // Create product using service
        ProductDetailDTO productDetail = ProductDetailDTO.builder().product(product).variants(variants).build();
        long productId = productService.createProduct(productDetail);

        if (productId > 0) {
            //Lưu ảnh cho sản phầm
            ImageService imageService = new ImageService(); // Khởi tạo 1 lần duy nhất ngoài vòng lặp
            boolean isFirst = true; // Biến đánh dấu ảnh đầu tiên làm ảnh chính
            try {
                Collection<Part> parts = request.getParts();
                for (Part part : parts) {
                    if ("galleryImages".equals(part.getName()) && part.getSize() > 0) {
                        // Lưu file vật lý
                        String relativePath = storageService.saveProductImage(productId, part, "gallery");

                        // Lưu thông tin vào Database
                        ProductImage image = ProductImage.builder()
                                .productId(productId)
                                .imageUrl(relativePath)
                                .isPrimary(isFirst) // Tấm đầu tiên là true, các tấm sau là false
                                .build();
                        imageService.createProductImage(image);
                        isFirst = false; // Sau tấm đầu tiên, các tấm còn lại gán false
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Tạo discount if provided
            if (discountNameParam != null && !discountNameParam.trim().isEmpty()
                    && discountValueParam != null && !discountValueParam.trim().isEmpty()
                    && discountValueTypeParam != null && !discountValueTypeParam.trim().isEmpty()) {
                try {
                    Discount discount = new Discount();
                    discount.setName(discountNameParam);
                    discount.setValueType(DiscountValueType.valueOf(discountValueTypeParam.toUpperCase()));
                    discount.setValue(new BigDecimal(discountValueParam));
                    discount.setEntityType(DiscountEntityType.PRODUCT);
                    discount.setEntityId(productId);

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
            // Success, redirect to product detail with notification
            NotificationUtil.setSuccess(request.getSession(), "Tạo sản phẩm thành công!");
            response.sendRedirect(request.getContextPath() + "/admin/products/detail?id=" + productId);
        } else {
            NotificationUtil.setError(request.getSession(), "Không thể tạo sản phẩm");
            doGet(request, response);
        }
    }
}

