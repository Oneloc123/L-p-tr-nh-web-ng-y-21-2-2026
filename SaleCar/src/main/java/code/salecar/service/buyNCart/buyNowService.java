package code.salecar.service.buyNCart;

import code.salecar.model.Cart;
import code.salecar.model.product.dto.ProductDetailDTO;

public class buyNowService {

    public Cart buyNow(ProductDetailDTO product, int quantity){


            Cart cartBuy = new Cart();
            cartBuy.addProduct(product, quantity);
        return cartBuy;


    }
}
