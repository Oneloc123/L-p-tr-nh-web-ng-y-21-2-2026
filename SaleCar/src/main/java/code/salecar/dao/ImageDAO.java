package code.salecar.dao;

import code.salecar.model.Image;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ImageDAO {

    public String getImage(Image.entityType type, int id) {
        String query = "select image_url1 from image where entity_type = ? and entity_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setString(1, type.toString());
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("image_url1");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;

    }

    public List<String> getImageProduct(int id) {
        List<String> list = new ArrayList<>();
        String query = "select image_url1 from image where entity_type = ? and entity_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ps.setString(1, Image.entityType.product.toString());
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("image_url1"));
                list.add(rs.getString("image_url2"));
                list.add(rs.getString("image_url3"));
                list.add(rs.getString("image_url4"));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}
