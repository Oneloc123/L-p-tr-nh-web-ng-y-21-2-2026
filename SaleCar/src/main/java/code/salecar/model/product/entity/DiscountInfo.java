package code.salecar.model.product.entity;

import code.salecar.model.enumeration.DiscountValueType;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class DiscountInfo {
    private Long discountId;
    private String name;
    private DiscountValueType discountType;
    private BigDecimal value;
    private LocalDateTime startAt;
    private LocalDateTime endAt;

    public DiscountInfo() { }
    public DiscountInfo(Builder builder) {
        this.discountId = builder.discountId;
        this.name = builder.name;
        this.discountType = builder.discountType;
        this.value = builder.value;
        this.startAt = builder.startAt;
        this.endAt = builder.endAt;}

    public Long getDiscountId() {
        return discountId;
    }
    public String getName() {
        return name;
    }
    public DiscountValueType getDiscountType() {
        return discountType;
    }
    public BigDecimal getValue() {
        return value;
    }
    public LocalDateTime getStartAt() {
        return startAt;
    }
    public LocalDateTime getEndAt() {
        return endAt;
    }
    public Date getStartAtDate() {return Timestamp.valueOf(startAt);}
    public Date getEndAtDate() {return Timestamp.valueOf(endAt);}

    public static Builder builder() { return new Builder(); }
    public static class Builder {
        private Long discountId;
        private String name;
        private DiscountValueType discountType;
        private BigDecimal value;
        private LocalDateTime startAt;
        private LocalDateTime endAt;

        public Builder discountId(Long discountId) { this.discountId = discountId; return this; }
        public Builder name(String name) { this.name = name; return this; }
        public Builder discountType(DiscountValueType discountType) { this.discountType = discountType; return this; }
        public Builder value(BigDecimal value) { this.value = value; return this; }
        public Builder startAt(LocalDateTime startAt) { this.startAt = startAt; return this; }
        public Builder endAt(LocalDateTime endAt) { this.endAt = endAt; return this; }

        public DiscountInfo build() {
            // Validate các trường bắt buộc (tuỳ logic)
            if (discountId == null) throw new IllegalStateException("discountId is required");
            if (name == null) throw new IllegalStateException("name is required");
            if (discountType == null) throw new IllegalStateException("discountType is required");
            if (value == null || value.compareTo(BigDecimal.ZERO) <= 0) throw new IllegalStateException("value must be positive");
            // Không validate startAt, endAt (có thể null)
            return new DiscountInfo(this);
        }
    }
}
