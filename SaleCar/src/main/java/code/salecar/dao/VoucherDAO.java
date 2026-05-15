package code.salecar.dao;

import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Voucher;
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
                        DiscountValueType.valueOf(rs.getString("value_type").toUpperCase()),
                        rs.getBigDecimal("value"),
                        rs.getBigDecimal("max_discount"),
                        rs.getBigDecimal("min_order_value"),
                        rs.getInt("usage_limit"),
                        rs.getInt("used_count"),
                        rs.getTimestamp("start_at").toLocalDateTime(),
                        rs.getTimestamp("end_at").toLocalDateTime(),
                        Status.fromCode(rs.getInt("status")),
                        rs.getTimestamp("created_at").toLocalDateTime()
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

    public Voucher getVoucherId(int voucherId) {

        String sql = "select * from voucher  where id = ? and status = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Voucher voucher = new Voucher(
                        rs.getInt("id"),
                        rs.getString("code"),
                        DiscountValueType.valueOf(rs.getString("value_type")),
                        rs.getBigDecimal("value"),
                        rs.getBigDecimal("max_discount"),
                        rs.getBigDecimal("min_order_value"),
                        rs.getInt("usage_limit"),
                        rs.getInt("used_count"),
                        rs.getTimestamp("start_at").toLocalDateTime(),
                        rs.getTimestamp("end_at").toLocalDateTime(),
                        Status.fromCode(rs.getInt("status")),
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
                return voucher;
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}