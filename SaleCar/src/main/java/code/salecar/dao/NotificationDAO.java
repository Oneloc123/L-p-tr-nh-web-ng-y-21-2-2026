package code.salecar.dao;

import code.salecar.config.DBConnection;
import code.salecar.model.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    public void insertNotification(int userId, String message) {
        insertNotification(userId, message, 0);
    }

    public void insertNotification(int userId, String message, int orderId) {
        String sql = "INSERT INTO notification (user_id, message, order_id) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, message);
            if (orderId > 0) {
                ps.setInt(3, orderId);
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) FROM notification WHERE user_id = ? AND is_read = false";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Notification> getTop5Notifications(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notification WHERE user_id = ? ORDER BY created_at DESC LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapNotification(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Notification> getAllNotifications(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT id, user_id, message, is_read, created_at, COALESCE(order_id, 0) AS order_id FROM notification WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapNotification(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void markAllAsRead(int userId) {
        String sql = "UPDATE notification SET is_read = true WHERE user_id = ? AND is_read = false";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Notification mapNotification(ResultSet rs) throws SQLException {
        Notification n = new Notification();
        n.setId(rs.getInt("id"));
        n.setUserId(rs.getInt("user_id"));
        n.setMessage(rs.getString("message"));
        n.setIsRead(rs.getBoolean("is_read"));
        n.setCreatedAt(rs.getTimestamp("created_at"));
        n.setOrderId(rs.getInt("order_id")); // 0 nếu NULL
        return n;
    }
}
