package code.salecar.dao;

import code.salecar.model.User;
import code.salecar.model.UserFilter;
import code.salecar.config.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class UserDao {
    public User getUserByUsername(String username) {
        User user = new User();
        String sql = "select * from users where username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setPassword(rs.getString(3));
                user.setFullname(rs.getString(4));
                user.setEmail(rs.getString(5));
                user.setDescription(rs.getString(6));
                user.setPhonenumber(rs.getString(7));
                user.setRole(rs.getString(8));
                user.setAddressid(rs.getString(9));
                user.setStatus(rs.getBoolean(10));
                user.setCreatedat(rs.getDate(11));
                user.setUpdatedat(rs.getDate(12));
                user.setImgURL(rs.getString(13));
                return user;
            } else {
                return null;
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    public void register(User user) {
        String sql = "insert into users" +
                "(username,password,fullname,email,description,phoneNumber,role,address,status,CreateAt,UpdateAt,imgURL,updatePassword) " +
                "values " +
                "(?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getDescription());
            ps.setString(6, user.getPhonenumber());
            ps.setString(7, user.getRole());
            ps.setString(8, user.getAddressid());
            ps.setBoolean(9, user.getStatus());
            ps.setDate(10, user.getCreatedat());
            ps.setDate(11, user.getUpdatedat());
            ps.setString(12,user.getImgURL());
            ps.setDate(13,user.getCreatedat());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);

        }
    }

    public void UpdateProfile(User user) {
        String sql = "UPDATE users " +
                "SET  " +
                "   fullname = ?" +
                ", email= ?" +
                ", phoneNumber =?" +
                ", description = ?" +
                ", UpdateAt = ?  " +
                ", status =?" +
                ", password = ?" +
                ", imgURL = ?" +
                ", username = ?" +
                ", updatePassword = ?" +
                " WHERE id = ?;";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhonenumber());
            ps.setString(4, user.getDescription());
            ps.setDate(5, user.getUpdatedat());
            ps.setBoolean(6, user.getStatus());
            ps.setString(7, user.getPassword());
            ps.setString(8, user.getImgURL());
            ps.setString(9,user.getUsername());
            ps.setDate(10, user.getUpdatePassword());
             ps.setInt(11, user.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public String getUserNameById(int userId) {
        String sql = "select fullname from users where id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "";
    }

    public User getUserById(int id) {
        User user = new User();
        String sql = "select * from users where id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setPassword(rs.getString(3));
                user.setFullname(rs.getString(4));
                user.setEmail(rs.getString(5));
                user.setDescription(rs.getString(6));
                user.setPhonenumber(rs.getString(7));
                user.setRole(rs.getString(8));
                user.setAddressid(rs.getString(9));
                user.setStatus(rs.getBoolean(10));
                user.setCreatedat(rs.getDate(11));
                user.setUpdatedat(rs.getDate(12));
                user.setImgURL(rs.getString(13));
                user.setUpdatePassword(rs.getDate(14));
                return user;
            } else {
                return null;
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public User getUserByEmail(String email) {
        User user = new User();
        String sql = "select * from users where email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setPassword(rs.getString(3));
                user.setFullname(rs.getString(4));
                user.setEmail(rs.getString(5));
                user.setDescription(rs.getString(6));
                user.setPhonenumber(rs.getString(7));
                user.setRole(rs.getString(8));
                user.setAddressid(rs.getString(9));
                user.setStatus(rs.getBoolean(10));
                user.setCreatedat(rs.getDate(11));
                user.setUpdatedat(rs.getDate(12));
                user.setImgURL(rs.getString(13));
                user.setUpdatePassword(rs.getDate(14));
                return user;
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<User> getList() {
        List<User> list = new ArrayList<>();
        String query = "select * from users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(9),
                        rs.getString(8),
                        rs.getBoolean(10),
                        rs.getDate(11),
                        rs.getDate(12),
                        rs.getString(13)
                );
                list.add(u);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public void deleteUserById(int id) {
        String query = "delete from users where id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1,id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Builds the dynamic WHERE clause shared by {@link #searchUsers(UserFilter)}
     * and {@link #countUsers(UserFilter)}. Values are added to {@code params}
     * in order; the caller binds them as PreparedStatement parameters.
     */
    private String buildWhereClause(UserFilter f, List<Object> params) {
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");

        if (f.hasKeyword()) {
            where.append(" AND (username LIKE ? OR fullname LIKE ? OR email LIKE ? OR phoneNumber LIKE ?) ");
            String like = "%" + f.getKeyword().trim() + "%";
            params.add(like);
            params.add(like);
            params.add(like);
            params.add(like);
        }
        if (f.hasRole()) {
            where.append(" AND role = ? ");
            params.add(f.getRole().trim());
        }
        if (f.hasStatus()) {
            where.append(" AND status = ? ");
            params.add(f.getStatus());
        }
        if (f.hasDateFrom()) {
            where.append(" AND CreateAt >= ? ");
            params.add(f.getDateFrom().trim());
        }
        if (f.hasDateTo()) {
            // inclusive of the whole end day
            where.append(" AND CreateAt < DATE_ADD(?, INTERVAL 1 DAY) ");
            params.add(f.getDateTo().trim());
        }
        return where.toString();
    }

    /**
     * Maps the logical sort key + direction to a safe, whitelisted ORDER BY
     * clause. Never concatenates raw user input into SQL.
     */
    private String buildOrderByClause(UserFilter f) {
        String column;
        if ("fullname".equalsIgnoreCase(f.getSortBy())) {
            column = "fullname";
        } else {
            column = "id";
        }
        String dir = "asc".equalsIgnoreCase(f.getSortDir()) ? "ASC" : "DESC";
        return " ORDER BY " + column + " " + dir + " ";
    }

    private void bindParams(PreparedStatement ps, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
    }

    /**
     * Unified search/filter/sort with pagination for the admin user list.
     */
    public List<User> searchUsers(UserFilter f) {
        List<User> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        String sql = "SELECT * FROM users"
                + buildWhereClause(f, params)
                + buildOrderByClause(f)
                + " LIMIT ? OFFSET ?";
        params.add(f.getPageSize());
        params.add(f.getOffset());

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            bindParams(ps, params);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(9),
                        rs.getString(8),
                        rs.getBoolean(10),
                        rs.getDate(11),
                        rs.getDate(12),
                        rs.getString(13)
                );
                list.add(u);
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi tìm kiếm người dùng: " + e.getMessage(), e);
        }
        return list;
    }

    /**
     * Total number of rows matching the same filter (for pagination).
     */
    public int countUsers(UserFilter f) {
        List<Object> params = new ArrayList<>();
        String sql = "SELECT COUNT(*) FROM users" + buildWhereClause(f, params);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            bindParams(ps, params);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi đếm kết quả tìm kiếm người dùng: " + e.getMessage(), e);
        }
        return 0;
    }
}