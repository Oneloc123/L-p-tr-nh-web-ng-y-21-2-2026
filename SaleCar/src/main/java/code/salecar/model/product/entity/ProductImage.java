package code.salecar.model.product.entity;

import java.time.LocalDateTime;
import java.util.Objects;

public class ProductImage {
    private Long id;
    private Long productId;
    private String imageUrl;
    private boolean isPrimary;
    private int sortOrder;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private ProductImage(Builder builder) {
        this.id = builder.id;
        this.productId = builder.productId;
        this.imageUrl = builder.imageUrl;
        this.isPrimary = builder.isPrimary;
        this.sortOrder = builder.sortOrder;
        this.createdAt = builder.createdAt;
        this.updatedAt = builder.updatedAt;
    }

    public static Builder builder() {
        return new Builder();
    }

    // Getters
    public Long getId() { return id; }
    public Long getProductId() { return productId; }
    public String getImageUrl() { return imageUrl; }
    public boolean isPrimary() { return isPrimary; }
    public int getSortOrder() { return sortOrder; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }

    // Setters (có validation nhẹ)
    public void setProductId(Long productId) {
        this.productId = Objects.requireNonNull(productId, "productId cannot be null");
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = Objects.requireNonNull(imageUrl, "imageUrl cannot be null");
    }
    public void setPrimary(boolean primary) { isPrimary = primary; }
    public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public static class Builder {
        private Long id;
        private Long productId;
        private String imageUrl;
        private boolean isPrimary = false;
        private int sortOrder = 0;
        private LocalDateTime createdAt = LocalDateTime.now();
        private LocalDateTime updatedAt = LocalDateTime.now();

        public Builder id(Long id) { this.id = id; return this; }
        public Builder productId(Long productId) { this.productId = productId; return this; }
        public Builder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public Builder isPrimary(boolean isPrimary) { this.isPrimary = isPrimary; return this; }
        public Builder sortOrder(int sortOrder) { this.sortOrder = sortOrder; return this; }
        public Builder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public Builder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }
        public ProductImage build() { return new ProductImage(this); }
    }
}