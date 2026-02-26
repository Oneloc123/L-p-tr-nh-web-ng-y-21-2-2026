package code.salecar.model;

import java.util.Date;

public class Product {
    private int id;
    private String name;
    private double price;
    private int brandid;
    private int categoryid;
    private String description;
    private String ratio;
    private String size;
    private String meterial;
    private String orign;
    private boolean status;
    private Date createat;
    private Date updateat;

    private String brandName;


    public Product(int id, String name, double price, int brandid, int categoryid, String description, String ratio, String size, String meterial, String orign, boolean status, Date createat, Date updateat) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.brandid = brandid;
        this.categoryid = categoryid;
        this.description = description;
        this.ratio = ratio;
        this.size = size;
        this.meterial = meterial;
        this.orign = orign;
        this.status = status;
        this.createat = createat;
        this.updateat = updateat;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getRatio() {
        return ratio;
    }

    public void setRatio(String ratio) {
        this.ratio = ratio;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getMeterial() {
        return meterial;
    }

    public void setMeterial(String meterial) {
        this.meterial = meterial;
    }

    public String getOrign() {
        return orign;
    }

    public void setOrign(String orign) {
        this.orign = orign;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
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
