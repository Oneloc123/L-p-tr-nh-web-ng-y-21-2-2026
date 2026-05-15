package code.salecar.model.product.entity;

import java.time.LocalDateTime;

public class ProductAudit {
    private Long id;
    private Long productId;
    private String fieldName;
    private String oldValue;
    private String newValue;
    private String modifiedBy;    // admin username hoặc user id (tạm thời dùng String)
    private LocalDateTime modifiedAt;


    private ProductAudit(Builder builder) {
        this.id = builder.id;
        this.productId = builder.productId;
        this.fieldName = builder.fieldName;
        this.oldValue = builder.oldValue;
        this.newValue = builder.newValue;
        this.modifiedBy = builder.modifiedBy;
        this.modifiedAt = builder.modifiedAt;
    }
    public static Builder builder() {
        return new Builder();
    }

    // Chỉ có getter, không có setter
    public Long getId() { return id; }
    public Long getProductId() { return productId; }
    public String getFieldName() { return fieldName; }
    public String getOldValue() { return oldValue; }
    public String getNewValue() { return newValue; }
    public String getModifiedBy() { return modifiedBy; }
    public LocalDateTime getModifiedAt() { return modifiedAt; }

    public static class Builder {
        private Long id;
        private Long productId;
        private String fieldName;
        private String oldValue;
        private String newValue;
        private String modifiedBy;
        private LocalDateTime modifiedAt = LocalDateTime.now(); // mặc định

        public Builder id(Long id) { this.id = id; return this; }
        public Builder productId(Long productId) { this.productId = productId; return this; }
        public Builder fieldName(String fieldName) { this.fieldName = fieldName; return this; }
        public Builder oldValue(String oldValue) { this.oldValue = oldValue; return this; }
        public Builder newValue(String newValue) { this.newValue = newValue; return this; }
        public Builder modifiedBy(String modifiedBy) { this.modifiedBy = modifiedBy; return this; }
        public Builder modifiedAt(LocalDateTime modifiedAt) { this.modifiedAt = modifiedAt; return this; }

        public ProductAudit build() {
            // Kiểm tra các trường bắt buộc (tuỳ logic)
            if (productId == null) throw new IllegalStateException("productId is required");
            if (fieldName == null || fieldName.trim().isEmpty()) throw new IllegalStateException("fieldName is required");
            if (modifiedBy == null) throw new IllegalStateException("modifiedBy is required");
            return new ProductAudit(this);
        }
    }
}