package code.salecar.service.product.promotion;

import code.salecar.dao.DiscountDAO;
import code.salecar.dao.ProductDAO;
import code.salecar.model.Discount;
import code.salecar.model.Product;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class PromotionEngine {

    /*
     * kiểm tra discount mới bắt đầu
     * kiểm tra discount đã hết hạn
     * tính lại final_price của product
     * update database
     * */

    ProductDAO productDAO = new ProductDAO();
    DiscountDAO discountDAO = new DiscountDAO();

    public void run() {
        System.out.println("PromotionEngine.run() called");
        List<Product> products = productDAO.getAllProducts();
        System.out.println("Product " + products.size());
        List<Discount> discounts = discountDAO.selectAll();
        System.out.println("DC " + products.size());

        for (Product product : products) {

            Discount bestDiscount = findBestDiscount(product, discounts);

            double finalPrice = product.getPrice();
            BigDecimal percent = BigDecimal.ZERO;
            Date discountUpdatedAt = new Date(product.getCreatedAt().getTime());

            if (bestDiscount != null) {

                finalPrice = calculateAmount(product.getPrice(), bestDiscount);
                percent = bestDiscount.getValue();
                discountUpdatedAt = bestDiscount.getUpdateAt();

            }

            productDAO.updateFinalPrice(
                    product.getId(),
                    finalPrice,
                    percent,
                    discountUpdatedAt

            );
            System.out.println(product.getId() + "............................");
        }

    }

    private Discount findBestDiscount(Product product,
                                      List<Discount> discounts) {

        Discount best = null;
        double bestValue = 0;

        for (Discount d : discounts) {

            boolean applicable = false;

            if (d.getEntityType() == Discount.DiscountEntityType.PRODUCT
                    && d.getEntityId() == product.getId()) {
                applicable = true;
            }

            if (d.getEntityType() == Discount.DiscountEntityType.BRAND
                    && d.getEntityId() == product.getBrandId()) {
                applicable = true;
            }

            if (d.getEntityType() == Discount.DiscountEntityType.CATEGORY
                    && d.getEntityId() == product.getCategoryId()) {
                applicable = true;
            }

            if (applicable) {

                double value = d.getValue().doubleValue();

                if (value > bestValue) {
                    bestValue = value;
                    best = d;
                }
            }
        }

        return best;
    }

    private double calculateAmount(double price, Discount d) {
        if (d.getValueType() == Discount.DiscountValueType.RATE) {
            return price * (1 - d.getValue().doubleValue() / 100);
        }
        if (d.getValueType() == Discount.DiscountValueType.AMOUNT) {
            return price - d.getValue().doubleValue();
        }
        return 0;
    }
}
