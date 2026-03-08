package code.salecar.dao;

import code.salecar.model.Address;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AddressDao {
    public void setMainAddress(int addressId, int userId) {
        // xoá main cũ
        String sql = "update address set type = 'normal' where user_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1,userId);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        // đặt main mới
        String sql2 = "update address set type = 'main' where id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql2);) {
            ps.setInt(1,addressId);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void addAddress(Address address) {
        String sql = "insert into address" +
                "(user_id,street,commune,province,type,name) " +
                "values " +
                "(?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1,address.getUserId());
            ps.setString(2,address.getStreet());
            ps.setString(3,address.getCommune());
            ps.setString(4,address.getProvince());
            ps.setString(5,address.getType());
            ps.setString(6,address.getName());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void removeAddressById(int id) {
        String sql = "delete from address where id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1,id);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Address> getListAddressById(int id) {
        ArrayList<Address> list = new ArrayList<>();
        String sql = "select * from address where user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                list.add(new Address(rs.getInt(1),rs.getInt(2),rs.getString(3)
                ,rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7)));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return  list;
    }

    public void updateAddress(Address a) {
        String sql2 = "update address " +
                "set street = ?" +
                ", commune = ?" +
                ", province = ?" +
                " where id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql2);) {
            ps.setString(1,a.getStreet());
            ps.setString(2,a.getCommune());
            ps.setString(3, a.getProvince());
            ps.setInt(4,a.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
