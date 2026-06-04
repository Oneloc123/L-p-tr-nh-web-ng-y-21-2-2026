package code.salecar.model;

import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.product.entity.Product;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int id;
    private int cartId;
    private int productId;
    private int variantId;
    private String variantName;
    private String variantSku;
    private double variantFinalPrice;
    private int quantity;
    private double price;

    private Product product;
    private ProductDetailDTO productDetail;

    /**
     * Constructor đầy đủ với variant.
     */
    public CartItem(ProductDetailDTO product, int variantId, String variantName, String variantSku, double price, double variantFinalPrice, int quantity) {
        this.productDetail = product;
        this.productId = (int) product.getProduct().getId();
        this.variantId = variantId;
        this.variantName = variantName;
        this.variantSku = variantSku;
        this.price = price;
        this.variantFinalPrice = variantFinalPrice;
        this.quantity = quantity;
    }

    /**
     * Constructor cũ (không variant) — giữ lại tương thích.
     */
    public CartItem(ProductDetailDTO product, int quantity, double price) {
        this(product, 0, "", "", price, price, quantity);
    }

    public ProductDetailDTO getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(ProductDetailDTO productDetail) {
        this.productDetail = productDetail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }


    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }

    public String getVariantName() { return variantName; }
    public void setVariantName(String variantName) { this.variantName = variantName; }

    public String getVariantSku() { return variantSku; }
    public void setVariantSku(String variantSku) { this.variantSku = variantSku; }

    public double getVariantFinalPrice() { return variantFinalPrice; }
    public void setVariantFinalPrice(double variantFinalPrice) { this.variantFinalPrice = variantFinalPrice; }

    public void upQuantity( int quantity){
            this.quantity += quantity;
    }
    public double getTotalPrice(){
        return price * quantity;
    }
}
