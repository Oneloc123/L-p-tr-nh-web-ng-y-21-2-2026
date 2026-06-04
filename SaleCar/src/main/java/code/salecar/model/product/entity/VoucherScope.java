package code.salecar.model.product.entity;

/**
 * Entity cho bảng voucher_scope.
 * Xác định phạm vi áp dụng của voucher (product/brand/category/order).
 */
public class VoucherScope {
    private long id;
    private long voucherId;
    private String entityType;  // product / brand / category / order
    private long entityId;

    // Các trường hiển thị (được tải qua JOIN hoặc service)
    private String entityName;  // Tên của entity (tên sản phẩm, brand, category...)

    public VoucherScope() {}

    public VoucherScope(long id, long voucherId, String entityType, long entityId) {
        this.id = id;
        this.voucherId = voucherId;
        this.entityType = entityType;
        this.entityId = entityId;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public long getVoucherId() { return voucherId; }
    public void setVoucherId(long voucherId) { this.voucherId = voucherId; }

    public String getEntityType() { return entityType; }
    public void setEntityType(String entityType) { this.entityType = entityType; }

    public long getEntityId() { return entityId; }
    public void setEntityId(long entityId) { this.entityId = entityId; }

    public String getEntityName() { return entityName; }
    public void setEntityName(String entityName) { this.entityName = entityName; }

    public String getEntityTypeDisplay() {
        if (entityType == null) return "";
        switch (entityType) {
            case "product":  return "Sản phẩm";
            case "brand":    return "Thương hiệu";
            case "category": return "Danh mục";
            case "order":    return "Đơn hàng";
            default:         return entityType;
        }
    }

    public String getScopeDisplay() {
        if ("order".equals(entityType)) return "Toàn bộ đơn hàng";
        if (entityName != null && !entityName.isEmpty()) {
            return getEntityTypeDisplay() + ": " + entityName;
        }
        return getEntityTypeDisplay();
    }
}
