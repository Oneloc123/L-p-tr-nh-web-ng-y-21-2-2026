package code.salecar.model;

import java.util.Date;

public class Products {
    private int id;
    private String name;
    private float price;
    private int brandid;
    private int categoryid;
    private String description;
    private Date createat;
    private Date updateat;

    public Products(int id, String name, float price, int brandid, int categoryid, String description, Date createat, Date updateat) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.brandid = brandid;
        this.categoryid = categoryid;
        this.description = description;
        this.createat = createat;
        this.updateat = updateat;
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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getBrandid() {
        return brandid;
    }

    public void setBrandid(int brandid) {
        this.brandid = brandid;
    }

    public int getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(int categoryid) {
        this.categoryid = categoryid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateat() {
        return createat;
    }

    public void setCreateat(Date createat) {
        this.createat = createat;
    }

    public Date getUpdateat() {
        return updateat;
    }

    public void setUpdateat(Date updateat) {
        this.updateat = updateat;
    }
}
