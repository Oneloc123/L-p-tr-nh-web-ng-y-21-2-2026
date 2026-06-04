package code.salecar.service.buyNCart;

import code.salecar.model.Cart;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.product.entity.ProductVariants;

public class buyNowService {

    public Cart buyNow(ProductDetailDTO product, int quantity){
        Cart cartBuy = new Cart();
        cartBuy.addProduct(product, quantity);
        return cartBuy;
    }

    /**
     * Mua ngay với variant cụ thể.
     */
    public Cart buyNow(ProductDetailDTO product, int variantId, int quantity){
        Cart cartBuy = new Cart();

        // Tìm variant theo variantId
        ProductVariants selectedVariant = null;
        if (product.getVariants() != null) {
            for (ProductVariants v : product.getVariants()) {
                if (v.getId() == variantId) {
                    selectedVariant = v;
                    break;
                }
            }
        }

        if (selectedVariant != null) {
            double price = selectedVariant.getFinalPrice() != null ? selectedVariant.getFinalPrice().doubleValue() : selectedVariant.getPrice().doubleValue();
            double originalPrice = selectedVariant.getPrice().doubleValue();
            cartBuy.addProduct(product, (int) selectedVariant.getId(), selectedVariant.getVariantName(), selectedVariant.getSku(), originalPrice, price, quantity);
        } else {
            cartBuy.addProduct(product, quantity);
        }

        return cartBuy;
    }
}
