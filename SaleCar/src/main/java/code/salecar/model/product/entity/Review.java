package code.salecar.model.product.entity;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

public class Review implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private int userId;
    private Long productId;
    private int rating;
    private String comment;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String userName;
    private String avatar;

    // 1. Constructor mặc định
    public Review() {
    }
    // 2. Constructor với tất cả tham số (dùng cho Builder)
    public Review(Long id, int userId, Long productId, int rating, String comment,
                  LocalDateTime createdAt, LocalDateTime updatedAt, String userName, String avatar) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.userName = userName;
        this.avatar = avatar;
    }
    // 3. Constructor nhận Builder (private)
    private Review(Builder builder) {
        this.id = builder.id;
        this.userId = builder.userId;
        this.productId = builder.productId;
        this.rating = builder.rating;
        this.comment = builder.comment;
        this.createdAt = builder.createdAt;
        this.updatedAt = builder.updatedAt;
        this.userName = builder.userName;
        this.avatar = builder.avatar;
    }

    // 4. Getter và Setter
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public Long getProductId() {
        return productId;
    }
    public void setProductId(Long productId) {
        this.productId = productId;
    }
    public int getRating() {
        return rating;
    }
    public void setRating(int rating) {
        this.rating = rating;
    }
    public String getComment() {
        return comment;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
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
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getAvatar() {
        return avatar;
    }
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    // 5. Builder
    public static Builder builder() {
        return new Builder();
    }
    public static class Builder {
        private Long id;
        private int userId;
        private Long productId;
        private int rating;
        private String comment;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        private String userName;
        private String avatar;

        public Builder id(Long id) {
            this.id = id;
            return this;
        }

        public Builder userId(int userId) {
            this.userId = userId;
            return this;
        }

        public Builder productId(Long productId) {
            this.productId = productId;
            return this;
        }

        public Builder rating(int rating) {
            this.rating = rating;
            return this;
        }

        public Builder comment(String comment) {
            this.comment = comment;
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

        public Builder userName(String userName) {
            this.userName = userName;
            return this;
        }

        public Builder avatar(String avatar) {
            this.avatar = avatar;
            return this;
        }

        public Review build() {
            // Có thể thêm validation nếu cần
            if (rating < 1 || rating > 5) {
                throw new IllegalArgumentException("Rating must be between 1 and 5");
            }
            if (productId == null) {
                throw new IllegalStateException("productId is required");
            }
            return new Review(this);
        }
    }

    // 6. (Tuỳ chọn) toString
    @Override
    public String toString() {
        return "Reviews{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", userName='" + userName + '\'' +
                ", avatar='" + avatar + '\'' +
                '}';
    }
}