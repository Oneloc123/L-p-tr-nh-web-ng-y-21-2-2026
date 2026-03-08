package code.salecar.dao;

import code.salecar.model.Product;
import code.salecar.model.Reviews;
import code.salecar.utils.DBConnection;

import java.sql.Date;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewsDAO {

    public List<Reviews> getReviewsByID(int id) {
        List<Reviews> list = new ArrayList<>();
        String query = "select * from reviews r join product p on r.product_id = p.id where p.id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reviews r = new Reviews(
                        rs.getInt("user_id"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getDate("CreateAt")
                );
                list.add(r);

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;

    }

    public boolean addReviews(Reviews r) {
        String sql = "insert into reviews" +
                "(user_id,product_id, rating, comment, CreateAt, UpdateAt) " +
                "values " +
                "(?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1, r.getUserId());
            ps.setInt(2, r.getProductId());
            ps.setInt(3, r.getRating());
            ps.setString(4, r.getComment());
            ps.setDate(5, new Date(System.currentTimeMillis()));
            ps.setDate(6, new Date(System.currentTimeMillis()));

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Integer> getRates(int id) {
        List<Integer> list = new ArrayList<>();
        String query = "select r.rating from reviews r join product p on r.product_id = p.id where p.id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int r = rs.getInt("rating");
                        list.add(r);

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<String> getComments(int id) {
        List<String> list = new ArrayList<>();
        String query = "select r.comment from reviews r join product p on r.product_id = p.id where p.id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String r = rs.getString("comment");
                list.add(r);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}
