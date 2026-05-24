package code.salecar.service.file;

import code.salecar.model.product.entity.ActivityLog;

import java.util.Date;

/**
 * Reusable helper for logging product activity (audit log).
 * Wraps ActivityLogFileService with a clean action-based API.
 * Call from any servlet/service that modifies product data.
 */
public class ActivityLogger {

    private final ActivityLogFileService logService = new ActivityLogFileService();

    /**
     * Log a product action with optional before/after details.
     *
     * @param productId ID của sản phẩm
     * @param action    Tên hành động (VD: "Tạo sản phẩm", "Cập nhật sản phẩm", "Xoá sản phẩm")
     * @param user      Tên người thực hiện
     * @param details   Nội dung chi tiết thay đổi
     */
    public void log(long productId, String action, String user, String details) {
        ActivityLog log = ActivityLog.builder()
                .action(action)
                .timestamp(new Date())
                .user(user != null ? user : "Hệ thống")
                .details(details != null ? details : "")
                .build();
        logService.writeLog(productId, log);
    }

    /**
     * Log product update with structured old → new details.
     */
    public void logProductUpdate(long productId, String user, String changedFields) {
        log(productId, "Cập nhật sản phẩm", user, changedFields);
    }

    /**
     * Log variant change (add/edit/delete).
     */
    public void logVariantChange(long productId, String user, String variantName, String action, String details) {
        log(productId, action + " biến thể", user, variantName + ": " + details);
    }

    /**
     * Log image action (upload/set-main/delete).
     */
    public void logImageAction(long productId, String user, String action, String imageName) {
        log(productId, action + " ảnh", user, imageName);
    }

    /**
     * Log inventory change.
     */
    public void logInventoryChange(long productId, String user, String variantName, String type, int quantity) {
        String prefix = "add".equals(type) ? "+" : "-";
        log(productId, type.equals("add") ? "Nhập kho" : "Xuất kho", user,
                variantName + ": " + prefix + quantity);
    }

    /**
     * Log product deletion.
     */
    public void logProductDeleted(long productId, String productName, String user) {
        log(productId, "Xoá sản phẩm", user, "Đã xoá sản phẩm: " + productName);
    }

    /**
     * Log product creation.
     */
    public void logProductCreated(long productId, String productName, String user) {
        log(productId, "Tạo sản phẩm", user, "Đã tạo sản phẩm: " + productName);
    }
}
