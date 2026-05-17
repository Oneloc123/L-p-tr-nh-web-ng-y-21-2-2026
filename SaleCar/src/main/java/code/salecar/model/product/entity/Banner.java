package code.salecar.model.product.entity;

import code.salecar.model.enumeration.Status;
import java.time.LocalDateTime;

public class Banner {
    private Long id;
    private String title;
    private String imageUrl;
    private String link;
    private String position;
    private Status status;
    private int sortOrder;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Banner(Builder builder) {
        this.id = builder.id;
        this.title = builder.title;
        this.imageUrl = builder.imageUrl;
        this.link = builder.link;
        this.position = builder.position;
        this.status = builder.status;
        this.sortOrder = builder.sortOrder;
        this.createdAt = builder.createdAt;
        this.updatedAt = builder.updatedAt;
    }
    public static Builder builder() { return new Builder(); }

    // getters, setters
    public Long getId() {
        return id;
    }
    public String getTitle() {
        return title;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public String getLink() {
        return link;
    }
    public String getPosition() {
        return position;
    }
    public Status getStatus() {
        return status;
    }
    public int getSortOrder() {
        return sortOrder;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public void setLink(String link) {
        this.link = link;
    }
    public void setPosition(String position) {
        this.position = position;
    }
    public void setStatus(Status status) {
        this.status = status;
    }
    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public static class Builder {
        private  Long id;
        private String title;
        private String imageUrl;
        private String link;
        private String position;
        private Status status = Status.INACTIVE; // default
        private int sortOrder = 0; // default
        private LocalDateTime createdAt = LocalDateTime.now();
        private LocalDateTime updatedAt = LocalDateTime.now();

        public Builder id(Long id) { this.id = id; return this; }
        public Builder title(String title) { this.title = title; return this; }
        public Builder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public Builder link(String link) { this.link = link; return this; }
        public Builder position(String position) { this.position = position; return this; }
        public Builder status(Status status) { this.status = status; return this; }
        public Builder sortOrder(int sortOrder) { this.sortOrder = sortOrder; return this; }
        public Builder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public Builder updatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; return this; }

        public Banner build() {
            return new Banner(this);
        }
}
}