package code.salecar.service.buyNCart;

import code.salecar.model.Cart;
import code.salecar.model.User;
import code.salecar.model.product.entity.Product;

public class buyNowService {

    public Cart buyNow(Product product, int quantity){


            Cart cartBuy = new Cart();
            cartBuy.addProduct(product, quantity);
        return cartBuy;


    }
}
