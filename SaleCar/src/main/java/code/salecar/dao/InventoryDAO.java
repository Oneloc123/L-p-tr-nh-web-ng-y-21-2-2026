package code.salecar.dao;

import code.salecar.config.DBConnection;
import code.salecar.model.product.entity.ProductVariants;

import java.sql.*;

public class InventoryDAO {
    public void update(ProductVariants variant) {
        // Sử dụng INSERT ... ON DUPLICATE KEY UPDATE để cập nhật số lượng tồn kho
        // Dựa trên schema trong Motabang.txt: UNIQUE(product_id, variant_id)
        String sql = "INSERT INTO inventory (product_id, variant_id, quantity, last_updated) " +
                "VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE quantity =  VALUES(quantity), last_updated = VALUES(last_updated)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, variant.getProductId());
            ps.setLong(2, variant.getId());
            ps.setInt(3, variant.getQuantity()); // Số lượng mới nhập vào
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi cập nhật kho: " + e.getMessage());
        }
    }

    public int getQuantity(long variantId) {
        String sql = "select quantity from inventory where variant_id = ? ";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setLong(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }
}
