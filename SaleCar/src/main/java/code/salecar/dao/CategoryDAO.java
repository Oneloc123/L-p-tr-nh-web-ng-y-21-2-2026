package code.salecar.dao;

import code.salecar.model.category.Category;
import code.salecar.model.category.CategoryFilter;
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

    public List<Category> getCategories(CategoryFilter categoryFilter) {
        List<Category> categories = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        String sql = "SELECT ct.id, ct.name, ct.icon, ct.description, ct.status, ct.created_at, ct.updated_at, " +
                "COUNT(pr.id) AS product_count " +
                "FROM category ct " +
                "LEFT JOIN product pr ON ct.id = pr.category_id " +
                "WHERE 1=1 ";

        StringBuilder query = new StringBuilder(sql);

        // filter name
        if (categoryFilter.getName() != null && !categoryFilter.getName().isEmpty()) {
            query.append(" AND ct.name LIKE ? ");
            params.add("%" + categoryFilter.getName() + "%");
        }

        // filter status
        if (categoryFilter.getStatus() != -1) {
            query.append(" AND ct.status = ? ");
            params.add(categoryFilter.getStatus());
        }else {

        }

        // GROUP BY
        query.append(" GROUP BY ct.id, ct.name, ct.icon, ct.description, ct.status, ct.created_at, ct.updated_at ");

        // sort (giữ kiểu đơn giản)
        if (categoryFilter.getSort() != null && !categoryFilter.getSort().isEmpty()) {

            String sortField = "ct.id";
            if (categoryFilter.getSort().equals("name")) {
                sortField = "ct.name";
            } else if (categoryFilter.getSort().equals("created_at")) {
                sortField = "ct.created_at";
            } else if (categoryFilter.getSort().equals("product_count")) {
                sortField = "product_count";
            }else  if (categoryFilter.getSort().equals("status")) {
                sortField = "ct.status";
            }

            String sortOrder = (categoryFilter.getOrder() != null)
                    ? categoryFilter.getOrder().name()
                    : "asc";

            query.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        }

        // pagination
        int offset = (categoryFilter.getPage() - 1) * categoryFilter.getLimit();
        query.append(" LIMIT ? OFFSET ? ");
        params.add(categoryFilter.getLimit());
        params.add(offset);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

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
            System.out.println("SQL: " + query.toString());

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return categories;
    }


    public boolean updateCategory(Category category) {
        String sql = "update category set name = ?,description = ?,icon = ?, status = ?, updated_at = ? where id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getIcon());
            ps.setInt(4, category.getIntStatus());
            ps.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
            ps.setInt(6, category.getId());
            System.out.println("SQL: " + sql);
            System.out.println(category.getId());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
