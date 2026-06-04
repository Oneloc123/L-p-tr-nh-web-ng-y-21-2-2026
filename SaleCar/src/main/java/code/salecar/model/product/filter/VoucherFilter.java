package code.salecar.model.product.filter;

/**
 * Filter model cho trang quản lý Voucher (Admin).
 * Hỗ trợ lọc theo trạng thái, thời gian, sắp xếp, phân trang.
 */
public class VoucherFilter {
    private String status;          // active / inactive
    private String timeStatus;      // active / upcoming / expired / all
    private String search;          // tìm theo code
    private String sort;            // code, value, max_discount, min_order_value, remaining, status, created_at
    private String order;           // asc / desc
    private int page;
    private int limit;

    public VoucherFilter() {
        this.status = "";
        this.timeStatus = "all";
        this.search = "";
        this.sort = "created_at";
        this.order = "desc";
        this.page = 1;
        this.limit = 20;
    }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = (status != null) ? status : ""; }

    public String getTimeStatus() { return timeStatus; }
    public void setTimeStatus(String timeStatus) { this.timeStatus = (timeStatus != null && !timeStatus.isEmpty()) ? timeStatus : "all"; }

    public String getSearch() { return search; }
    public void setSearch(String search) { this.search = (search != null) ? search.trim() : ""; }

    public String getSort() { return sort; }
    public void setSort(String sort) {
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                case "code": case "value": case "max_discount":
                case "min_order_value": case "remaining": case "status":
                case "created_at": case "value_type": case "usage_limit":
                    this.sort = sort;
                    break;
                default: this.sort = "created_at";
            }
        } else {
            this.sort = "created_at";
        }
    }

    public String getOrder() { return order; }
    public void setOrder(String order) {
        if (order != null && (order.equalsIgnoreCase("asc") || order.equalsIgnoreCase("desc"))) {
            this.order = order.toLowerCase();
        } else {
            this.order = "desc";
        }
    }

    public int getPage() { return page; }
    public void setPage(int page) { this.page = page > 0 ? page : 1; }
    public void setPage(String page) {
        if (page != null && !page.isEmpty()) {
            try {
                this.page = Integer.parseInt(page);
                if (this.page < 1) this.page = 1;
            } catch (NumberFormatException e) { this.page = 1; }
        }
    }

    public int getLimit() { return limit; }
    public void setLimit(int limit) { this.limit = limit > 0 ? limit : 20; }
    public void setLimit(String limit) {
        if (limit != null && !limit.isEmpty()) {
            try {
                this.limit = Integer.parseInt(limit);
                if (this.limit < 1) this.limit = 20;
            } catch (NumberFormatException e) { this.limit = 20; }
        }
    }

    public int getOffset() { return (page - 1) * limit; }
}
