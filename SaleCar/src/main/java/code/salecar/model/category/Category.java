package code.salecar.model.category;

import java.util.Date;

public class Category {
    private int id;
    private String name;
    private String description;
    private String icon;
    private int status;
    private Date createdAt;
    private Date updatedAt;

    private String image;
    private int productCount;


    public Category(int id, String name, String icon) {
        this.id = id;
        this.name = name;
        this.icon = icon;
    }

    public Category() {
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    public int getIntStatus() {
        return status;
    }

    public String getStatus() {
        if (status == 1) {
            return "active";
        } else {
            return "inactive";
        }
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setStatus(String status) {
        if (status.equals("active")) {
            this.status = 1;
        } else if (status.equals("inactive")) {
            this.status = 0;
        }
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
