package code.salecar.service.product;

import code.salecar.dao.DiscountDAO;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;

public class DiscountService {
    DiscountDAO discountDAO = new DiscountDAO();


    public int createProductDiscount(Discount discount) {

        return discountDAO.insertProductDiscount(discount);
    }


    public java.util.List<Discount> getProductDiscounts(Product product) {
        return discountDAO.getProductDiscount(product);
    }


    public static Discount getBrandDiscount(int brandId) {
        return DiscountDAO.getBrandDiscount(brandId);
    }


    public static Discount getCategoryDiscount(int categoryId) {
        return DiscountDAO.getCategoryDiscount(categoryId);
    }
}
