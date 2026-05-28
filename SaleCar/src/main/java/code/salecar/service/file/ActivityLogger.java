package code.salecar.service.file;

import code.salecar.model.product.entity.ActivityLog;

import java.util.Date;

/** Helper tái sử dụng để ghi log hoạt động sản phẩm (audit log).
 * Bao bọc ActivityLogFileService với API clean dựa trên hành động.
 * Gọi từ bất kỳ servlet/service nào thay đổi dữ liệu sản phẩm.
 */
public class ActivityLogger {

    private final ActivityLogFileService logService = new ActivityLogFileService();

    /** Ghi log hành động sản phẩm với chi tiết trước/sau
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

    /** Ghi log cập nhật sản phẩm với chi tiết cũ → mới */
    public void logProductUpdate(long productId, String user, String changedFields) {
        log(productId, "Cập nhật sản phẩm", user, changedFields);
    }

    /** Ghi log thay đổi biến thể (thêm/sửa/xoá) */
    public void logVariantChange(long productId, String user, String variantName, String action, String details) {
        log(productId, action + " biến thể", user, variantName + ": " + details);
    }

    /** Ghi log hành động ảnh (tải lên/đặt chính/xoá) */
    public void logImageAction(long productId, String user, String action, String imageName) {
        log(productId, action + " ảnh", user, imageName);
    }

    /** Ghi log thay đổi tồn kho */
    public void logInventoryChange(long productId, String user, String variantName, String type, int quantity) {
        String prefix = "add".equals(type) ? "+" : "-";
        log(productId, type.equals("add") ? "Nhập kho" : "Xuất kho", user,
                variantName + ": " + prefix + quantity);
    }

    /** Ghi log xoá sản phẩm */
    public void logProductDeleted(long productId, String productName, String user) {
        log(productId, "Xoá sản phẩm", user, "Đã xoá sản phẩm: " + productName);
    }

    /** Ghi log tạo sản phẩm */
    public void logProductCreated(long productId, String productName, String user) {
        log(productId, "Tạo sản phẩm", user, "Đã tạo sản phẩm: " + productName);
    }
}
