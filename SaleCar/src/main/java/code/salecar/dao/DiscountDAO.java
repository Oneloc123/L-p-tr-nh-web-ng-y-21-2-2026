package code.salecar.dao;

import code.salecar.model.Discount;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {

    public List<Discount> selectAll() throws Exception {
        List<Discount>  discounts = new ArrayList<>();
        String query = "select * from discount";
        List<Discount> list;
        try (Connection con = (Connection) DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Discount discount = new Discount(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("value_type"),
                        rs.getBigDecimal("value"),
                        rs.getString("entity_type"),
                        rs.getInt("entity_id"),
                        rs.getDate("start_at"),
                        rs.getDate("end_at"),
                        rs.getDate("create_at")
                        );
                discounts.add(discount);
            }

        }
        return discounts;
    }
}
