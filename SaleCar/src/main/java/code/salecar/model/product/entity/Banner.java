package code.salecar.model.product.entity;

import code.salecar.model.enumeration.Status;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class Banner {
    private Long id;
    private String title;
    private String description;
    private String imageUrl;
    private String redirectUrl;
    private int sortOrder;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Banner() {}

    public Banner(Long id, String title, String description, String imageUrl, String redirectUrl, int sortOrder, Status status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.imageUrl = imageUrl;
        this.redirectUrl = redirectUrl;
        this.sortOrder = sortOrder;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // ========== GETTERS ==========
    public Long getId() { return id; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getImageUrl() { return imageUrl; }
    public String getRedirectUrl() { return redirectUrl; }
    public int getSortOrder() { return sortOrder; }
    public Status getStatus() { return status; }
    public int getIntStatus() { return status.getCode(); }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public Date getCreatedAtDate() { return createdAt != null ? Timestamp.valueOf(createdAt) : null; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public Date getUpdatedAtDate() { return updatedAt != null ? Timestamp.valueOf(updatedAt) : null; }

    // ========== SETTERS ==========
    public void setId(Long id) { this.id = id; }
    public void setTitle(String title) { this.title = title; }
    public void setDescription(String description) { this.description = description; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public void setRedirectUrl(String redirectUrl) { this.redirectUrl = redirectUrl; }
    public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }
    public void setStatus(Status status) { this.status = status; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}