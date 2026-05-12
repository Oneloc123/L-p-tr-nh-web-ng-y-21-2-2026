package code.salecar.dao;

import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {


    public List<Discount> getProductDiscount(Product p) {
        List<Discount> discounts = new ArrayList<>();
        String query = "select * from discount where entity_type = 'product' and entity_id = ? and start_at <= NOW() and end_at >= NOW()";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setInt(1, p.getId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Discount discount = new Discount(
                        rs.getInt("id"),
                        rs.getString("name"),
                        Discount.DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()),
                        rs.getBigDecimal("value"),
                        Discount.DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()),
                        rs.getInt("entity_id"),
                        rs.getDate("start_at"),
                        rs.getDate("end_at"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                discounts.add(discount);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discounts;

    }

    public static Discount getBrandDiscount(int brandid) {
        Discount discount = null;
        String query = "select * from discount where entity_type = 'brand' and entity_id = ?";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setInt(1, brandid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                discount = new Discount(
                        rs.getInt("id"),
                        rs.getString("name"),
                        Discount.DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()),
                        rs.getBigDecimal("value"),
                        Discount.DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()),
                        rs.getInt("entity_id"),
                        rs.getDate("start_at"),
                        rs.getDate("end_at"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discount;
    }

    public static Discount getCategoryDiscount(int categoryid) {
        Discount discount = null;
        String query = "select * from discount where entity_type = 'category' and  entity_id = ?";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setInt(1, categoryid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                discount = new Discount(
                        rs.getInt("id"),
                        rs.getString("name"),
                        Discount.DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()),
                        rs.getBigDecimal("value"),
                        Discount.DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()),
                        rs.getInt("entity_id"),
                        rs.getDate("start_at"),
                        rs.getDate("end_at"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discount;
    }

    public List<Discount> selectAll() {
        List<Discount> discounts = new ArrayList<>();
        String query = "select * from discount where start_at <= NOW() and end_at >= NOW() ";
        List<Discount> list;
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Discount discount = new Discount(
                        rs.getInt("id"),
                        rs.getString("name"),
                        Discount.DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()),
                        rs.getBigDecimal("value"),
                        Discount.DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()),
                        rs.getInt("entity_id"),
                        rs.getDate("start_at"),
                        rs.getDate("end_at"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                discounts.add(discount);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discounts;
    }

    public List<Discount> getEffectDiscount(Product p) {
        List<Discount> discounts = new ArrayList<>();
        String query = "select * from discount ";
        List<Discount> list;
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Discount discount = new Discount(
                        rs.getInt("id"),
                        rs.getString("name"),
                        Discount.DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()),
                        rs.getBigDecimal("value"),
                        Discount.DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()),
                        rs.getInt("entity_id"),
                        rs.getDate("start_at"),
                        rs.getDate("end_at"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                discounts.add(discount);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discounts;
    }

    public int insertProductDiscount(Discount discount) {
        String query = "INSERT INTO discount (name, value_type, value, entity_type, entity_id, priority, start_at, end_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, discount.getName());
            ps.setString(2, discount.getValueType().toString().toLowerCase());
            ps.setBigDecimal(3, discount.getValue());
            ps.setString(4, discount.getEntityType().toString().toLowerCase());
            ps.setInt(5, discount.getEntityId());
            ps.setObject(6, discount.getId() > 0 ? null : 1); // priority
            ps.setDate(7, discount.getStartAt());
            ps.setDate(8, discount.getEndAt());

            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            return -1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
