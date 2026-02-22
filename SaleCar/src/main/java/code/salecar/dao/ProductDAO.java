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
             PreparedStatement ps = conn.prepareStatement(query))
        {
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
                        rs.getDate("create_at"),
                        rs.getDate("update_at")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }


}
