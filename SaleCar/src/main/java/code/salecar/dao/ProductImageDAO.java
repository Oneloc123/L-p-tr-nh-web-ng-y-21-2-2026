package code.salecar.dao;

import code.salecar.model.Image;
import code.salecar.config.DBConnection;
import code.salecar.model.product.entity.ProductImage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductImageDAO {

    public String getImage(Image.entityType type, long id) {
        String query = "select image_url1 from image where entity_type = ? and entity_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setString(1, type.toString());
            ps.setLong(2, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("image_url1");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;

    }

    public List<String> getImageProduct(long id) {
        List<String> list = new ArrayList<>();
        String query = "select image_url1 from image where entity_type = ? and entity_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setString(1, Image.entityType.product.toString());
            ps.setLong(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("image_url1"));
                list.add(rs.getString("image_url2"));
                list.add(rs.getString("image_url3"));
                list.add(rs.getString("image_url4"));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    //Tạo ảnh cho sản phẩm
    public void insertImage(ProductImage productImage) {
        String query = "INSERT INTO image (entity_type, entity_id,is_main , image_url,created_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setString(1, Image.entityType.product.toString());
            ps.setLong(2, productImage.getProductId());
            ps.setInt(3, productImage.isPrimary() ? 1 : 0);
            ps.setString(4, productImage.getImageUrl());
            ps.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
