package code.salecar.model.product.entity;

import java.io.Serializable;
import java.math.BigDecimal;

public class ProductVariants implements Serializable {

    private static final long serialVersionUID = 1L;

    private long id;
    private long productId;
    private String variantName;
    private String sku;
    private BigDecimal price;
    private int quantity;          // tồn kho
    private int reservedQuantity;  // số lượng đã đặt nhưng chưa thanh toán (optional)

    public ProductVariants() {
    }
    public ProductVariants(long id, long productId, String variantName, String sku,
                           BigDecimal price, int quantity, int reservedQuantity) {
        this.id = id;
        this.productId = productId;
        this.variantName = variantName;
        this.sku = sku;
        this.price = price;
        this.quantity = quantity;
        this.reservedQuantity = reservedQuantity;
    }
    private ProductVariants(Builder builder) {
        this.id = builder.id;
        this.productId = builder.productId;
        this.variantName = builder.variantName;
        this.sku = builder.sku;
        this.price = builder.price;
        this.quantity = builder.quantity;
        this.reservedQuantity = builder.reservedQuantity;
    }

    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public long getProductId() {
        return productId;
    }
    public void setProductId(long productId) {
        this.productId = productId;
    }
    public String getVariantName() {
        return variantName;
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
    public BigDecimal getPrice() {
        return price;
    }
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public int getReservedQuantity() {
        return reservedQuantity;
    }
    public void setReservedQuantity(int reservedQuantity) {
        this.reservedQuantity = reservedQuantity;
    }

    // 5. Builder pattern
    public static Builder builder() {
        return new Builder();
    }
    public static class Builder {
        private long id;
        private long productId;
        private String variantName;
        private String sku;
        private BigDecimal price;
        private int quantity;
        private int reservedQuantity;

        public Builder id(long id) {
            this.id = id;
            return this;
        }

        public Builder productId(long productId) {
            this.productId = productId;
            return this;
        }

        public Builder variantName(String variantName) {
            this.variantName = variantName;
            return this;
        }

        public Builder sku(String sku) {
            this.sku = sku;
            return this;
        }

        public Builder price(BigDecimal price) {
            this.price = price;
            return this;
        }

        public Builder quantity(int quantity) {
            this.quantity = quantity;
            return this;
        }

        public Builder reservedQuantity(int reservedQuantity) {
            this.reservedQuantity = reservedQuantity;
            return this;
        }

        public ProductVariants build() {
            // Validation cơ bản
            if (variantName == null || variantName.isEmpty()) {
                throw new IllegalArgumentException("Tên biến thể không được để trống");
            }
            if (sku == null || sku.isEmpty()) {
                throw new IllegalArgumentException("SKU không được để trống");
            }
            if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
                throw new IllegalArgumentException("Giá không hợp lệ");
            }
            if (quantity < 0) {
                throw new IllegalArgumentException("Tồn kho không được âm");
            }
            if (reservedQuantity < 0) {
                throw new IllegalArgumentException("Reserved quantity không được âm");
            }
            if (reservedQuantity > quantity) {
                throw new IllegalArgumentException("Số lượng đã đặt không thể vượt quá tồn kho");
            }
            return new ProductVariants(this);
        }
    }
    // 6. toString (tuỳ chọn)
    @Override
    public String toString() {
        return "ProductVariants{" +
                "id=" + id +
                ", productId=" + productId +
                ", variantName='" + variantName + '\'' +
                ", sku='" + sku + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", reservedQuantity=" + reservedQuantity +
                '}';
    }
}