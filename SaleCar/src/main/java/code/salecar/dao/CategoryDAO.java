package code.salecar.dao;

import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public int getTotalCategory() {
        String sql = "SELECT COUNT(*) FROM category";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<String> getCategoryName() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT name from category";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                list.add( rs.getString("name"));
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }
    public String getCategoryName(int id) {

        String sql = "SELECT name from category where id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                return rs.getString("name");
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "";
    }
}
