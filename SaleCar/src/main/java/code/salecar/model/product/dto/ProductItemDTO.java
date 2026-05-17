package code.salecar.model.product.dto;

import code.salecar.model.enumeration.Status;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

public class ProductItemDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private long id;
    private String name;
    private double price;
    private double finalPrice;
    private double discountPercent;
    private long brandId;
    private long categoryId;
    private String ratio;
    private Status status;
    private String image;
    private String categoryName;
    private String brandName;
    private double avgRating;
    private int reviewCount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // 1. Constructor mặc định
    public ProductItemDTO() {
    }
    // 2. Constructor với tất cả tham số
    public ProductItemDTO(long id, String name, double price, double finalPrice,
                          double discountPercent, long brandId, long categoryId,
                          String ratio, Status status, String image,
                          String categoryName, String brandName, double avgRating,
                          int reviewCount, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.finalPrice = finalPrice;
        this.discountPercent = discountPercent;
        this.brandId = brandId;
        this.categoryId = categoryId;
        this.ratio = ratio;
        this.status = status;
        this.image = image;
        this.categoryName = categoryName;
        this.brandName = brandName;
        this.avgRating = avgRating;
        this.reviewCount = reviewCount;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    // 3. Constructor nhận Builder (private)
    private ProductItemDTO(Builder builder) {
        this.id = builder.id;
        this.name = builder.name;
        this.price = builder.price;
        this.finalPrice = builder.finalPrice;
        this.discountPercent = builder.discountPercent;
        this.brandId = builder.brandId;
        this.categoryId = builder.categoryId;
        this.ratio = builder.ratio;
        this.status = builder.status;
        this.image = builder.image;
        this.categoryName = builder.categoryName;
        this.brandName = builder.brandName;
        this.avgRating = builder.avgRating;
        this.reviewCount = builder.reviewCount;
        this.createdAt = builder.createdAt;
        this.updatedAt = builder.updatedAt;
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
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public double getFinalPrice() {
        return finalPrice;
    }
    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }
    public double getDiscountPercent() {
        return discountPercent;
    }
    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }
    public long getBrandId() {
        return brandId;
    }
    public void setBrandId(long brandId) {
        this.brandId = brandId;
    }
    public long getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(long categoryId) {
        this.categoryId = categoryId;
    }
    public String getRatio() {
        return ratio;
    }
    public void setRatio(String ratio) {
        this.ratio = ratio;
    }
    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public String getCategoryName() {
        return categoryName;
    }
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    public String getBrandName() {
        return brandName;
    }
    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
    public double getAvgRating() {
        return avgRating;
    }
    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }
    public int getReviewCount() {
        return reviewCount;
    }
    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public Date getCreatedAtDate() {
        return java.sql.Timestamp.valueOf(createdAt);
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    // 5. Builder pattern
    public static Builder builder() {
        return new Builder();
    }
    public static class Builder {
        private long id;
        private String name;
        private double price;
        private double finalPrice;
        private double discountPercent;
        private long brandId;
        private long categoryId;
        private String ratio;
        private Status status;
        private String image;
        private String categoryName;
        private String brandName;
        private double avgRating;
        private int reviewCount;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;

        public Builder id(long id) {
            this.id = id;
            return this;
        }

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Builder price(double price) {
            this.price = price;
            return this;
        }

        public Builder finalPrice(double finalPrice) {
            this.finalPrice = finalPrice;
            return this;
        }

        public Builder discountPercent(double discountPercent) {
            this.discountPercent = discountPercent;
            return this;
        }

        public Builder brandId(long brandId) {
            this.brandId = brandId;
            return this;
        }

        public Builder categoryId(long categoryId) {
            this.categoryId = categoryId;
            return this;
        }

        public Builder ratio(String ratio) {
            this.ratio = ratio;
            return this;
        }

        public Builder status(Status status) {
            this.status = status;
            return this;
        }

        public Builder image(String image) {
            this.image = image;
            return this;
        }

        public Builder categoryName(String categoryName) {
            this.categoryName = categoryName;
            return this;
        }

        public Builder brandName(String brandName) {
            this.brandName = brandName;
            return this;
        }

        public Builder avgRating(double avgRating) {
            this.avgRating = avgRating;
            return this;
        }

        public Builder reviewCount(int reviewCount) {
            this.reviewCount = reviewCount;
            return this;
        }

        public Builder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public Builder updatedAt(LocalDateTime updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }

        public ProductItemDTO build() {
            // Có thể thêm validation nhẹ nếu cần, nhưng DTO thường không bắt buộc
            return new ProductItemDTO(this);
        }
    }
    @Override
    public String toString() {
        return "ProductItemDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", finalPrice=" + finalPrice +
                ", discountPercent=" + discountPercent +
                ", brandId=" + brandId +
                ", categoryId=" + categoryId +
                ", ratio='" + ratio + '\'' +
                ", status=" + status +
                ", image='" + image + '\'' +
                ", categoryName='" + categoryName + '\'' +
                ", brandName='" + brandName + '\'' +
                ", avgRating=" + avgRating +
                ", reviewCount=" + reviewCount +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}