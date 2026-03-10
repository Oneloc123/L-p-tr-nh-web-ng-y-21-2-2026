package code.salecar.dao;

import code.salecar.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class FavoriesDAO {
    public boolean addProduct(int productId, int userId) {
        String sql = "insert into wishlist_item" +
                "(user_id,product_id) " +
                "values " +
                "(?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Integer> getFavorites(int userId) {
        List<Integer> favoritesList = new ArrayList<>();
        String sql = "select product_id from wishlist_item where user_id = ? ";
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

    public boolean removeFavoritesProduct(int prid) {
        String sql = "delete from wishlist_item" +
                " where  product_id = ? " ;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1, prid);

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}