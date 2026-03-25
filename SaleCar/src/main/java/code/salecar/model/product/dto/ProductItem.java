package code.salecar.model.product.dto;

import java.io.Serializable;
import java.sql.Date;

public class ProductItem implements Serializable {


    private int id;
    private String name;

    private double price;
    private double finalPrice;
    private double discountPercent;
    private int brandId;
    private int categoryId;
    private String ratio;

    private String image;

    private String categoryName;
    private String brandName;

    private double avgRating;
    private  int reviewCount;

    private Date createdAt;

    public ProductItem(int id) {
        this.id = id;
    }

    public ProductItem(int id, String name, double price, double finalPrice, double discountPercent, int brandId, int categoryId, String ratio) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.finalPrice = finalPrice;
        this.discountPercent = discountPercent;
        this.brandId = brandId;
        this.categoryId = categoryId;
        this.ratio = ratio;
    }

    // Lấy cho discount update
    public ProductItem(int id, double price, double finalPrice, double discountPercent, int brandId, int categoryId, Date createdAt) {
        this.id = id;
        this.price = price;
        this.finalPrice = finalPrice;
        this.discountPercent = discountPercent;
        this.brandId = brandId;
        this.categoryId = categoryId;
        this.createdAt = createdAt;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getReviewCount() {
        return reviewCount;
    }

    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
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

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
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

    public double getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public String getRatio() {
        return ratio;
    }

    public void setRatio(String ratio) {
        this.ratio = ratio;
    }
}
