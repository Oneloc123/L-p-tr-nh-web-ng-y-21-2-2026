package code.salecar.dao;

import code.salecar.config.DBConnection;
import code.salecar.model.User;
import code.salecar.model.product.entity.ProductVariants;

import java.sql.*;

public class ImportReceiptDAO {
    public int createImportReceipt(User user) {
        String sql = "INSERT INTO import_receipts (created_by, status, created_at) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, user.getId());
            ps.setString(2, "completed");
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void createImportReceiptItem(int receiptId, ProductVariants variant) {
        String sql = "INSERT INTO import_receipt_items (receipt_id, product_id, variant_id, quantity, import_price) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, receiptId);
            ps.setLong(2, variant.getProductId());
            ps.setLong(3, variant.getId());
            ps.setInt(4, variant.getQuantity());
            ps.setBigDecimal(5, variant.getPrice());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
