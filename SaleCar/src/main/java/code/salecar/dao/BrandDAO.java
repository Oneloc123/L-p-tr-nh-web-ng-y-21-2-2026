package code.salecar.dao;

import code.salecar.model.brand.Brand;
import code.salecar.model.brand.BrandFilter;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {

    public List<Brand> getBrands() {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT br.id, br.name, br.link_brand, br.description,br.status, br.created_at, br.updated_at " +
                "FROM brand br ";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("link_brand"),
                        rs.getString("description"),
                        rs.getInt("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                brands.add(brand);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return brands;

    }

    public List<Brand> getBrands(BrandFilter brandFilter) {

        List<Brand> brands = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        String sql = "SELECT br.id, br.name, br.link_brand, br.description, br.status, br.created_at, br.updated_at, " +
                "COUNT(pr.id) AS product_count " +
                "FROM brand br " +
                "LEFT JOIN product pr ON br.id = pr.brand_id " +
                "WHERE 1=1 ";

        StringBuilder query = new StringBuilder(sql);

        // filter name
        if (brandFilter.getName() != null && !brandFilter.getName().isEmpty()) {
            query.append(" AND br.name LIKE ? ");
            params.add("%" + brandFilter.getName() + "%");
        }

        // filter status
        if (brandFilter.getStatus() != -1) {
            query.append(" AND br.status = ? ");
            params.add(brandFilter.getStatus());
        }else {

        }

        // GROUP BY
        query.append(" GROUP BY br.id, br.name, br.link_brand, br.description, br.status, br.created_at, br.updated_at ");

        // sort (giữ kiểu đơn giản)
        if (brandFilter.getSort() != null && !brandFilter.getSort().isEmpty()) {

            String sortField = "br.id";
            if (brandFilter.getSort().equals("name")) {
                sortField = "br.name";
            } else if (brandFilter.getSort().equals("created_at")) {
                sortField = "br.created_at";
            } else if (brandFilter.getSort().equals("product_count")) {
                sortField = "product_count";
            }

            String sortOrder = (brandFilter.getOrder() != null)
                    ? brandFilter.getOrder().name()
                    : "asc";

            query.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        }

        // pagination
        int offset = (brandFilter.getPage() - 1) * brandFilter.getLimit();
        query.append(" LIMIT ? OFFSET ? ");
        params.add(brandFilter.getLimit());
        params.add(offset);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Brand brand = new Brand(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("link_brand"),
                        rs.getString("description"),
                        rs.getInt("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );

                brand.setProductCount(rs.getInt("product_count"));

                brands.add(brand);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
//        System.out.println("SQL: " + query.toString());
//        System.out.println("Params: " + params);

        return brands;
    }

    public Brand getBrandByID(int brandid) {
        Brand brand = null;
        String sql = "select * from brand where id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, brandid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                brand = new Brand(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("link_brand"),
                        rs.getInt("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return brand;
    }

    public int getTotalBrand() {
        String sql = "SELECT COUNT(*) FROM brand";
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

    public List<String> getBrandName() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT name from brand";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                list.add(rs.getString("name"));
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;

    }

    public String getBrandName(int brandId) {
        String name = "";
        String sql = "SELECT name from brand where id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, brandId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                name = rs.getString("name");
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return name;

    }


        public boolean updateBrand(Brand brand) {
            String sql = "update brand set name = ?, status = ?,link_brand = ?,description = ?, updated_at = ? where id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, brand.getName());
                ps.setInt(2, brand.getIntStatus());
                ps.setString(3, brand.getLinkBrand());
                ps.setString(4, brand.getDescription());
                ps.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
                ps.setInt(6, brand.getId());
                System.out.println("SQL: " + sql);
                System.out.println(brand.getId());
                return ps.executeUpdate() == 1;
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
}
