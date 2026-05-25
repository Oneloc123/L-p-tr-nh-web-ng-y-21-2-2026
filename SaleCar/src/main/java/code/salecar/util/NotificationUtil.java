package code.salecar.util;

import jakarta.servlet.http.HttpSession;

/**
 * Utility for setting and getting flash notification messages.
 * Notifications are stored in the session and cleared after being read (flash pattern).
 * Works with SweetAlert2 on the frontend.
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

    /**
     * Inner class representing a notification.
     */
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

    // ========== SETTER METHODS ==========

    /**
     * Store a success notification in the session.
     */
    public static void setSuccess(HttpSession session, String message) {
        session.setAttribute(SESSION_KEY, new Notification(Type.SUCCESS.getValue(), message));
    }

    /**
     * Store an error notification in the session.
     */
    public static void setError(HttpSession session, String message) {
        session.setAttribute(SESSION_KEY, new Notification(Type.ERROR.getValue(), message));
    }

    /**
     * Store a warning notification in the session.
     */
    public static void setWarning(HttpSession session, String message) {
        session.setAttribute(SESSION_KEY, new Notification(Type.WARNING.getValue(), message));
    }

    // ========== GETTER / CLEAR METHODS ==========

    /**
     * Get the current notification from the session (if any) and remove it immediately.
     * This implements the flash message pattern: notification is read once then cleared.
     *
     * @return Notification object, or null if no notification exists.
     */
    public static Notification getAndClear(HttpSession session) {
        if (session == null) return null;
        Notification notification = (Notification) session.getAttribute(SESSION_KEY);
        if (notification != null) {
            session.removeAttribute(SESSION_KEY);
        }
        return notification;
    }

    /**
     * Check if a notification exists in the session without consuming it.
     */
    public static boolean hasNotification(HttpSession session) {
        return session != null && session.getAttribute(SESSION_KEY) != null;
    }
}
