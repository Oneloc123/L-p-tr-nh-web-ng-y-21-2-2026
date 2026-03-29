package code.salecar.model.product.dto;

import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.Reviews;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class ProductDetail implements Serializable {

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
    private boolean status;
    private Date createdAt;
    private Date updatedAt;
    
    private String brandName;
    private String brandLink;
    private String brandLogo;

    private String sku;
    private int quantity;
    private int soldQuantity;

    private String categoryName;

    private List<String> image;

    private Discount discount;

    private List<String> activityLogs;

    private List<Reviews> reviews;

    private double avgRating;
    private int totalReviews;
    private ProductRating rating;

    private int ratePrice;

    public ProductDetail() {
    }


    public ProductDetail(Product product) {
        this.id = product.getId();
        this.name = product.getName();
        this.price = product.getPrice();
        this.finalPrice = product.getFinalPrice();
        this.discountPercent = product.getDiscountPercent();
        this.discountUpdatedAt = product.getDiscountUpdatedAt();
        this.brandId = product.getBrandId();
        this.categoryId = product.getCategoryId();
        this.description = product.getDescription();
        this.ratio = product.getRatio();
        this.size = product.getSize();
        this.material = product.getMaterial();
        this.origin = product.getOrigin();
        this.status = product.isStatus();
        this.createdAt = product.getCreatedAt();
        this.updatedAt = product.getUpdatedAt();
    }

    //getRelatedProductBrand


    public ProductDetail(int id, String name, double price, double finalPrice, double discountPercent, int brandId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.finalPrice = finalPrice;
        this.discountPercent = discountPercent;
        this.brandId = brandId;
    }

    public Product getProduct(){
        Product product = new Product(id,name,price,finalPrice,discountPercent,discountUpdatedAt,brandId,categoryId,description,ratio,size,material,origin,status,createdAt,updatedAt);
        return product;
    }

    public List<String> getActivityLogs() {
        return activityLogs;
    }

    public void setActivityLogs(List<String> activityLogs) {
        this.activityLogs = activityLogs;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getBrandLogo() {
        return brandLogo;
    }

    public void setBrandLogo(String brandLogo) {
        this.brandLogo = brandLogo;
    }

    public List<String> getImage() {
        return image;
    }

    public void setImage(List<String> image) {
        this.image = image;
    }

    public int getRatePrice() {
        return ratePrice;
    }

    public void setRatePrice(int ratePrice) {
        this.ratePrice = ratePrice;
    }

    public ProductRating getRating() {
        return rating;
    }

    public void setRating(ProductRating rating) {
        this.rating = rating;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getBrandLink() {
        return brandLink;
    }

    public void setBrandLink(String brandLink) {
        this.brandLink = brandLink;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Discount getDiscount() {
        return discount;
    }

    public void setDiscount(Discount discount) {
        this.discount = discount;
    }

    public List<Reviews> getReviews() {
        return reviews;
    }

    public void setReviews(List<Reviews> reviews) {
        this.reviews = reviews;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    public int getTotalReviews() {
        return reviews.size();
    }

    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
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

    public Date getDiscountUpdatedAt() {
        return discountUpdatedAt;
    }

    public void setDiscountUpdatedAt(Date discountUpdatedAt) {
        this.discountUpdatedAt = discountUpdatedAt;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
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
