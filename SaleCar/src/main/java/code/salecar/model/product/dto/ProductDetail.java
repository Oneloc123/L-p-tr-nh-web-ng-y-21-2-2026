package code.salecar.model.product.dto;

import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.Reviews;

import java.util.List;

public class ProductDetail {

    private Product product;

    private String brandName;
    private String brandLink;

    private String categoryName;

    private Discount discount;


    private List<Reviews> reviews;

    private double avgRating;
    private int totalReviews;
    private ProductRating rating;

    private int ratePrice;


    public ProductDetail(Product product) {
        this.product = product;
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

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
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
}
