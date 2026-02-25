package code.salecar.dao;

import code.salecar.model.Product;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
}
