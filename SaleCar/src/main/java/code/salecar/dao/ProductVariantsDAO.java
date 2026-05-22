package code.salecar.dao;

import code.salecar.config.DBConnection;
import code.salecar.model.Image;
import code.salecar.model.product.entity.ProductVariants;

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

                list.add(pv);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
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

        String sql = " UPDATE product_variants SET  name = ?, price = ?, sku = ?, quantity =? WHERE id = ? ";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, variant.getVariantName());
            ps.setBigDecimal(2, variant.getPrice());
            ps.setString(3, variant.getSku());
            ps.setInt(4, variant.getQuantity());
            ps.setLong(5, variant.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


}
