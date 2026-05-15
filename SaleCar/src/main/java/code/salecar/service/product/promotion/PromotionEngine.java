package code.salecar.service.product.promotion;

import code.salecar.dao.DiscountDAO;
import code.salecar.dao.ProductDAO;
import code.salecar.model.enumeration.DiscountEntityType;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.product.dto.ProductItemDTO;
import code.salecar.model.product.entity.Discount;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

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
        List<ProductItemDTO> products = productDAO.getAllProducts();
        List<Discount> discounts = discountDAO.selectAll();

        for (ProductItemDTO product : products) {

            Discount bestDiscount = findBestDiscount(product, discounts);

            double finalPrice = product.getPrice();
            BigDecimal percent = BigDecimal.ZERO;
            LocalDateTime discountUpdatedAt = product.getUpdatedAt();

            if (bestDiscount != null) {

                finalPrice = calculateAmount(product.getPrice(), bestDiscount);
                percent = BigDecimal.valueOf(bestDiscount.getPercent());
                discountUpdatedAt = bestDiscount.getUpdateAt();

            }

            productDAO.updateFinalPrice(
                    product.getId(),
                    finalPrice,
                    percent,
                    discountUpdatedAt

            );
        }

    }

    private Discount findBestDiscount(ProductItemDTO product,
                                      List<Discount> discounts) {

        Discount best = null;
        double bestValue = 0;

        for (Discount d : discounts) {

            boolean applicable = false;

            if (d.getEntityType() == DiscountEntityType.PRODUCT
                    && d.getEntityId() == product.getId()) {
                applicable = true;
            }

            if (d.getEntityType() == DiscountEntityType.BRAND
                    && d.getEntityId() == product.getBrandId()) {
                applicable = true;
            }

            if (d.getEntityType() == DiscountEntityType.CATEGORY
                    && d.getEntityId() == product.getCategoryId()) {
                applicable = true;
            }

            if (applicable) {

                double value = caculateDiscountPercent(product.getPrice(),d);

                if (value > bestValue) {
                    bestValue = value;
                    best = d;
                }
            }
        }
        if (best != null) {
            best.setPercent(bestValue);
        }
        return best;
    }

    private double calculateAmount(double price, Discount d) {
        if (d.getValueType() == DiscountValueType.PERCENT) {
            return price * (1 - d.getValue().doubleValue() / 100);
        }
        if (d.getValueType() == DiscountValueType.AMOUNT) {
            return price - d.getValue().doubleValue();
        }
        return 0;
    }
    private double caculateDiscountPercent(double price, Discount d) {
        if (d.getValueType() == DiscountValueType.PERCENT) {
            return d.getValue().doubleValue() ;
        }
        if (d.getValueType() == DiscountValueType.AMOUNT) {
            return   d.getValue().doubleValue() / price * 100;
        }
        return 0;
    }
}
