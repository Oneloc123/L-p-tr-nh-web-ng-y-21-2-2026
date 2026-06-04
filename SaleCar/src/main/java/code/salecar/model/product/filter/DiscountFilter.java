package code.salecar.model.product.filter;

/**
 * Filter model cho trang quản lý Discount (Admin).
 * Hỗ trợ lọc theo thời gian hoạt động, brand, category, product.
 */
public class DiscountFilter {
    /** Thời gian hoạt động: active / upcoming / expired / all */
    private String timeStatus;
    private long brandId;
    private long categoryId;
    private long productId;
    private int page;
    private int limit;

    public DiscountFilter() {
        this.timeStatus = "all";
        this.brandId = -1;
        this.categoryId = -1;
        this.productId = -1;
        this.page = 1;
        this.limit = 20;
    }

    public String getTimeStatus() {
        return timeStatus;
    }

    public void setTimeStatus(String timeStatus) {
        this.timeStatus = (timeStatus != null && !timeStatus.isEmpty()) ? timeStatus : "all";
    }

    public long getBrandId() {
        return brandId;
    }

    public void setBrandId(String brandId) {
        if (brandId != null && !brandId.isEmpty()) {
            try {
                this.brandId = Long.parseLong(brandId);
            } catch (NumberFormatException e) {
                this.brandId = -1;
            }
        } else {
            this.brandId = -1;
        }
    }

    public long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        if (categoryId != null && !categoryId.isEmpty()) {
            try {
                this.categoryId = Long.parseLong(categoryId);
            } catch (NumberFormatException e) {
                this.categoryId = -1;
            }
        } else {
            this.categoryId = -1;
        }
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        if (productId != null && !productId.isEmpty()) {
            try {
                this.productId = Long.parseLong(productId);
            } catch (NumberFormatException e) {
                this.productId = -1;
            }
        } else {
            this.productId = -1;
        }
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page > 0 ? page : 1;
    }

    public void setPage(String page) {
        if (page != null && !page.isEmpty()) {
            try {
                this.page = Integer.parseInt(page);
                if (this.page < 1) this.page = 1;
            } catch (NumberFormatException e) {
                this.page = 1;
            }
        }
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit > 0 ? limit : 20;
    }

    public void setLimit(String limit) {
        if (limit != null && !limit.isEmpty()) {
            try {
                this.limit = Integer.parseInt(limit);
                if (this.limit < 1) this.limit = 20;
            } catch (NumberFormatException e) {
                this.limit = 20;
            }
        }
    }

    public int getOffset() {
        return (page - 1) * limit;
    }
}
