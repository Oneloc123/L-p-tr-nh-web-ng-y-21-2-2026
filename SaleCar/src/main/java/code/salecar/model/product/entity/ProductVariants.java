package code.salecar.model.product.entity;

import java.io.Serializable;

public class ProductVariants implements Serializable {
    private int id;
    private int productId;
    private String variantName;
    private String sku;
    private String price;

    public ProductVariants() {
    }

    public ProductVariants(String variantName, String sku, String price) {
        this.variantName = variantName;
        this.sku = sku;
        this.price = price;
    }

    public String getVariantName() {
        return variantName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setVariantName(String variantName) {
        this.variantName = variantName;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
}
