package code.salecar.service.product;

import code.salecar.dao.DiscountDAO;
import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;

public class DiscountService {
    DiscountDAO discountDAO = new DiscountDAO();

    /**
     * Create a new discount for a product
     */
    public int createProductDiscount(Discount discount) {
        // Cập nhập thông báo bên Trang Chủ. Giảm giá mới nhất
        // ...
        return discountDAO.insertProductDiscount(discount);
    }

    /**
     * Get discount for a specific product (if any)
     */
    public java.util.List<Discount> getProductDiscounts(Product product) {
        return discountDAO.getProductDiscount(product);
    }

    /**
     * Get discount for a brand
     */
    public static Discount getBrandDiscount(int brandId) {
        return DiscountDAO.getBrandDiscount(brandId);
    }

    /**
     * Get discount for a category
     */
    public static Discount getCategoryDiscount(int categoryId) {
        return DiscountDAO.getCategoryDiscount(categoryId);
    }
}
