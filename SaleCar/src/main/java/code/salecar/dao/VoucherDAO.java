package code.salecar.dao;

import code.salecar.model.Voucher;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO {

    public List<Voucher> getVouchers() {
        ArrayList<Voucher> vouchers = new ArrayList<Voucher>();
        String sql = "select * from voucher";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Voucher voucher = new Voucher(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("value_type"),
                        rs.getBigDecimal("value"),
                        rs.getBigDecimal("max_discount"),
                        rs.getBigDecimal("min_order_value"),
                        rs.getInt("usage_limit"),
                        rs.getInt("used_count"),
                        rs.getDate("start_at"),
                        rs.getDate("end_at"),
                        rs.getInt("status"),
                        rs.getDate("created_at")
                );
                vouchers.add(voucher);
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return vouchers;
    }
}