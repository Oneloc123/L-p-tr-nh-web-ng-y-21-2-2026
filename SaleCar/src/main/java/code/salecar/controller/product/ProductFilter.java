package code.salecar.controller.product;

import java.util.ArrayList;
import java.util.List;

public class ProductFilter {
    private String keyword;
    private List<String> categories;
    private List<String> brands;
    private double maxPrice;

    private boolean sortByHighest;
    private boolean sortByNewest;



    public ProductFilter() {
        this.keyword = "";
        this.categories = new ArrayList<String>();
        this.brands = new ArrayList<String>();
        this.maxPrice = -1;
        this.sortByHighest = false;
        this.sortByNewest = false;
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

    public boolean isSortByHighest() {
        return sortByHighest;
    }

    public void setSortByHighest(boolean sortByHighest) {
        this.sortByHighest = sortByHighest;
    }

    public boolean isSortByNewest() {
        return sortByNewest;
    }

    public void setSortByNewest(boolean sortByNewest) {
        this.sortByNewest = sortByNewest;
    }

    public double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(double maxPrice) {
        this.maxPrice = maxPrice;
    }
}
