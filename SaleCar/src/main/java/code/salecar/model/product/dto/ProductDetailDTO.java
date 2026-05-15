package code.salecar.model.product.dto;

import code.salecar.model.brand.BrandInfo;
import code.salecar.model.category.CategoryInfo;
import code.salecar.model.product.entity.*;

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

    private ProductDetailDTO(Builder builder) {
        this.product = builder.product;
        this.brand = builder.brand;
        this.category = builder.category;
        this.images = builder.images;
        this.salesInfo = builder.salesInfo;
        this.activeDiscount = builder.activeDiscount;
        this.reviews = builder.reviews;
        this.ratingDist = builder.ratingDist;
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

        public Builder product(Product product) { this.product = product; return this; }
        public Builder brand(BrandInfo brand) { this.brand = brand; return this; }
        public Builder category(CategoryInfo category) { this.category = category; return this; }
        public Builder images(List<String> images) { this.images = images; return this; }
        public Builder salesInfo(ProductSalesInfo salesInfo) { this.salesInfo = salesInfo; return this; }
        public Builder activeDiscount(DiscountInfo activeDiscount) { this.activeDiscount = activeDiscount; return this; }
        public Builder reviews(List<ReviewSummary> reviews) { this.reviews = reviews; return this; }
        public Builder ratingDist(ProductRatingDistribution ratingDist) { this.ratingDist = ratingDist; return this; }

        public ProductDetailDTO build() {
            return new ProductDetailDTO(this);
        }
    }
}