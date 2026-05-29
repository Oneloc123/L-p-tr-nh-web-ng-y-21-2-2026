package code.salecar.dao;

import code.salecar.config.DBConnection;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Banner;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class BannerDAO {

    private static final String BASE_SELECT = "SELECT id, title, description, image_url, redirect_url, display_order, status, created_at, updated_at FROM banner";

    private static final Map<String, String> SORTABLE_FIELDS = new HashMap<>();
    static {
        SORTABLE_FIELDS.put("title", "title");
        SORTABLE_FIELDS.put("display_order", "display_order");
        SORTABLE_FIELDS.put("status", "status");
        SORTABLE_FIELDS.put("created_at", "created_at");
    }

    /** Xây dựng mệnh đề WHERE và thêm tham số cho tìm kiếm & lọc trạng thái */
    private void appendWhereClause(StringBuilder sql, List<Object> params, String search, int statusFilter) {
        sql.append(" WHERE 1=1");
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR description LIKE ?)");
            String like = "%" + search.trim() + "%";
            params.add(like);
            params.add(like);
        }
        if (statusFilter != -1) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }
    }

    public List<Banner> getBanners(String search, int statusFilter, String sortField, String sortOrder, int limit, int page) {
        List<Banner> banners = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(BASE_SELECT);
        appendWhereClause(sql, params, search, statusFilter);

        /** Sắp xếp — whitelist để ngăn chặn SQL injection */
        String field = (sortField != null) ? SORTABLE_FIELDS.getOrDefault(sortField, "id") : "id";
        String order = "asc".equalsIgnoreCase(sortOrder) ? "ASC" : "DESC";
        sql.append(" ORDER BY ").append(field).append(" ").append(order);

        /** Phân trang */
        int offset = (page - 1) * limit;
        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                banners.add(mapBanner(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return banners;
    }

    public int countBanners(String search, int statusFilter) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM banner");
        appendWhereClause(sql, params, search, statusFilter);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public Banner getBannerById(long id) {
        String sql = BASE_SELECT + " WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapBanner(rs);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public long insertBanner(Banner banner) {
        String sql = "INSERT INTO banner (title, description, image_url, redirect_url, display_order, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, banner.getTitle());
            ps.setString(2, banner.getDescription());
            ps.setString(3, banner.getImageUrl());
            ps.setString(4, banner.getRedirectUrl());
            ps.setInt(5, banner.getSortOrder());
            ps.setInt(6, banner.getIntStatus());
            ps.setTimestamp(7, Timestamp.valueOf(banner.getCreatedAt()));
            ps.setTimestamp(8, Timestamp.valueOf(banner.getUpdatedAt()));

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return -1;
    }

    public boolean updateBanner(Banner banner) {
        String sql = "UPDATE banner SET title = ?, description = ?, image_url = ?, redirect_url = ?, display_order = ?, status = ?, updated_at = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, banner.getTitle());
            ps.setString(2, banner.getDescription());
            ps.setString(3, banner.getImageUrl());
            ps.setString(4, banner.getRedirectUrl());
            ps.setInt(5, banner.getSortOrder());
            ps.setInt(6, banner.getIntStatus());
            ps.setTimestamp(7, Timestamp.valueOf(banner.getUpdatedAt()));
            ps.setLong(8, banner.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteBanner(long id) {
        String sql = "DELETE FROM banner WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Banner> getActiveBanners() {
        List<Banner> banners = new ArrayList<>();
        String sql = BASE_SELECT + " WHERE status = 1 ORDER BY display_order ASC, id ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                banners.add(mapBanner(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return banners;
    }

    public boolean toggleStatus(long id) {
        String sql = "UPDATE banner SET status = CASE WHEN status = 1 THEN 0 ELSE 1 END, updated_at = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setLong(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private Banner mapBanner(ResultSet rs) throws SQLException {
        Banner banner = new Banner();
        banner.setId(rs.getLong("id"));
        banner.setTitle(rs.getString("title"));
        banner.setDescription(rs.getString("description"));
        banner.setImageUrl(rs.getString("image_url"));
        banner.setRedirectUrl(rs.getString("redirect_url"));
        banner.setSortOrder(rs.getInt("display_order"));
        banner.setStatus(Status.fromCode(rs.getInt("status")));
        banner.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        banner.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        return banner;
    }
}
