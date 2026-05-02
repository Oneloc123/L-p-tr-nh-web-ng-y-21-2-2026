package code.salecar.model.brand;

import java.util.Date;

public class Brand {
    private int id;
    private String name;
    private String description;
    private String image;
    private String linkBrand;
    private int status;
    private Date createdAt;
    private Date updatedAt;

    private int productCount;


    public Brand(int id, String name, String description, String linkBrand, int status, Date createdAt, Date updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.linkBrand = linkBrand;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Lấy cho home
    public Brand(String name, String image) {
        this.name = name;
        this.image = image;
    }

    public Brand() {
    }

    public String getStatus() {
        if (status == 0) {
            return "inactive";
        } else if (status == 1) {
            return "active";
        }
        throw new IllegalStateException("Unexpected value: " + status);
    }
    public int getIntStatus(){
        return this.status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    public void setStatus(String status) {
        if (status != null && !status.isEmpty()) {
            if (status.toLowerCase().equals("inactive")) {
                this.status = 0;
            } else if (status.toLowerCase().equals("active")) {
                this.status = 1;
            }
        }else {
            this.status = 2;
        }
    }


    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
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
