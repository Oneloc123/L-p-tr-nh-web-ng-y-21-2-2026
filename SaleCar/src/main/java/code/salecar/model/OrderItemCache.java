package code.salecar.model;


public class OrderItemCache {
    public final int productId;
    public final int variantId;
    public final int quantity;
    public final double price;

    public OrderItemCache(int productId, int variantId, int quantity, double price) {
        this.productId = productId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.price = price;
    }
}
