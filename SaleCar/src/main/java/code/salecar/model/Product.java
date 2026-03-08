package code.salecar.model;

import java.util.Date;
import java.util.List;

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
    private String brandLink;
    private String categoryName;
    private double finalPrice;
    private Discount discount;
    private int ratePrice;

    private List<Reviews> reviews;
    private int totalReviews;
    private double avgRating = 0;
    private int oneStar = 0;
    private int twoStar = 0;
    private int threeStar = 0;
    private int fourStar = 0;
    private int fiveStar = 0;


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

    public Product(int id) {
        this.id = id;
    }

    public int getFiveStar() {
        return fiveStar;
    }

    public void setFiveStar(int fiveStar) {
        this.fiveStar = fiveStar;
    }

    public int getFourStar() {
        return fourStar;
    }

    public void setFourStar(int fourStar) {
        this.fourStar = fourStar;
    }

    public int getThreeStar() {
        return threeStar;
    }

    public void setThreeStar(int threeStar) {
        this.threeStar = threeStar;
    }

    public int getTwoStar() {
        return twoStar;
    }

    public void setTwoStar(int twoStar) {
        this.twoStar = twoStar;
    }

    public int getOneStar() {
        return oneStar;
    }

    public void setOneStar(int oneStar) {
        this.oneStar = oneStar;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    //  Lấy  ra cho list, tối ưu query
    public Product(int id, String name, double price, int brandid, int categoryid, String ratio) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.brandid = brandid;
        this.categoryid = categoryid;
        this.ratio = ratio;
    }

    public int getTotalReviews() {
        return reviews.size();
    }

    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }

    public int getRatePrice() {
        return ratePrice ;
    }

    public String getBrandLink() {
        return brandLink;
    }

    public void setBrandLink(String brandLink) {
        this.brandLink = brandLink;
    }

    public List<Reviews> getReviews() {
        return reviews;
    }

    public void setReviews(List<Reviews> reviews) {
        this.reviews = reviews;
    }

    public void setRatePrice(int ratePrice) {
        this.ratePrice = ratePrice;
    }

    public Discount getDiscount() {
        return discount;
    }

    public void setDiscount(Discount discount) {
        this.discount = discount;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public double getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
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
