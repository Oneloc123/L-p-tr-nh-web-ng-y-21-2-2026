package code.salecar.model.product.entity;

import java.time.LocalDateTime;

public class ReviewSummary {
    private int rating;
    private String comment;
    private String userName;
    private String avatar;
    private LocalDateTime createdAt;

    // 1. Constructor mặc định
    public ReviewSummary() {
    }
    // 2. Constructor với tất cả tham số
    public ReviewSummary(int rating, String comment, String userName, String avatar, LocalDateTime createdAt) {
        this.rating = rating;
        this.comment = comment;
        this.userName = userName;
        this.avatar = avatar;
        this.createdAt = createdAt;
    }
    // 3. Constructor nhận Builder (private)
    private ReviewSummary(Builder builder) {
        this.rating = builder.rating;
        this.comment = builder.comment;
        this.userName = builder.userName;
        this.avatar = builder.avatar;
        this.createdAt = builder.createdAt;
    }

    // 4. Getter và Setter
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
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // 5. Builder pattern
    public static Builder builder() {
        return new Builder();
    }
    public static class Builder {
        private int rating;
        private String comment;
        private String userName;
        private String avatar;
        private LocalDateTime createdAt;

        public Builder rating(int rating) {
            this.rating = rating;
            return this;
        }
        public Builder comment(String comment) {
            this.comment = comment;
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
        public Builder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }
        public ReviewSummary build() {
            // Validation cơ bản (tuỳ chỉnh nếu cần)
            if (rating < 1 || rating > 5) {
                throw new IllegalArgumentException("Rating phải từ 1 đến 5");
            }
            if (comment == null ) {
                throw new IllegalArgumentException("Bình luận không được để trống");
            }
            if (userName == null ) {
                throw new IllegalArgumentException("Tên người dùng không được để trống");
            }
            // createdAt có thể null, không bắt buộc
            return new ReviewSummary(this);
        }
    }

    // 6. toString (tuỳ chọn)
    @Override
    public String toString() {
        return "ReviewSummary{" +
                "rating=" + rating +
                ", comment='" + comment + '\'' +
                ", userName='" + userName + '\'' +
                ", avatar='" + avatar + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}