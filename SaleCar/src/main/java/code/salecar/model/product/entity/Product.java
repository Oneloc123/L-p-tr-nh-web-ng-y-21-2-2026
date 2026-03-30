package code.salecar.model.product.entity;

import java.util.Date;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private double price;
    private double finalPrice;
    private double discountPercent;
    private Date discountUpdatedAt;
    private int brandId;
    private int categoryId;
    private String description;
    private String ratio;
    private String size;
    private String material;
    private String origin;
    private int status;
    private Date createdAt;
    private Date updatedAt;


    public Product(int id, String name, double price, double finalPrice, double discountPercent, Date discountUpdatedAt, int brandId, int categoryId, String description, String ratio, String size, String material, String origin, int status, Date createdAt, Date updatedAt) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.finalPrice = finalPrice;
        this.discountPercent = discountPercent;
        this.discountUpdatedAt = discountUpdatedAt;
        this.brandId = brandId;
        this.categoryId = categoryId;
        this.description = description;
        this.ratio = ratio;
        this.size = size;
        this.material = material;
        this.origin = origin;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Product() {

    }

    public double getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }

    public Date getDiscountUpdatedAt() {
        return discountUpdatedAt;
    }

    public void setDiscountUpdatedAt(Date discountUpdatedAt) {
        this.discountUpdatedAt = discountUpdatedAt;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Product(int id) {
        this.id = id;
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

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
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

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
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
