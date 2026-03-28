package code.salecar.model.product.filter;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ProductFilter {
    private String keyword;
    private List<String> categories;
    private List<String> brands;
    private List<String> scale;
    private BigDecimal maxPrice;
    private BigDecimal minPrice;

    private List<Integer> category ;
    private List<Integer> brand;
    private int status;
    private String stock;
    private Date fromDate;
    private Date toDate;

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

    public ProductFilter(String keyword, List<Integer> category, List<Integer> brand, int status, String stock, BigDecimal maxPrice, BigDecimal minPrice, Date fromDate, Date toDate, sortBy sortBy) {
        this.keyword = keyword;
        this.category = category;
        this.brand = brand;
        this.status = status;
        this.stock = stock;
        this.maxPrice = maxPrice;
        this.minPrice = minPrice;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.sortBy = sortBy;
    }

    public enum sortBy {
        PRICE_ASC,
        PRICE_DESC,
        NEWEST,
        NAME_ASC,
        NAME_DESC,
        CREATED_ASC,
        CREATED_DESC
    }

    public List<Integer> getCategory() {
        return category;
    }

    public void setCategory(List<Integer> category) {
        this.category = category;
    }

    public List<Integer> getBrand() {
        return brand;
    }

    public void setBrand(List<Integer> brand) {
        this.brand = brand;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
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
