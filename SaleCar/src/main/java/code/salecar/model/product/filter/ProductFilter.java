package code.salecar.model.product.filter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ProductFilter {
    private String keyword;
    private List<String> categories;
    private List<String> brands;
    private List<String> scale;
    private BigDecimal maxPrice;
    private BigDecimal minPrice;


    private sortBy sortBy;

    private boolean sortByHighestDiscount;
    private boolean sortByNewestDiscount;


    public ProductFilter() {
        this.keyword = "";
        this.categories = new ArrayList<String>();
        this.brands = new ArrayList<String>();
        this.scale = new ArrayList<String>();
        this.sortByHighestDiscount = false;
        this.sortByNewestDiscount = false;
    }

    public enum sortBy {
        PRICE_ASC,
        PRICE_DESC,
        NEWEST
    }

    public sortBy getSortBy() {
        return sortBy;
    }

    public void setSortBy(sortBy sortBy) {
        this.sortBy = sortBy;
    }

    public List<String> getScale() {
        return scale;
    }

    public void setScale(List<String> scale) {
        this.scale = scale;
    }

    public BigDecimal getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(BigDecimal minPrice) {
        this.minPrice = minPrice;
    }


    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public List<String> getCategories() {
        return categories;
    }

    public void setCategories(List<String> categories) {
        this.categories = categories;
    }

    public List<String> getBrands() {
        return brands;
    }

    public void setBrands(List<String> brands) {
        this.brands = brands;
    }

    public boolean isSortByHighestDiscount() {
        return sortByHighestDiscount;
    }

    public void setSortByHighestDiscount(boolean sortByHighestDiscount) {
        this.sortByHighestDiscount = sortByHighestDiscount;
    }

    public boolean isSortByNewestDiscount() {
        return sortByNewestDiscount;
    }

    public void setSortByNewestDiscount(boolean sortByNewestDiscount) {
        this.sortByNewestDiscount = sortByNewestDiscount;
    }

    public BigDecimal getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(BigDecimal maxPrice) {
        this.maxPrice = maxPrice;
    }
}
