package code.salecar.dao;

import code.salecar.config.DBConnection;
import code.salecar.model.Address;
import code.salecar.model.Addresses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AddressesDao {



    public void setMainAddress(int addressId, int userId) {
        // xoá main cũ
        String sql = "update addresses set type = 'normal' where user_id=?";

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
        String sql2 = "update addresses set type = 'main' where id=?";

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
    public void addAddress(Addresses address) {
        String sql = "insert into addresses" +
                "(user_id,address_line,ward_name,province_name,type,full_address,created_at,nameAddress,distric_name) " +
                "values " +
                "(?,?,?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1,address.getUserId());
            ps.setString(2,address.getAddressLine());
            ps.setString(3,address.getWardName());
            ps.setString(4,address.getProvinceName());
            ps.setString(5,address.getType());
            ps.setString(6,address.getAddressLine()+", "+address.getWardName()+", "+address.getProvinceName());
            ps.setDate(7,address.getCreateAt());
            ps.setString(8,address.getNameAddress());
            ps.setString(9,address.getDistricName());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    public void removeAddressById(int id) {
        String sql = "delete from addresses where id = ?";

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
    public ArrayList<Addresses> getListAddressById(int id) {
        ArrayList<Addresses> list = new ArrayList<>();
        String sql = "select * from addresses where user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                list.add(new Addresses(rs.getInt(1),rs.getString(2), rs.getInt(3),
                rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getDate(8)
                ,rs.getString(9),rs.getString(10)));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return  list;
    }
    public ArrayList<Addresses> getListAddress() {
        ArrayList<Addresses> list = new ArrayList<>();
        String sql = "select * from addresses ";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                list.add(new Addresses(rs.getInt(1),rs.getString(2), rs.getInt(3),
                        rs.getString(4),rs.getString(5),rs.getString(6),
                        rs.getString(7),rs.getDate(8),rs.getString(9),rs.getString(10)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return  list;
    }
}
