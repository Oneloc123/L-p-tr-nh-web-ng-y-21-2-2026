package code.salecar.service.product;

import code.salecar.dao.DiscountDAO;

public class DiscountService {
    DiscountDAO discountDAO = new DiscountDAO();


//    public Discount getDiscount(Product product) {
//
//        Discount discount = DiscountDAO.getProductDiscount(product.getId());
//
//        if (discount == null) {
//            discount = DiscountDAO.getBrandDiscount(product.getBrandid());
//        }
//        if  (discount == null) {
//            discount = DiscountDAO.getCategoryDiscount(product.getCategoryid());
//        }
//        return discount;
//
//    }
}
