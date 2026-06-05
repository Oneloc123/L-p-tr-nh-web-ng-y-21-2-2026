package code.salecar.dao;

import code.salecar.config.DBConnection;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Voucher;
import code.salecar.model.product.entity.VoucherScope;
import code.salecar.model.product.filter.VoucherFilter;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO {

    // ==================== DANH SÁCH VỚI LỌC, SẮP XẾP, PHÂN TRANG ====================

    public List<Voucher> getVouchers(VoucherFilter filter) {
        List<Voucher> vouchers = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT v.* FROM voucher v WHERE 1=1 ");

        List<Object> params = new ArrayList<>();
        buildWhereClause(sql, params, filter);

        String sortColumn = getSortColumn(filter.getSort());
        String sortOrder = "desc".equalsIgnoreCase(filter.getOrder()) ? "DESC" : "ASC";
        if ("remaining".equals(filter.getSort())) {
            sql.append(" ORDER BY (v.usage_limit - v.used_count) ").append(sortOrder);
        } else {
            sql.append(" ORDER BY v.").append(sortColumn).append(" ").append(sortOrder);
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(filter.getLimit());
        params.add(filter.getOffset());

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            setParams(ps, params);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                vouchers.add(mapVoucher(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching vouchers", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return vouchers;
    }

    public int getTotalVouchers(VoucherFilter filter) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM voucher v WHERE 1=1 ");

        List<Object> params = new ArrayList<>();
        buildWhereClause(sql, params, filter);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            setParams(ps, params);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error counting vouchers", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    private void buildWhereClause(StringBuilder sql, List<Object> params, VoucherFilter filter) {
        if (filter.getSearch() != null && !filter.getSearch().isEmpty()) {
            sql.append(" AND v.code LIKE ?");
            params.add("%" + filter.getSearch() + "%");
        }

        if (filter.getStatus() != null && !filter.getStatus().isEmpty()) {
            if ("active".equalsIgnoreCase(filter.getStatus())) {
                sql.append(" AND v.status = ?");
                params.add(Status.ACTIVE.getCode());
            } else if ("inactive".equalsIgnoreCase(filter.getStatus())) {
                sql.append(" AND v.status = ?");
                params.add(Status.INACTIVE.getCode());
            }
        }

        if (filter.getTimeStatus() != null && !filter.getTimeStatus().isEmpty()) {
            LocalDateTime now = LocalDateTime.now();
            switch (filter.getTimeStatus()) {
                case "active":
                    sql.append(" AND v.status = ? AND (v.start_at IS NULL OR v.start_at <= ?) AND (v.end_at IS NULL OR v.end_at >= ?) AND (v.usage_limit IS NULL OR v.used_count < v.usage_limit)");
                    params.add(Status.ACTIVE.getCode());
                    params.add(Timestamp.valueOf(now));
                    params.add(Timestamp.valueOf(now));
                    break;
                case "upcoming":
                    sql.append(" AND (v.start_at IS NOT NULL AND v.start_at > ?)");
                    params.add(Timestamp.valueOf(now));
                    break;
                case "expired":
                    sql.append(" AND (v.end_at IS NOT NULL AND v.end_at < ?)");
                    params.add(Timestamp.valueOf(now));
                    break;
            }
        }
    }

    private String getSortColumn(String sort) {
        if (sort == null) return "created_at";
        switch (sort) {
            case "code": return "code";
            case "value": return "value";
            case "value_type": return "value_type";
            case "max_discount": return "max_discount";
            case "min_order_value": return "min_order_value";
            case "usage_limit": return "usage_limit";
            case "status": return "status";
            case "created_at": return "created_at";
            default: return "created_at";
        }
    }

    // ==================== LẤY MỘT VOUCHER ====================

    public Voucher getVoucherById(long id) {
        String sql = "SELECT * FROM voucher WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapVoucher(rs);
            }
        } catch (Exception e) {
            throw new RuntimeException("Error fetching voucher by ID", e);
        }
        return null;
    }

    // ==================== TẠO MỚI ====================

    public long createVoucher(Voucher voucher) {
        String sql = "INSERT INTO voucher (code, value_type, value, max_discount, min_order_value, " +
                     "usage_limit, used_count, max_usage_per_user, start_at, end_at, status, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, voucher.getCode());
            ps.setString(2, voucher.getValueType().name().toLowerCase());
            ps.setBigDecimal(3, voucher.getValue());
            ps.setBigDecimal(4, voucher.getMaxDiscount());
            ps.setBigDecimal(5, voucher.getMinOrderValue());
            ps.setInt(6, voucher.getUsageLimit());
            ps.setInt(7, 0);
            ps.setInt(8, voucher.getMaxUsagePerUser());
            ps.setTimestamp(9, voucher.getStartAt() != null ? Timestamp.valueOf(voucher.getStartAt()) : null);
            ps.setTimestamp(10, voucher.getEndAt() != null ? Timestamp.valueOf(voucher.getEndAt()) : null);
            ps.setInt(11, voucher.getStatus() != null ? voucher.getStatus().getCode() : Status.ACTIVE.getCode());
            ps.setTimestamp(12, Timestamp.valueOf(LocalDateTime.now()));

            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error creating voucher", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return -1;
    }

    // ==================== CẬP NHẬT ====================

    public boolean updateVoucher(Voucher voucher) {
        String sql = "UPDATE voucher SET code = ?, value_type = ?, value = ?, max_discount = ?, " +
                     "min_order_value = ?, usage_limit = ?, max_usage_per_user = ?, " +
                     "start_at = ?, end_at = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucher.getCode());
            ps.setString(2, voucher.getValueType().name().toLowerCase());
            ps.setBigDecimal(3, voucher.getValue());
            ps.setBigDecimal(4, voucher.getMaxDiscount());
            ps.setBigDecimal(5, voucher.getMinOrderValue());
            ps.setInt(6, voucher.getUsageLimit());
            ps.setInt(7, voucher.getMaxUsagePerUser());
            ps.setTimestamp(8, voucher.getStartAt() != null ? Timestamp.valueOf(voucher.getStartAt()) : null);
            ps.setTimestamp(9, voucher.getEndAt() != null ? Timestamp.valueOf(voucher.getEndAt()) : null);
            ps.setInt(10, voucher.getStatus() != null ? voucher.getStatus().getCode() : Status.ACTIVE.getCode());
            ps.setLong(11, voucher.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating voucher", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // ==================== XÓA ====================

    public boolean deleteVoucher(long id) {
        deleteScopesByVoucherId(id);
        String sql = "DELETE FROM voucher WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting voucher", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // ==================== CHUYỂN TRẠNG THÁI ====================

    public boolean toggleStatus(long id) {
        String sql = "UPDATE voucher SET status = CASE WHEN status = 1 THEN 0 ELSE 1 END WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error toggling voucher status", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // ==================== PHẠM VI VOUCHER ====================

    public List<VoucherScope> getScopesByVoucherId(long voucherId) {
        List<VoucherScope> scopes = new ArrayList<>();
        String sql = "SELECT vs.*, " +
                     "CASE " +
                     "  WHEN vs.entity_type = 'product' THEN (SELECT p.name FROM product p WHERE p.id = vs.entity_id) " +
                     "  WHEN vs.entity_type = 'brand' THEN (SELECT b.name FROM brand b WHERE b.id = vs.entity_id) " +
                     "  WHEN vs.entity_type = 'category' THEN (SELECT c.name FROM category c WHERE c.id = vs.entity_id) " +
                     "  ELSE NULL " +
                     "END AS entity_name " +
                     "FROM voucher_scope vs WHERE vs.voucher_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, voucherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                VoucherScope scope = new VoucherScope();
                scope.setId(rs.getLong("id"));
                scope.setVoucherId(rs.getLong("voucher_id"));
                scope.setEntityType(rs.getString("entity_type"));
                scope.setEntityId(rs.getLong("entity_id"));
                scope.setEntityName(rs.getString("entity_name"));
                scopes.add(scope);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching voucher scopes", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return scopes;
    }

    public void saveScopes(long voucherId, List<VoucherScope> scopes) {
        deleteScopesByVoucherId(voucherId);
        if (scopes == null || scopes.isEmpty()) return;

        String sql = "INSERT INTO voucher_scope (voucher_id, entity_type, entity_id) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (VoucherScope scope : scopes) {
                ps.setLong(1, voucherId);
                ps.setString(2, scope.getEntityType());
                ps.setLong(3, scope.getEntityId());
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            throw new RuntimeException("Error saving voucher scopes", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteScopesByVoucherId(long voucherId) {
        String sql = "DELETE FROM voucher_scope WHERE voucher_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, voucherId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting voucher scopes", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // ==================== KIỂM TRA MÃ TỒN TẠI ====================

    public boolean isCodeExists(String code, Long excludeId) {
        String sql = "SELECT COUNT(*) FROM voucher WHERE code = ?";
        if (excludeId != null) {
            sql += " AND id != ?";
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            if (excludeId != null) {
                ps.setLong(2, excludeId);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error checking code existence", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    // ==================== DỮ LIỆU THAM CHIẾU (cho dropdown phạm vi) ====================

    public List<Object[]> getAllBrands() {
        List<Object[]> brands = new ArrayList<>();
        String sql = "SELECT id, name FROM brand WHERE status = 1 ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                brands.add(new Object[]{rs.getLong("id"), rs.getString("name")});
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching brands", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return brands;
    }

    public List<Object[]> getAllCategories() {
        List<Object[]> categories = new ArrayList<>();
        String sql = "SELECT id, name FROM category WHERE status = 1 ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Object[]{rs.getLong("id"), rs.getString("name")});
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching categories", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return categories;
    }

    public List<Object[]> getAllProducts() {
        List<Object[]> products = new ArrayList<>();
        String sql = "SELECT id, name FROM product WHERE status = 1 ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Object[]{rs.getLong("id"), rs.getString("name")});
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching products", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    // ==================== PHƯƠNG THỨC HỖ TRỢ ====================

    private Voucher mapVoucher(ResultSet rs) throws SQLException {
        Voucher voucher = new Voucher();
        voucher.setId(rs.getLong("id"));
        voucher.setCode(rs.getString("code"));

        String valueTypeStr = rs.getString("value_type");
        if (valueTypeStr != null) {
            try {
                voucher.setValueType(DiscountValueType.fromString(valueTypeStr));
            } catch (IllegalArgumentException e) {
                voucher.setValueType(DiscountValueType.PERCENT);
            }
        }

        voucher.setValue(rs.getBigDecimal("value"));
        voucher.setMaxDiscount(rs.getBigDecimal("max_discount"));
        voucher.setMinOrderValue(rs.getBigDecimal("min_order_value"));
        voucher.setUsageLimit(rs.getInt("usage_limit"));
        voucher.setUsedCount(rs.getInt("used_count"));

        try {
            voucher.setMaxUsagePerUser(rs.getInt("max_usage_per_user"));
        } catch (SQLException ignored) {
            voucher.setMaxUsagePerUser(1);
        }

        Timestamp startAt = rs.getTimestamp("start_at");
        if (startAt != null) voucher.setStartAt(startAt.toLocalDateTime());

        Timestamp endAt = rs.getTimestamp("end_at");
        if (endAt != null) voucher.setEndAt(endAt.toLocalDateTime());

        voucher.setStatus(Status.fromCode(rs.getInt("status")));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) voucher.setCreatedAt(createdAt.toLocalDateTime());

        return voucher;
    }

    private void setParams(PreparedStatement ps, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            Object param = params.get(i);
            if (param instanceof String) {
                ps.setString(i + 1, (String) param);
            } else if (param instanceof Integer) {
                ps.setInt(i + 1, (Integer) param);
            } else if (param instanceof Long) {
                ps.setLong(i + 1, (Long) param);
            } else if (param instanceof Timestamp) {
                ps.setTimestamp(i + 1, (Timestamp) param);
            } else {
                ps.setNull(i + 1, Types.NULL);
            }
        }
    }
}
