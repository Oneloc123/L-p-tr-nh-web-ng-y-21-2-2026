package code.salecar.dao;

import code.salecar.model.User;
import code.salecar.model.product.dto.ProductItem;
import code.salecar.utils.DBConnection;

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
                "(username,password,fullname,email,description,phoneNumber,role,address,status,CreateAt,UpdateAt) " +
                "values " +
                "(?,?,?,?,?,?,?,?,?,?,?)";

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
            ps.setInt(9, user.getId());
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
                        rs.getString(8),
                        rs.getString(9),
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
}