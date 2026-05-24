package code.salecar.model.brand;

import code.salecar.model.enumeration.Status;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class Brand {
    private long id;
    private String name;
    private String description;
    private String image;
    private String linkBrand;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private int productCount;


    public Brand(long id, String name, String description, String image, String linkBrand, Status status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.linkBrand = linkBrand;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Brand() {
    }

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getLinkBrand() {
        return linkBrand;
    }

    public void setLinkBrand(String linkBrand) {
        this.linkBrand = linkBrand;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public int getIntStatus() {
        return status.getCode();
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public Date getCreatedAtDate() {
        return Timestamp.valueOf(createdAt);
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    public Date getUpdatedAtDate() {
        return Timestamp.valueOf(updatedAt);
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }
}
