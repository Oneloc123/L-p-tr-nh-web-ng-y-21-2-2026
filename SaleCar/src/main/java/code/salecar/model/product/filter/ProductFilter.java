package code.salecar.model.product.filter;

import java.util.ArrayList;
import java.util.List;

public class ProductFilter {
    private String keyword;
    private List<String> categories;
    private List<String> brands;
    private List<String> modelScale;
    private double maxPrice;
    private double minPrice;


    private boolean sortByPriceAsc;
    private boolean sortByPriceDesc;

    private boolean sortByHighestDiscount;
    private boolean sortByNewestDiscount;


    public ProductFilter() {
        this.keyword = "";
        this.categories = new ArrayList<String>();
        this.brands = new ArrayList<String>();
        this.modelScale = new ArrayList<String>();
        this.maxPrice = 0;
        this.minPrice = 0;
        this.sortByPriceAsc = false;
        this.sortByPriceDesc = false;
        this.sortByHighestDiscount = false;
        this.sortByNewestDiscount = false;
    }



    public List<String> getModelScale() {
        return modelScale;
    }

    public void setModelScale(List<String> modelScale) {
        this.modelScale = modelScale;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public boolean isSortByPriceAsc() {
        return sortByPriceAsc;
    }

    public void setSortByPriceAsc(boolean sortByPriceAsc) {
        this.sortByPriceAsc = sortByPriceAsc;
    }

    public boolean isSortByPriceDesc() {
        return sortByPriceDesc;
    }

    public void setSortByPriceDesc(boolean sortByPriceDesc) {
        this.sortByPriceDesc = sortByPriceDesc;
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

    public double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(double maxPrice) {
        this.maxPrice = maxPrice;
    }
}
