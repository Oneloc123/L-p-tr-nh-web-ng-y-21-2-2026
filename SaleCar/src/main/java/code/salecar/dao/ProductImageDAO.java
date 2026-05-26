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
        String query = "select image_url from image where entity_type = ? and entity_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, type.toString());
            ps.setLong(2, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("image_url");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;

    }

    /**
     * Lấy danh sách ảnh của sản phẩm, sắp xếp ảnh chính (is_main=1) lên đầu
     */
    public List<String> getImageProduct(long id) {
        List<String> list = new ArrayList<>();
        String query = "select image_url from image where entity_type = ? and entity_id=? order by is_main desc, created_at asc";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, Image.entityType.product.toString());
            ps.setLong(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("image_url"));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    /**
     * Lấy URL ảnh chính của sản phẩm
     */
    public String getMainImage(long productId) {
        String query = "select image_url from image where entity_type = ? and entity_id = ? and is_main = 1 limit 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, Image.entityType.product.toString());
            ps.setLong(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("image_url");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    /**
     * Kiểm tra xem ảnh có phải là ảnh chính không
     */
    public boolean isMainImage(long productId, String imageUrl) {
        String query = "select is_main from image where entity_type = ? and entity_id = ? and image_url = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, Image.entityType.product.toString());
            ps.setLong(2, productId);
            ps.setString(3, imageUrl);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("is_main") == 1;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    //Tạo ảnh cho sản phẩm
    public void insertImage(ProductImage productImage) {
        String query = "INSERT INTO image (entity_type, entity_id, is_main, image_url, created_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
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

    /**
     * Xóa ảnh theo productId và imageUrl
     */
    public void deleteImage(long productId, String imageUrl) {
        String query = "delete from image where entity_type = ? and entity_id = ? and image_url = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, Image.entityType.product.toString());
            ps.setLong(2, productId);
            ps.setString(3, imageUrl);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Đặt ảnh làm ảnh chính (is_main=1), các ảnh khác của sản phẩm set is_main=0
     */
    public void setMainImage(long productId, String imageUrl) {
        String sqlUpdateOthers = "update image set is_main = 0 where entity_type = ? and entity_id = ?";
        String sqlSetMain = "update image set is_main = 1 where entity_type = ? and entity_id = ? and image_url = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps1 = con.prepareStatement(sqlUpdateOthers);
             PreparedStatement ps2 = con.prepareStatement(sqlSetMain)) {

            // Reset tất cả về 0
            ps1.setString(1, Image.entityType.product.toString());
            ps1.setLong(2, productId);
            ps1.executeUpdate();

            // Set ảnh được chọn làm main
            ps2.setString(1, Image.entityType.product.toString());
            ps2.setLong(2, productId);
            ps2.setString(3, imageUrl);
            ps2.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
