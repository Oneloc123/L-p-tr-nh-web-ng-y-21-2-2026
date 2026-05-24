package code.salecar.model.category;

import code.salecar.model.enumeration.Status;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class Category {
    private long id;
    private String name;
    private String description;
    private String icon;
    private String image;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int productCount;


    public Category(long id, String name, String icon) {
        this.id = id;
        this.name = name;
        this.icon = icon;
    }

    public Category() {
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

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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
    public Date  getCreatedAtDate() {return Timestamp.valueOf(getCreatedAt());}

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
public Date  getUpdatedAtDate() {return Timestamp.valueOf(getUpdatedAt());}

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
