package code.salecar.dao;

import code.salecar.config.DBConnection;
import code.salecar.model.Image;
import code.salecar.model.product.entity.ProductVariants;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantsDAO {

    public List<ProductVariants> getVariantById(long productId) {
        List<ProductVariants> list = new ArrayList<>();
        String sql = "select * from product_variants where product_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setLong(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariants pv = ProductVariants.builder()
                        .id(rs.getLong("id"))
                        .productId(rs.getLong("product_id"))
                        .variantName(rs.getString("name"))
                        .price(rs.getBigDecimal("price"))
                        .sku(rs.getString("sku"))
                        .quantity(rs.getInt("quantity"))
                        .build();

                BigDecimal finalPrice = rs.getBigDecimal("final_price");
                if (finalPrice != null) {
                    pv.setFinalPrice(finalPrice);
                }

                list.add(pv);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public int getQuantityById(long productId) {
        String sql = "select * from inventory where product_id = ?";
        int quantity = 0;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setLong(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int cache = rs.getInt("quantity");
                quantity += cache;
            }
            return quantity;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public ProductVariants getVariantByVariantId(long variantId) {
        String sql = "select * from product_variants where id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setLong(1, variantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariants pv = ProductVariants.builder()
                        .id(rs.getLong("id"))
                        .productId(rs.getLong("product_id"))
                        .variantName(rs.getString("name"))
                        .price(rs.getBigDecimal("price"))
                        .sku(rs.getString("sku"))
                        .build();

                BigDecimal finalPrice = rs.getBigDecimal("final_price");
                if (finalPrice != null) {
                    pv.setFinalPrice(finalPrice);
                }

                return pv;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public boolean update(ProductVariants variant) {

        String sql = " UPDATE product_variants SET name = ?, price = ?, sku = ?, final_price = ? WHERE id = ? ";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, variant.getVariantName());
            ps.setBigDecimal(2, variant.getPrice());
            ps.setString(3, variant.getSku());
            // Nếu variant đã có finalPrice thì dùng, nếu không thì mặc định bằng price
            BigDecimal finalPrice = variant.getFinalPrice() != null ? variant.getFinalPrice() : variant.getPrice();
            ps.setBigDecimal(4, finalPrice);
            ps.setLong(5, variant.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /** Thêm biến thể mới */
    public long insertVariant(ProductVariants variant) {
        String sql = "INSERT INTO product_variants (product_id, name, price, sku, final_price) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, variant.getProductId());
            ps.setString(2, variant.getVariantName());
            ps.setBigDecimal(3, variant.getPrice());
            ps.setString(4, variant.getSku());
            // Nếu variant đã có finalPrice thì dùng, nếu không thì mặc định bằng price
            BigDecimal finalPrice = variant.getFinalPrice() != null ? variant.getFinalPrice() : variant.getPrice();
            ps.setBigDecimal(5, finalPrice);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getLong(1);
            }
            return -1;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Cập nhật final_price cho một variant.
     */
    public void updateFinalPrice(long variantId, BigDecimal finalPrice) {
        String sql = "UPDATE product_variants SET final_price = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBigDecimal(1, finalPrice);
            ps.setLong(2, variantId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /** Xoá biến thể theo ID */
    public void deleteVariant(long variantId) {
        // Xoá inventory trước
        String deleteInventory = "DELETE FROM inventory WHERE variant_id = ?";
        String deleteVariant = "DELETE FROM product_variants WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps1 = con.prepareStatement(deleteInventory);
             PreparedStatement ps2 = con.prepareStatement(deleteVariant)) {
            ps1.setLong(1, variantId);
            ps1.executeUpdate();
            ps2.setLong(1, variantId);
            ps2.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


}
