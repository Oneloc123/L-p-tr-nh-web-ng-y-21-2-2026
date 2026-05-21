package code.salecar.dao;

import code.salecar.model.enumeration.DiscountEntityType;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.config.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {


    public List<Discount> getProductDiscount(Product p) {
        List<Discount> discounts = new ArrayList<>();
        String query = "select * from discount where entity_type = 'product' and entity_id = ? and start_at <= NOW() and end_at >= NOW()";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setLong(1, p.getId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Discount discount = Discount.builder()
                        .name(rs.getString("name"))
                        .valueType(DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()))
                        .value(rs.getBigDecimal("value"))
                        .entityType(DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()))
                        .entityId(rs.getLong("entity_id"))
                        .startAt(rs.getTimestamp("start_at").toLocalDateTime())
                        .endAt(rs.getTimestamp("end_at").toLocalDateTime())
                        .createAt(LocalDateTime.now())
                        .build();
                discounts.add(discount);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discounts;

    }

    public static Discount getBrandDiscount(long brandid) {
        Discount discount = null;
        String query = "select * from discount where entity_type = 'brand' and entity_id = ?";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setLong(1, brandid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                 discount = Discount.builder()
                        .name(rs.getString("name"))
                        .valueType(DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()))
                        .value(rs.getBigDecimal("value"))
                        .entityType(DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()))
                        .entityId(rs.getLong("entity_id"))
                        .startAt(rs.getTimestamp("start_at").toLocalDateTime())
                        .endAt(rs.getTimestamp("end_at").toLocalDateTime())
                        .createAt(LocalDateTime.now())
                        .build();
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discount;
    }

    public static Discount getCategoryDiscount(long categoryid) {
        Discount discount = null;
        String query = "select * from discount where entity_type = 'category' and  entity_id = ?";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setLong(1, categoryid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                 discount = Discount.builder()
                        .name(rs.getString("name"))
                        .valueType(DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()))
                        .value(rs.getBigDecimal("value"))
                        .entityType(DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()))
                        .entityId(rs.getLong("entity_id"))
                        .startAt(rs.getTimestamp("start_at").toLocalDateTime())
                        .endAt(rs.getTimestamp("end_at").toLocalDateTime())
                        .createAt(LocalDateTime.now())
                        .build();
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
                Discount discount = Discount.builder()
                        .name(rs.getString("name"))
                        .valueType(DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()))
                        .value(rs.getBigDecimal("value"))
                        .entityType(DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()))
                        .entityId(rs.getLong("entity_id"))
                        .startAt(rs.getTimestamp("start_at").toLocalDateTime())
                        .endAt(rs.getTimestamp("end_at").toLocalDateTime())
                        .createAt(LocalDateTime.now())
                        .build();
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
                Discount discount = Discount.builder()
                        .name(rs.getString("name"))
                        .valueType(DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()))
                        .value(rs.getBigDecimal("value"))
                        .entityType(DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()))
                        .entityId(rs.getLong("entity_id"))
                        .startAt(rs.getTimestamp("start_at").toLocalDateTime())
                        .endAt(rs.getTimestamp("end_at").toLocalDateTime())
                        .createAt(LocalDateTime.now())
                        .build();
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
            ps.setLong(5, discount.getEntityId());
            ps.setObject(6, discount.getId() > 0 ? null : 1); // priority
            ps.setTimestamp(7, Timestamp.valueOf(discount.getStartAt()));
            ps.setTimestamp(8, Timestamp.valueOf(discount.getEndAt()));

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

    public Discount findActiveDiscount(String product, long productId) {
        String sql = "SELECT * FROM discount " +
                                  "WHERE entity_type = ? AND entity_id = ? " +
                                  "AND NOW() BETWEEN start_at AND end_at " +
                                 "ORDER BY priority DESC LIMIT 1";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, product);
            ps.setLong(2, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Discount discount = Discount.builder()
                        .name(rs.getString("name"))
                        .valueType(DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()))
                        .value(rs.getBigDecimal("value"))
                        .entityType(DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()))
                        .entityId(rs.getLong("entity_id"))
                        .startAt(rs.getTimestamp("start_at").toLocalDateTime())
                        .endAt(rs.getTimestamp("end_at").toLocalDateTime())
                        .createAt(LocalDateTime.now())
                        .build();
                return  discount;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;

    }
}
