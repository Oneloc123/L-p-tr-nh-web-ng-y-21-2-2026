package code.salecar.model.category;

import code.salecar.model.brand.BrandFilter;

public class CategoryFilter {
    private int id;
    private String name;
    private int status;
    private String sort;
    private orderEN order;

    private int limit;
    private  int page;



    public CategoryFilter() {
    }

    public enum orderEN{
        asc, desc;
    }

    public void setStatus(int status) {
        this.status = status;
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
            this.order = CategoryFilter.orderEN.asc;
            return;
        }

        try {
            this.order = CategoryFilter.orderEN.valueOf(order.toLowerCase());
        } catch (Exception e) {
            this.order = CategoryFilter.orderEN.asc;
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
        if (status != null &&  !status.isEmpty()) {
            if(status.equals("active")){
                this.status = 1;
            }
            else if(status.equals("inactive")){
                this.status = 0;
            }
        }else {
            this.status = -1;
        }
    }


}
