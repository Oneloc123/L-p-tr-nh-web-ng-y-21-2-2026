package code.salecar.model;

import java.util.Date;

public class Brand {
    private int id;
    private String name;
    private String description;
    private String image;
    private String linkBrand;
    private Date createdAt;
    private Date updatedAt;

    public Brand(int id, String name, String description, String linkBrand, Date createdAt, Date updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.linkBrand = linkBrand;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Lấy cho home
    public Brand(String name, String image) {
        this.name = name;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
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
}
