package code.salecar.service.product;

import code.salecar.dao.DiscountDAO;
import code.salecar.dao.ProductDAO;
import code.salecar.dao.ProductVariantsDAO;
import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.ProductVariants;
import code.salecar.model.product.filter.DiscountFilter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DiscountService {
    private final DiscountDAO discountDAO = new DiscountDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ProductVariantsDAO productVariantsDAO = new ProductVariantsDAO();

    public int createProductDiscount(Discount discount) {
        int discountId = discountDAO.insertProductDiscount(discount);

        if (discountId > 0 && discount.getStatus() == Status.ACTIVE) {
            // Cập nhật discount cho các sản phẩm bị ảnh hưởng
            updateAffectedProducts(discount);
        }

        return discountId;
    }

    /**
     * Cập nhật discount (final_price, discount_percent) cho các sản phẩm
     * bị ảnh hưởng bởi discount vừa được tạo.
     */
    private void updateAffectedProducts(Discount discount) {
        List<Long> productIds = new ArrayList<>();

        switch (discount.getEntityType()) {
            case PRODUCT:
                productIds.add(discount.getEntityId());
                break;
            case BRAND:
                productIds.addAll(productDAO.getProductIdsByBrandId((int) discount.getEntityId()));
                break;
            case CATEGORY:
                productIds.addAll(productDAO.getProductIdsByCategoryId( discount.getEntityId()));
                break;
        }

        for (Long productId : productIds) {
            recalculateProductDiscount(productId);
        }
    }

    /**
     * Tính toán lại final_price và discount_percent cho một sản phẩm
     * dựa trên discount đang hoạt động (ưu tiên: sản phẩm > thương hiệu > danh mục).
     */
    private void recalculateProductDiscount(long productId) {
        Discount activeDiscount = findActiveByProductId(productId);
        Product product = productDAO.getProductByID(productId);

        if (product == null) return;

        if (activeDiscount != null) {
            double discountPercent;
            double finalPrice;

            if (activeDiscount.getValueType() == DiscountValueType.PERCENT) {
                discountPercent = activeDiscount.getValue().doubleValue();
                finalPrice = product.getPrice() * (1 - discountPercent / 100);
            } else {
                // AMOUNT: giảm theo số tiền cố định
                double amount = activeDiscount.getValue().doubleValue();
                if (product.getPrice() > 0) {
                    discountPercent = (amount / product.getPrice()) * 100;
                } else {
                    discountPercent = 0;
                }
                finalPrice = product.getPrice() - amount;
            }

            if (finalPrice < 0) finalPrice = 0;
            if (discountPercent < 0) discountPercent = 0;
            if (discountPercent > 100) discountPercent = 100;

            productDAO.updateFinalPrice(productId, finalPrice,
                    BigDecimal.valueOf(discountPercent), LocalDateTime.now());
        } else {
            // Không có discount nào đang hoạt động -> đặt lại về giá gốc
            productDAO.updateFinalPrice(productId, product.getPrice(),
                    BigDecimal.ZERO, LocalDateTime.now());
        }

        // Cập nhật final_price cho các biến thể của sản phẩm
        updateVariantFinalPrices(productId);
    }

    /**
     * Tính và cập nhật final_price cho tất cả biến thể của một sản phẩm
     * dựa trên discount_percent của sản phẩm đó.
     */
    private void updateVariantFinalPrices(long productId) {
        // Đọc lại sản phẩm để lấy discountPercent đã cập nhật
        Product product = productDAO.getProductByID(productId);
        if (product == null) return;

        double discountPercent = product.getDiscountPercent();
        List<ProductVariants> variants = productVariantsDAO.getVariantById(productId);

        for (ProductVariants variant : variants) {
            BigDecimal originalPrice = variant.getPrice();
            BigDecimal finalPrice;

            if (discountPercent > 0) {
                finalPrice = originalPrice.multiply(
                        BigDecimal.valueOf((100 - discountPercent) / 100.0));
            } else {
                finalPrice = originalPrice;
            }

            if (finalPrice.compareTo(BigDecimal.ZERO) < 0) {
                finalPrice = BigDecimal.ZERO;
            }

            productVariantsDAO.updateFinalPrice(variant.getId(), finalPrice);
        }
    }

    public List<Discount> getProductDiscounts(Product product) {
        return discountDAO.getProductDiscount(product);
    }

    public static Discount getBrandDiscount(long brandId) {
        return DiscountDAO.getBrandDiscount(brandId);
    }

    public static Discount getCategoryDiscount(long categoryId) {
        return DiscountDAO.getCategoryDiscount(categoryId);
    }

    public Discount findActiveByProductId(long productId) {
        // 1. Lấy thông tin sản phẩm để biết BrandId và CategoryId
        Product product = productDAO.getProductByID(productId);
        if (product == null) return null;

        // 2. Kiểm tra giảm giá trực tiếp trên sản phẩm (Ưu tiên 1)
        Discount productDiscount = discountDAO.findActiveDiscount("product", productId);
        if (productDiscount != null) {
            return productDiscount;
        }

        // 3. Kiểm tra giảm giá theo thương hiệu (Ưu tiên 2)
        Discount brandDiscount = discountDAO.findActiveDiscount("brand", (long) product.getBrandId());
        if (brandDiscount != null) {
            return brandDiscount;
        }

        // 4. Kiểm tra giảm giá theo danh mục (Ưu tiên 3)
        Discount categoryDiscount = discountDAO.findActiveDiscount("category", (long) product.getCategoryId());
        if (categoryDiscount != null) {
            return categoryDiscount;
        }
        return null;
    }

    /**
     * Lấy danh sách discount với bộ lọc + phân trang (cho Admin).
     */
    public List<Discount> getAllDiscounts(DiscountFilter filter) {
        return discountDAO.getAllDiscounts(filter);
    }

    /**
     * Đếm tổng số discount với bộ lọc (cho phân trang).
     */
    public int getTotalDiscounts(DiscountFilter filter) {
        return discountDAO.getTotalDiscounts(filter);
    }

    /**
     * Xóa discount theo ID và cập nhật lại final_price cho các sản phẩm bị ảnh hưởng.
     */
    public boolean deleteDiscount(long id) {
        // Lấy thông tin discount trước khi xóa
        Discount discount = discountDAO.getDiscountById(id);
        if (discount == null) return false;

        boolean deleted = discountDAO.deleteDiscount(id);

        if (deleted) {
            // Cập nhật lại giá cho các sản phẩm bị ảnh hưởng
            updateAffectedProducts(discount);
        }

        return deleted;
    }

    /**
     * Lấy danh sách thương hiệu có sản phẩm đang có discount (cho dropdown bộ lọc).
     */
    public List<Brand> getBrandsHaveDiscount() {
        return discountDAO.getBrandsHaveDiscount();
    }

    /**
     * Lấy danh sách danh mục có sản phẩm đang có discount (cho dropdown bộ lọc).
     */
    public List<Category> getCategoriesHaveDiscount() {
        return discountDAO.getCategoriesHaveDiscount();
    }

    /**
     * Lấy danh sách sản phẩm đang có discount (cho dropdown bộ lọc).
     */
    public List<Product> getProductsHaveDiscount() {
        return discountDAO.getProductsHaveDiscount();
    }
}
