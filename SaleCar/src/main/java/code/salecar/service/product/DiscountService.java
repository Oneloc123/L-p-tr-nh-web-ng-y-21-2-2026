package code.salecar.service.product;

import code.salecar.dao.DiscountDAO;
import code.salecar.dao.ProductDAO;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;

public class DiscountService {
    DiscountDAO discountDAO = new DiscountDAO();
    ProductDAO productDAO = new ProductDAO();

    public int createProductDiscount(Discount discount) {

        return discountDAO.insertProductDiscount(discount);
    }


    public java.util.List<Discount> getProductDiscounts(Product product) {
        return discountDAO.getProductDiscount(product);
    }


    public static Discount getBrandDiscount(long brandId) {
        return DiscountDAO.getBrandDiscount(brandId);
    }


    public static Discount getCategoryDiscount(long categoryId) {
        return DiscountDAO.getCategoryDiscount(categoryId);
    }

    public  Discount findActiveByProductId(long productId) {

        // 1. Lấy thông tin sản phẩm để biết BrandId và CategoryId
        Product product = productDAO.getProductByID(productId);
        if (product == null) return null;

        // 2. Kiểm tra giảm giá trực tiếp trên Sản phẩm (Ưu tiên 1)
        Discount productDiscount = discountDAO.findActiveDiscount("product", productId);
        if (productDiscount != null) {
            return productDiscount;
        }

        // 3. Kiểm tra giảm giá theo Thương hiệu (Ưu tiên 2)
        Discount brandDiscount = discountDAO.findActiveDiscount("brand", (long) product.getBrandId());
        if (brandDiscount != null) {
            return brandDiscount;
        }

        // 4. Kiểm tra giảm giá theo Danh mục (Ưu tiên 3)
        Discount categoryDiscount = discountDAO.findActiveDiscount("category", (long) product.getCategoryId());
        if (categoryDiscount != null) {
            return categoryDiscount;
        }
        return null; // Không có mã giảm giá nào đang hoạt động
    }
}
