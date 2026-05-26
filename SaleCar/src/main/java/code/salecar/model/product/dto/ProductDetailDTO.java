package code.salecar.model.product.dto;

import code.salecar.model.brand.BrandInfo;
import code.salecar.model.category.CategoryInfo;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.*;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class ProductDetailDTO {
    private final Product product;
    private final BrandInfo brand;
    private final CategoryInfo category;
    private final List<String> images;
    private final ProductSalesInfo salesInfo;
    private final DiscountInfo activeDiscount;
    private final List<ReviewSummary> reviews;
    private final ProductRatingDistribution ratingDist;
    private final List<ProductVariants> variants;
    private List<ActivityLog> activityLogs;


    private ProductDetailDTO(Builder builder) {
        this.product = builder.product;
        this.brand = builder.brand;
        this.category = builder.category;
        this.images = builder.images;
        this.salesInfo = builder.salesInfo;
        this.activeDiscount = builder.activeDiscount;
        this.reviews = builder.reviews;
        this.ratingDist = builder.ratingDist;
        this.variants = builder.variants;
        this.activityLogs = builder.activityLogs;
    }

    // Getters
    public Product getProduct() { return product; }
    public BrandInfo getBrand() { return brand; }
    public CategoryInfo getCategory() { return category; }
    public List<String> getImages() { return images; }
    public ProductSalesInfo getSalesInfo() { return salesInfo; }
    public DiscountInfo getActiveDiscount() { return activeDiscount; }
    public List<ReviewSummary> getReviews() { return reviews; }
    public ProductRatingDistribution getRatingDist() { return ratingDist; }
    public double getAverageRating() {
    if (reviews == null || reviews.isEmpty()) {
        return 0;
    }
    return reviews.stream()
            .mapToDouble(ReviewSummary::getRating)
            .average()
            .orElse(0);
}
    public int  getTotalReviews() {
        return reviews != null ? reviews.size() : 0;
    }
    public long getBrandId() {return brand != null ? brand.getBrandId() : 0;}
    public String getBrandName() {return brand != null ? brand.getName() : "Unknown Brand";}
    public long getCategoryId() {return category != null ? category.getCategoryId() : 0;}
    public String getCategoryName() {return category != null ? category.getName() : "Unknown Category";}
    public String getProductName() {return product != null ? product.getName() : "Unknown Product";}
    public String getRatio(){return product != null ? product.getRatio() : "Unknown Product";}
    public double getFinalPrice() {
        if (product == null) return 0;
        double price = product.getPrice();
        double discountPercent = product.getDiscountPercent();
        return price * (100 - discountPercent) / 100;
    }
    public double getDiscountPercent(){return product != null ? product.getDiscountPercent() : 0;}
    public double getPrice(){return product != null ? product.getPrice() : 0;}
    public String getSize() { return product != null ? product.getSize() : ""; }
    public String getMaterial() { return product != null ? product.getMaterial() : ""; }
    public String getOrigin() { return product != null ? product.getOrigin() : ""; }
    public String getDescription() { return product != null ? product.getDescription() : ""; }
    public long getProductId() { return product != null ? product.getId(): 0; }
    public Date getCreatedAtDate() { return product != null ? Timestamp.valueOf(product.getCreatedAt()) : null; }
    public Date getUpdatedAtDate() { return product != null ? Timestamp.valueOf(product.getUpdatedAt()) : null; }
    public int getQuantity() {return salesInfo != null ? salesInfo.getQuantity() : 0;}
    public int getSoldQuantity() {return salesInfo != null ? salesInfo.getSoldQuantity() : 0;}
    public Status getStatus() { return product != null ? product.getStatus() : Status.INACTIVE; }
    public String getBrandLogo() { return brand != null ? brand.getLogo() : ""; }
    public String getBrandLink() { return brand != null ? brand.getLink() : ""; }
    public List<ProductVariants> getVariants() {
        calcFinalPrice();
        return variants;}
    public void calcFinalPrice(){
        for(ProductVariants variant: variants){
            BigDecimal price = variant.getPrice();
            double discountPercent = getDiscountPercent();
            double dn = price.doubleValue() * (100 - discountPercent) /100;
            variant.setFinalPrice(new BigDecimal(dn));
        }
    }
    public List<ActivityLog> getActivityLogs() {
        return activityLogs;
    }
    public void setActivityLogs(List<ActivityLog> activityLogs) {
        this.activityLogs = activityLogs;
    }

    //Lỗi
    public String getSku() { return product != null ? "WWW" : ""; }
    public String getVariantName() { return variants != null ? variants.get(0).getVariantName() : ""; }


    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private Product product;
        private BrandInfo brand;
        private CategoryInfo category;
        private List<String> images;
        private ProductSalesInfo salesInfo;
        private DiscountInfo activeDiscount;
        private List<ReviewSummary> reviews;
        private ProductRatingDistribution ratingDist;
        private List<ProductVariants> variants;
        private List<ActivityLog> activityLogs;

        public Builder product(Product product) { this.product = product; return this; }
        public Builder brand(BrandInfo brand) { this.brand = brand; return this; }
        public Builder category(CategoryInfo category) { this.category = category; return this; }
        public Builder images(List<String> images) { this.images = images; return this; }
        public Builder salesInfo(ProductSalesInfo salesInfo) { this.salesInfo = salesInfo; return this; }
        public Builder activeDiscount(DiscountInfo activeDiscount) { this.activeDiscount = activeDiscount; return this; }
        public Builder reviews(List<ReviewSummary> reviews) { this.reviews = reviews; return this; }
        public Builder ratingDist(ProductRatingDistribution ratingDist) { this.ratingDist = ratingDist; return this; }
        public Builder variants(List<ProductVariants> variants) { this.variants = variants; return this; }
        public Builder activityLogs(List<ActivityLog> activityLogs) { this.activityLogs = activityLogs; return this; }

        public ProductDetailDTO build() {
            return new ProductDetailDTO(this);
        }
    }
}