package code.salecar.util;

import jakarta.servlet.http.HttpSession;

/** Tiện ích để thiết lập và lấy thông báo flash.
 * Thông báo được lưu trong session và xoá sau khi đọc (flash pattern).
 * Hoạt động với SweetAlert2 ở frontend.
 */
public class NotificationUtil {

    public static final String SESSION_KEY = "notification";

    public enum Type {
        SUCCESS("success"),
        ERROR("error"),
        WARNING("warning");

        private final String value;

        Type(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }

    /** Lớp nội đại diện cho một thông báo */
    public static class Notification {
        private final String type;
        private final String message;

        public Notification(String type, String message) {
            this.type = type;
            this.message = message;
        }

        public String getType() {
            return type;
        }

        public String getMessage() {
            return message;
        }
    }

    /**
    * Lưu thông báo thành công vào session */
    public static void setSuccess(HttpSession session, String message) {
        session.setAttribute(SESSION_KEY, new Notification(Type.SUCCESS.getValue(), message));
    }

    /** Lưu thông báo lỗi vào session */
    public static void setError(HttpSession session, String message) {
        session.setAttribute(SESSION_KEY, new Notification(Type.ERROR.getValue(), message));
    }

    /** Lưu thông báo cảnh báo vào session */
    public static void setWarning(HttpSession session, String message) {
        session.setAttribute(SESSION_KEY, new Notification(Type.WARNING.getValue(), message));
    }


    /** Lấy thông báo hiện tại từ session (nếu có) và xoá ngay lập tức.
     * Triển khai flash message pattern: thông báo được đọc một lần rồi xoá.
     * @return Đối tượng Notification, hoặc null nếu không có thông báo.
     */
    public static Notification getAndClear(HttpSession session) {
        if (session == null) return null;
        Notification notification = (Notification) session.getAttribute(SESSION_KEY);
        if (notification != null) {
            session.removeAttribute(SESSION_KEY);
        }
        return notification;
    }

    /** Kiểm tra xem có thông báo trong session không mà không xoá nó */
    public static boolean hasNotification(HttpSession session) {
        return session != null && session.getAttribute(SESSION_KEY) != null;
    }
}
