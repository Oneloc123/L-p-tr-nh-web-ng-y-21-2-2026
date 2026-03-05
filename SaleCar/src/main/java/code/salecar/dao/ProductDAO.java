package code.salecar.dao;

import code.salecar.model.Product;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ProductDAO {


    // Lấy danh sách sản phẩm. Chưa có kết nối ảnh
    public List<Product> getproducts() {
        List<Product> products = new ArrayList<>();
        String query = "select * from product";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
                        rs.getBoolean("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }


    public List<Product> getProductNew() {
        List<Product> products = new ArrayList<>();
        String query = "select * from product where status = 1 order by created_at desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;

    }

    public Product getProductByID(int id) {
        Product p = null;
        String query = "select * from product where id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return p;
    }

    public List<Product> getProductHot() {
        List<Product> products = new ArrayList<>();
        String query = "select * from product where status = 1 order by price desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public List<Product> getProductsByPage(int page, int limit) {
        List<Product> products = new ArrayList<>();
        String query = "select * from product order by id desc limit ? offset ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            int offset = (page - 1) * limit;

            ps.setInt(1, limit);
            ps.setInt(2, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
                        rs.getBoolean("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public int getTotalProduct() {
        String sql = "SELECT COUNT(*) FROM product";
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

    public int getTotalProduct(String find,String[] categories, String[] brands) {
        String query = "select count(*) from product pr join brand br on pr.brand_id = br.id " +
                "join category ct on pr.category_id = ct.id where 1=1 ";

        if (find != null && !find.isEmpty()) {
            query += " and pr.name like ?" ;
        }

        if (categories != null) {
            query += " and ct.name in (" + String.join(",", Collections.nCopies(categories.length, "?")) + ")";
        }

        if (brands != null) {
            query += "and br.name in (" + String.join(",", Collections.nCopies(brands.length, "?")) + ")";
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            int index = 1;

            if (find != null && !find.isEmpty()) {
                ps.setString(index++, "%"+find+"%");
            }

            if (categories != null) {
                for (String c : categories) {
                    ps.setString(index++, c);
                }
            }
            if (brands != null) {
                for (String b : brands) {
                    ps.setString(index++, b);
                }
            }


            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> getProductFilter(String find, String[] categories, String[] brands, int page, int limit) {
        List<Product> products = new ArrayList<>();

        String query = "select * from product pr join brand br on pr.brand_id = br.id " +
                "join category ct on pr.category_id = ct.id where 1=1 ";

        if (find != null && !find.isEmpty()) {
            query += " and pr.name like ? ";
        }

        if (categories != null && categories.length > 0) {
            query += " and ct.name in (" + String.join(",", Collections.nCopies(categories.length, "?")) + ")";
        }

        if (brands != null && brands.length > 0) {
            query += " and br.name in (" + String.join(",", Collections.nCopies(brands.length, "?")) + ")";
        }

        query += " order by price desc limit ? offset ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            int index = 1;

            if (find != null && !find.isEmpty()) {
                ps.setString(index++, "%" + find + "%");
            }
            if (categories != null && categories.length > 0) {
                for (String c : categories) {
                    ps.setString(index++, c);
                }
            }
            if (brands != null && brands.length > 0) {
                for (String b : brands) {
                    ps.setString(index++, b);
                }
            }


            int offset = (page - 1) * limit;

            ps.setInt(index++, limit);
            ps.setInt(index, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
                        rs.getBoolean("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return products;
    }
}
