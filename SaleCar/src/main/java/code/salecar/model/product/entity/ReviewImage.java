package code.salecar.model.product.entity;

import java.time.LocalDateTime;

public class ReviewImage {
    private Long id;
    private Long reviewId;
    private String imageUrl;
    private LocalDateTime createdAt;

    public static Builder builder() { return new Builder(); }
    private ReviewImage(Builder builder) {
        this.id = builder.id;
        this.reviewId = builder.reviewId;
        this.imageUrl = builder.imageUrl;
        this.createdAt = builder.createdAt;
    }
    public ReviewImage() {
    }

    //getter
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public Long getReviewId() {
        return reviewId;
    }
    public Long getId() {
        return id;
    }
    //setter
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public static class Builder {
        private Long id;
        private Long reviewId;
        private String imageUrl;
        private LocalDateTime createdAt;

        public Builder id(Long id) { this.id = id; return this; }
        public Builder reviewId(Long reviewId) { this.reviewId = reviewId; return this; }
        public Builder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public Builder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public ReviewImage build() {return new ReviewImage(this);}
    }
}