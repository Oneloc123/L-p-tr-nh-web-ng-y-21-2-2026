package code.salecar.dao;

import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.enumeration.DiscountEntityType;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.filter.DiscountFilter;
import code.salecar.config.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {

    /**
     * Helper: map current ResultSet row to Discount object (static version).
     */
    private static Discount mapDiscountStatic(ResultSet rs) throws SQLException {
        return Discount.builder()
                .id(rs.getLong("id"))
                .name(rs.getString("name"))
                .valueType(DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()))
                .value(rs.getBigDecimal("value"))
                .entityType(DiscountEntityType.valueOf(rs.getString("entity_type").toUpperCase()))
                .entityId(rs.getLong("entity_id"))
                .status(Status.fromCode(rs.getInt("status")))
                .startAt(rs.getTimestamp("start_at") != null ? rs.getTimestamp("start_at").toLocalDateTime() : null)
                .endAt(rs.getTimestamp("end_at") != null ? rs.getTimestamp("end_at").toLocalDateTime() : null)
                .createAt(rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : LocalDateTime.now())
                .updateAt(rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null)
                .build();
    }

    /**
     * Helper: map current ResultSet row to Discount object (instance version).
     */
    private Discount mapDiscount(ResultSet rs) throws SQLException {
        return mapDiscountStatic(rs);
    }

    public List<Discount> getProductDiscount(Product p) {
        List<Discount> discounts = new ArrayList<>();
        String query = "select * from discount where entity_type = 'product' and entity_id = ? and start_at <= NOW() and end_at >= NOW()";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setLong(1, p.getId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                discounts.add(mapDiscount(rs));
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
                discount = mapDiscountStatic(rs);
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
                discount = mapDiscountStatic(rs);
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
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                discounts.add(mapDiscount(rs));
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
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                discounts.add(mapDiscount(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discounts;
    }

    public int insertProductDiscount(Discount discount) {
        String query = "INSERT INTO discount (name, value_type, value, entity_type, entity_id, status, priority, start_at, end_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, discount.getName());
            ps.setString(2, discount.getValueType().toString().toLowerCase());
            ps.setBigDecimal(3, discount.getValue());
            ps.setString(4, discount.getEntityType().toString().toLowerCase());
            ps.setLong(5, discount.getEntityId());
            ps.setInt(6, discount.getStatus() != null ? discount.getStatus().getCode() : Status.ACTIVE.getCode());
            ps.setObject(7, discount.getId() > 0 ? null : 1); // priority
            ps.setTimestamp(8, Timestamp.valueOf(discount.getStartAt()));
            ps.setTimestamp(9, Timestamp.valueOf(discount.getEndAt()));

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

    public Discount findActiveDiscount(String entityType, long entityId) {
        String sql = "SELECT * FROM discount " +
                                  "WHERE entity_type = ? AND entity_id = ? " +
                                  "AND status = 1 AND NOW() BETWEEN start_at AND end_at " +
                                 "ORDER BY priority DESC LIMIT 1";
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, entityType);
            ps.setLong(2, entityId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapDiscount(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    /**
     * Lấy danh sách discount với filter và phân trang.
     */
    public List<Discount> getAllDiscounts(DiscountFilter filter) {
        List<Discount> discounts = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT d.*, ");
        sql.append("  (SELECT COUNT(*) FROM product p ");
        sql.append("   WHERE d.entity_type = 'product' AND d.entity_id = p.id) AS applied_products_count ");
        sql.append("FROM discount d WHERE 1=1 ");

        /** Filter theo thời gian hoạt động */
        if ("active".equals(filter.getTimeStatus())) {
            sql.append(" AND NOW() BETWEEN d.start_at AND d.end_at ");
        } else if ("upcoming".equals(filter.getTimeStatus())) {
            sql.append(" AND NOW() < d.start_at ");
        } else if ("expired".equals(filter.getTimeStatus())) {
            sql.append(" AND NOW() > d.end_at ");
        }
        // "all" -> no filter

        /** Filter theo brand */
        if (filter.getBrandId() > 0) {
            sql.append(" AND ((d.entity_type = 'product' AND d.entity_id IN (SELECT id FROM product WHERE brand_id = ?))");
            sql.append("   OR (d.entity_type = 'brand' AND d.entity_id = ?))");
            params.add(filter.getBrandId());
            params.add(filter.getBrandId());
        }

        /** Filter theo category */
        if (filter.getCategoryId() > 0) {
            sql.append(" AND ((d.entity_type = 'product' AND d.entity_id IN (SELECT id FROM product WHERE category_id = ?))");
            sql.append("   OR (d.entity_type = 'category' AND d.entity_id = ?))");
            params.add(filter.getCategoryId());
            params.add(filter.getCategoryId());
        }

        /** Filter theo product */
        if (filter.getProductId() > 0) {
            sql.append(" AND d.entity_type = 'product' AND d.entity_id = ?");
            params.add(filter.getProductId());
        }

        /** Sắp xếp */
        sql.append(" ORDER BY d.created_at DESC ");

        /** Phân trang */
        sql.append(" LIMIT ? OFFSET ?");
        params.add(filter.getLimit());
        params.add(filter.getOffset());

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Discount discount = mapDiscount(rs);
                discount.setAppliedProductsCount(rs.getLong("applied_products_count"));
                discounts.add(discount);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return discounts;
    }

    /**
     * Đếm tổng số discount với filter (cho pagination).
     */
    public int getTotalDiscounts(DiscountFilter filter) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM discount d WHERE 1=1 ");

        /** Filter theo thời gian hoạt động */
        if ("active".equals(filter.getTimeStatus())) {
            sql.append(" AND NOW() BETWEEN d.start_at AND d.end_at ");
        } else if ("upcoming".equals(filter.getTimeStatus())) {
            sql.append(" AND NOW() < d.start_at ");
        } else if ("expired".equals(filter.getTimeStatus())) {
            sql.append(" AND NOW() > d.end_at ");
        }

        /** Filter theo brand */
        if (filter.getBrandId() > 0) {
            sql.append(" AND ((d.entity_type = 'product' AND d.entity_id IN (SELECT id FROM product WHERE brand_id = ?))");
            sql.append("   OR (d.entity_type = 'brand' AND d.entity_id = ?))");
            params.add(filter.getBrandId());
            params.add(filter.getBrandId());
        }

        /** Filter theo category */
        if (filter.getCategoryId() > 0) {
            sql.append(" AND ((d.entity_type = 'product' AND d.entity_id IN (SELECT id FROM product WHERE category_id = ?))");
            sql.append("   OR (d.entity_type = 'category' AND d.entity_id = ?))");
            params.add(filter.getCategoryId());
            params.add(filter.getCategoryId());
        }

        /** Filter theo product */
        if (filter.getProductId() > 0) {
            sql.append(" AND d.entity_type = 'product' AND d.entity_id = ?");
            params.add(filter.getProductId());
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    /**
     * Lấy discount theo ID.
     */
    public Discount getDiscountById(long id) {
        String sql = "SELECT * FROM discount WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapDiscount(rs);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    /**
     * Xóa discount theo ID.
     */
    public boolean deleteDiscount(long id) {
        String sql = "DELETE FROM discount WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Lấy danh sách Brand có product đang có discount (entity_type='product').
     */
    public List<Brand> getBrandsHaveDiscount() {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT DISTINCT br.id, br.name, br.logo, br.status, br.created_at, br.updated_at " +
                     "FROM brand br " +
                     "JOIN product p ON br.id = p.brand_id " +
                     "JOIN discount d ON d.entity_type = 'product' AND d.entity_id = p.id " +
                     "ORDER BY br.name ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setId(rs.getInt("id"));
                brand.setName(rs.getString("name"));
                brand.setLogo(rs.getString("logo"));
                brand.setStatus(Status.fromCode(rs.getInt("status")));
                brands.add(brand);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return brands;
    }

    /**
     * Lấy danh sách Category có product đang có discount (entity_type='product').
     */
    public List<Category> getCategoriesHaveDiscount() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT ct.id, ct.name, ct.icon, ct.status, ct.created_at, ct.updated_at " +
                     "FROM category ct " +
                     "JOIN product p ON ct.id = p.category_id " +
                     "JOIN discount d ON d.entity_type = 'product' AND d.entity_id = p.id " +
                     "ORDER BY ct.name ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setIcon(rs.getString("icon"));
                category.setStatus(Status.fromCode(rs.getInt("status")));
                categories.add(category);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return categories;
    }

    /**
     * Lấy danh sách Product có discount (entity_type='product').
     */
    public List<Product> getProductsHaveDiscount() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT DISTINCT p.id, p.name, p.price, p.status, p.created_at " +
                     "FROM product p " +
                     "JOIN discount d ON d.entity_type = 'product' AND d.entity_id = p.id " +
                     "ORDER BY p.name ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getLong("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setStatus(Status.fromCode(rs.getInt("status")));
                products.add(product);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }
}
