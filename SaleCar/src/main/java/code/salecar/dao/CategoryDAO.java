package code.salecar.dao;

import code.salecar.model.Category;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public int getTotalCategory() {
        String sql = "SELECT COUNT(*) FROM category";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<String> getCategoryName() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT name from category";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                list.add(rs.getString("name"));
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public String getCategoryName(int id) {

        String sql = "SELECT name from category where id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                return rs.getString("name");
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "";
    }
    public Category getCategoryById(int id) {
        String sql = "SELECT * from category where id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setIcon(rs.getString("icon"));
                category.setStatus(rs.getInt("status"));
                category.setCreatedAt(rs.getTimestamp("created_at"));
                category.setUpdatedAt(rs.getTimestamp("updated_at"));
                return category;            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }


    public List<Category> getCategory() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * from category ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("icon")));
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return categories;
    }

    public List<Category> getCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT ct.id, ct.name, ct.description, ct.icon, ct.status, ct.created_at, ct.updated_at,COUNT(pr.id) AS product_count " +
                " from category ct  " +
                "LEFT JOIN product pr ON ct.id = pr.category_id " +
                "WHERE 1=1 " +
                " GROUP BY ct.id, ct.name, ct.description, ct.icon, ct.status, ct.created_at, ct.updated_at ";
        ;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setIcon(rs.getString("icon"));
                category.setStatus(rs.getInt("status"));
                category.setCreatedAt(rs.getTimestamp("created_at"));
                category.setUpdatedAt(rs.getTimestamp("updated_at"));
                category.setProductCount(rs.getInt("product_count"));
                categories.add(category);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return categories;
    }
}
