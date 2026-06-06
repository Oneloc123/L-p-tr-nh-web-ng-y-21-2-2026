package code.salecar.dao;

import code.salecar.config.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FavoriesDAO {

    public boolean addProduct(int productId, int userId) {
        String sql = "INSERT INTO wishlist_item (user_id, product_id) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Duplicate key (UNIQUE constraint) or other SQL error
            if (e.getErrorCode() == 1062) return false; // MySQL duplicate entry
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Integer> getFavorites(int userId) {
        List<Integer> favoritesList = new ArrayList<>();
        String sql = "SELECT product_id FROM wishlist_item WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                favoritesList.add(rs.getInt("product_id"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return favoritesList;
    }

    public boolean removeFavoritesProduct(int productId, int userId) {
        String sql = "DELETE FROM wishlist_item WHERE product_id = ? AND user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean isInWishlist(int productId, int userId) {
        String sql = "SELECT COUNT(*) FROM wishlist_item WHERE product_id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean hasDuplicate(int productId, int userId) {
        return isInWishlist(productId, userId);
    }
}