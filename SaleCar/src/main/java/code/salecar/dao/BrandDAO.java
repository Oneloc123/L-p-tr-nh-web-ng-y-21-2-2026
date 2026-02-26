package code.salecar.dao;

import code.salecar.model.Brand;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {

    public List<Brand> getBrands() throws Exception {
        List<Brand> brands = new ArrayList<>();
        String sql = "select * from brand";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("link_brand"),
                        rs.getString("description"),
                        rs.getString("address"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
            }
        }

        return brands;

    }

    public Brand getBrandByID(int brandid) {
        Brand brand = null;
        String sql = "select * from brand where id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, brandid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                brand = new Brand(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("link_brand"),
                        rs.getString("description"),
                        rs.getString("address"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return brand;
    }
}
