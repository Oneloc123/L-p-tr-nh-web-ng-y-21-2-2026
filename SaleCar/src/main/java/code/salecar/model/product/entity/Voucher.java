package code.salecar.model.product.entity;

import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class Voucher {
    private long id;
    private String code;
    private DiscountValueType valueType;      // phần trăm / số tiền cố định
    private BigDecimal value;
    private BigDecimal maxDiscount;
    private BigDecimal minOrderValue;
    private int usageLimit;
    private int usedCount;
    private int maxUsagePerUser;
    private LocalDateTime startAt;
    private LocalDateTime endAt;
    private Status status;
    private LocalDateTime createdAt;

    // 1. Constructor mặc định
    public Voucher() {
        this.maxUsagePerUser = 1;
    }
    // 2. Constructor với tất cả tham số (dùng cho Builder)
    public Voucher(long id, String code, DiscountValueType valueType, BigDecimal value,
                   BigDecimal maxDiscount, BigDecimal minOrderValue, int usageLimit,
                   int usedCount, LocalDateTime startAt, LocalDateTime endAt,
                   Status status, LocalDateTime createdAt) {
        this.id = id;
        this.code = code;
        this.valueType = valueType;
        this.value = value;
        this.maxDiscount = maxDiscount;
        this.minOrderValue = minOrderValue;
        this.usageLimit = usageLimit;
        this.usedCount = usedCount;
        this.maxUsagePerUser = 1;
        this.startAt = startAt;
        this.endAt = endAt;
        this.status = status;
        this.createdAt = createdAt;
    }
    // 3. Constructor nhận Builder (private)
    private Voucher(Builder builder) {
        this.id = builder.id;
        this.code = builder.code;
        this.valueType = builder.valueType;
        this.value = builder.value;
        this.maxDiscount = builder.maxDiscount;
        this.minOrderValue = builder.minOrderValue;
        this.usageLimit = builder.usageLimit;
        this.usedCount = builder.usedCount;
        this.maxUsagePerUser = builder.maxUsagePerUser;
        this.startAt = builder.startAt;
        this.endAt = builder.endAt;
        this.status = builder.status;
        this.createdAt = builder.createdAt;
    }

    // 4. Getter và Setter


    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    /** Getter Date để format trong JSP */
    public Date getStartAtDate() {
        return startAt != null ? Timestamp.valueOf(startAt) : null;
    }
    public Date getEndAtDate() {
        return endAt != null ? Timestamp.valueOf(endAt) : null;
    }
    public Date getCreatedAtDate() {
        return createdAt != null ? Timestamp.valueOf(createdAt) : null;
    }
    public Status getStatus() {
        return status;
    }
    public LocalDateTime getEndAt() {
        return endAt;
    }
    public LocalDateTime getStartAt() {
        return startAt;
    }
    public int getUsedCount() {
        return usedCount;
    }
    public int getUsageLimit() {
        return usageLimit;
    }
    public int getMaxUsagePerUser() {
        return maxUsagePerUser;
    }
    public BigDecimal getMinOrderValue() {
        return minOrderValue;
    }
    public BigDecimal getMaxDiscount() {
        return maxDiscount;
    }
    public BigDecimal getValue() {
        return value;
    }
    public DiscountValueType getValueType() {
        return valueType;
    }
    public String getCode() {
        return code;
    }
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public void setValueType(DiscountValueType valueType) {
        this.valueType = valueType;
    }
    public void setValue(BigDecimal value) {
        this.value = value;
    }
    public void setMaxDiscount(BigDecimal maxDiscount) {
        this.maxDiscount = maxDiscount;
    }
    public void setMinOrderValue(BigDecimal minOrderValue) {
        this.minOrderValue = minOrderValue;
    }
    public void setUsageLimit(int usageLimit) {
        this.usageLimit = usageLimit;
    }
    public void setMaxUsagePerUser(int maxUsagePerUser) {
        this.maxUsagePerUser = maxUsagePerUser;
    }
    public void setUsedCount(int usedCount) {
        this.usedCount = usedCount;
    }
    public void setStartAt(LocalDateTime startAt) {
        this.startAt = startAt;
    }
    public void setEndAt(LocalDateTime endAt) {
        this.endAt = endAt;
    }
    public void setStatus(Status status) {
        this.status = status;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // 5. Pattern Builder
    public static Builder builder() {
        return new Builder();
    }
    public static class Builder {
        private long id;
        private String code;
        private DiscountValueType valueType;
        private BigDecimal value;
        private BigDecimal maxDiscount;
        private BigDecimal minOrderValue;
        private int usageLimit;
        private int usedCount;
        private int maxUsagePerUser;
        private LocalDateTime startAt;
        private LocalDateTime endAt;
        private Status status;
        private LocalDateTime createdAt;

        public Builder id(long id) {
            this.id = id;
            return this;
        }
        public Builder code(String code) {
            this.code = code;
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
        public Builder maxDiscount(BigDecimal maxDiscount) {
            this.maxDiscount = maxDiscount;
            return this;
        }
        public Builder minOrderValue(BigDecimal minOrderValue) {
            this.minOrderValue = minOrderValue;
            return this;
        }
        public Builder usageLimit(int usageLimit) {
            this.usageLimit = usageLimit;
            return this;
        }
        public Builder usedCount(int usedCount) {
            this.usedCount = usedCount;
            return this;
        }
        public Builder maxUsagePerUser(int maxUsagePerUser) {
            this.maxUsagePerUser = maxUsagePerUser;
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
        public Builder status(Status status) {
            this.status = status;
            return this;
        }
        public Builder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public Voucher build() {
            // Validation cơ bản (có thể tuỳ chỉnh theo yêu cầu)
            if (code == null) {
                throw new IllegalArgumentException("Mã voucher không được để trống");
            }
            if (valueType == null) {
                throw new IllegalArgumentException("Loại giá trị giảm giá không được null");
            }
            if (value == null || value.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Giá trị giảm phải lớn hơn 0");
            }
            if (valueType == DiscountValueType.PERCENT && (value.compareTo(BigDecimal.valueOf(100)) > 0)) {
                throw new IllegalArgumentException("Phần trăm giảm không được vượt quá 100");
            }
            if (usageLimit < 0) {
                throw new IllegalArgumentException("Giới hạn sử dụng không được âm");
            }
            if (usedCount < 0) {
                throw new IllegalArgumentException("Số lần đã dùng không được âm");
            }
            if (startAt != null && endAt != null && endAt.isBefore(startAt)) {
                throw new IllegalArgumentException("Ngày kết thúc phải sau ngày bắt đầu");
            }
            return new Voucher(this);
        }
    }

    // 6. toString (tuỳ chọn)
    @Override
    public String toString() {
        return "Voucher{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", valueType=" + valueType +
                ", value=" + value +
                ", maxDiscount=" + maxDiscount +
                ", minOrderValue=" + minOrderValue +
                ", usageLimit=" + usageLimit +
                ", usedCount=" + usedCount +
                ", maxUsagePerUser=" + maxUsagePerUser +
                ", startAt=" + startAt +
                ", endAt=" + endAt +
                ", status=" + status +
                ", createdAt=" + createdAt +
                '}';
    }
}