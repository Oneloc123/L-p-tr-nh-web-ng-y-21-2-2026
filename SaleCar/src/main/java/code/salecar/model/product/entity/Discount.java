package code.salecar.model.product.entity;

import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.DiscountEntityType;
import code.salecar.model.enumeration.Status;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class Discount implements Serializable {
    private static final long serialVersionUID = 1L;

    private long id;
    private String name;
    private DiscountValueType valueType;
    private BigDecimal value;
    private DiscountEntityType entityType;
    private long entityId;
    private Status status;
    private LocalDateTime startAt;
    private LocalDateTime endAt;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;
    private double percent;
    /** Số lượng product mà discount này áp dụng lên (chỉ dùng cho màn hình Admin, không lưu DB) */
    private long appliedProductsCount;

    public long getAppliedProductsCount() {
        return appliedProductsCount;
    }
    public void setAppliedProductsCount(long appliedProductsCount) {
        this.appliedProductsCount = appliedProductsCount;
    }

    // 1. Constructor mặc định
    public Discount() {
    }

    // 2. Constructor với tất cả tham số
    public Discount(long id, String name, DiscountValueType valueType, BigDecimal value,
                    DiscountEntityType entityType, long entityId, Status status,
                    LocalDateTime startAt, LocalDateTime endAt,
                    LocalDateTime createAt, LocalDateTime updateAt,
                    double percent) {
        this.id = id;
        this.name = name;
        this.valueType = valueType;
        this.value = value;
        this.entityType = entityType;
        this.entityId = entityId;
        this.status = status;
        this.startAt = startAt;
        this.endAt = endAt;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.percent = percent;
    }

    // 3. Constructor nhận Builder (private)
    private Discount(Builder builder) {
        this.id = builder.id;
        this.name = builder.name;
        this.valueType = builder.valueType;
        this.value = builder.value;
        this.entityType = builder.entityType;
        this.entityId = builder.entityId;
        this.status = builder.status;
        this.startAt = builder.startAt;
        this.endAt = builder.endAt;
        this.createAt = builder.createAt;
        this.updateAt = builder.updateAt;
        this.percent = builder.percent;
    }

    // 4. Getter và Setter
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public DiscountValueType getValueType() {
        return valueType;
    }
    public void setValueType(DiscountValueType valueType) {
        this.valueType = valueType;
    }
    public BigDecimal getValue() {
        return value;
    }
    public void setValue(BigDecimal value) {
        this.value = value;
    }
    public DiscountEntityType getEntityType() {
        return entityType;
    }
    public void setEntityType(DiscountEntityType entityType) {
        this.entityType = entityType;
    }
    public long getEntityId() {
        return entityId;
    }
    public void setEntityId(long entityId) {
        this.entityId = entityId;
    }
    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }
    public LocalDateTime getStartAt() {
        return startAt;
    }
    public void setStartAt(LocalDateTime startAt) {
        this.startAt = startAt;
    }
    public LocalDateTime getEndAt() {
        return endAt;
    }
    public void setEndAt(LocalDateTime endAt) {
        this.endAt = endAt;
    }
    public LocalDateTime getCreateAt() {
        return createAt;
    }
    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }
    public LocalDateTime getUpdateAt() {
        return updateAt;
    }
    public void setUpdateAt(LocalDateTime updateAt) {
        this.updateAt = updateAt;
    }
    public double getPercent() {
        return percent;
    }
    public void setPercent(double percent) {
        this.percent = percent;
    }

    /** Date getters for JSP formatting */
    public Date getStartAtDate() {
        return startAt != null ? Timestamp.valueOf(startAt) : null;
    }
    public Date getEndAtDate() {
        return endAt != null ? Timestamp.valueOf(endAt) : null;
    }
    public Date getCreateAtDate() {
        return createAt != null ? Timestamp.valueOf(createAt) : null;
    }

    // 5. Builder pattern
    public static Builder builder() {
        return new Builder();
    }
    public static class Builder {
        private long id;
        private String name;
        private DiscountValueType valueType;
        private BigDecimal value;
        private DiscountEntityType entityType;
        private long entityId;
        private Status status;
        private LocalDateTime startAt;
        private LocalDateTime endAt;
        private LocalDateTime createAt;
        private LocalDateTime updateAt;
        private double percent;

        public Builder id(long id) {
            this.id = id;
            return this;
        }
        public Builder name(String name) {
            this.name = name;
            return this;
        }
        public Builder valueType(DiscountValueType valueType) {
            this.valueType = valueType;
            return this;
        }
        public Builder value(BigDecimal value) {
            this.value = value;
            return this;
        }
        public Builder entityType(DiscountEntityType entityType) {
            this.entityType = entityType;
            return this;
        }
        public Builder entityId(long entityId) {
            this.entityId = entityId;
            return this;
        }
        public Builder status(Status status) {
            this.status = status;
            return this;
        }
        public Builder startAt(LocalDateTime startAt) {
            this.startAt = startAt;
            return this;
        }
        public Builder endAt(LocalDateTime endAt) {
            this.endAt = endAt;
            return this;
        }
        public Builder createAt(LocalDateTime createAt) {
            this.createAt = createAt;
            return this;
        }
        public Builder updateAt(LocalDateTime updateAt) {
            this.updateAt = updateAt;
            return this;
        }
        public Builder percent(double percent) {
            this.percent = percent;
            return this;
        }

        public Discount build() {
            // Validation
            if (name == null ) {
                throw new IllegalArgumentException("Tên discount không được để trống");
            }
            if (valueType == null) {
                throw new IllegalArgumentException("ValueType không được null");
            }
            if (value == null || value.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Giá trị discount phải lớn hơn 0");
            }
            if (valueType == DiscountValueType.PERCENT && value.compareTo(BigDecimal.valueOf(100)) > 0) {
                throw new IllegalArgumentException("Phần trăm giảm không được vượt quá 100");
            }
            if (entityType == null) {
                throw new IllegalArgumentException("EntityType không được null");
            }
            if (entityId <= 0) {
                throw new IllegalArgumentException("EntityId phải lớn hơn 0");
            }
            if (startAt != null && endAt != null && endAt.isBefore(startAt)) {
                throw new IllegalArgumentException("Ngày kết thúc phải sau ngày bắt đầu");
            }
            if (percent < 0 || percent > 100) {
                throw new IllegalArgumentException("percent phải nằm trong khoảng 0-100");
            }
            return new Discount(this);
        }
    }

    @Override
    public String toString() {
        return "Discount{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", valueType=" + valueType +
                ", value=" + value +
                ", entityType=" + entityType +
                ", entityId=" + entityId +
                ", status=" + status +
                ", startAt=" + startAt +
                ", endAt=" + endAt +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                ", percent=" + percent +
                '}';
    }
}