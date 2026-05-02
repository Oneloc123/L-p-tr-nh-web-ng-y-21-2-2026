package code.salecar.model.brand;

import java.util.Date;

public class BrandFilter {
    private int id;
    private String name;
    private int status;
    private Date createdAt;

    private int productCount;
    private String sort;
    private orderEN order;
    private int limit;
    private int page;

    public BrandFilter() {
    }

    public enum orderEN {
        asc, desc
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public orderEN getOrder() {
        return order;
    }

    public void setOrder(orderEN order) {
        this.order = order;
    }

    public void setOrder(String order) {
        if (order == null) {
            this.order = BrandFilter.orderEN.asc;
            return;
        }

        try {
            this.order = BrandFilter.orderEN.valueOf(order.toLowerCase());
        } catch (Exception e) {
            this.order = BrandFilter.orderEN.asc;
        }
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
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


    public int getStatus() {
        return status;
    }



    public void setStatus(String status) {
        if (status != null && !status.isEmpty()) {
            if (status.toLowerCase().equals("inactive")) {
                this.status = 0;
            } else if (status.toLowerCase().equals("active")) {
                this.status = 1;
            }
        }else {
            this.status = -1;
        }
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }


    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }
}
