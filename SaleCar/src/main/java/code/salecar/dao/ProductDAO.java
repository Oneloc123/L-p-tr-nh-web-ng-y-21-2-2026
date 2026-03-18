package code.salecar.dao;

import code.salecar.controller.product.ProductFilter;
import code.salecar.model.Product;
import code.salecar.utils.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.sql.Date;
import java.util.List;
import java.util.logging.Filter;

public class ProductDAO {

    public List<Product> getProductNew() {
        List<Product> products = new ArrayList<>();
        String query = "select * from product where status = 1 order by created_at desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("material"),
                        rs.getString("origin"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;

    }

    public Product getProductByID(int id) {
        Product p = null;
        String query = "select * from product where id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("material"),
                        rs.getString("origin"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return p;
    }

    public List<Product> getProductHot() {
        List<Product> products = new ArrayList<>();
        String query = "select * from product where status = 1 order by price desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("material"),
                        rs.getString("origin"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public int getTotalProduct(ProductFilter filter) {

        List<Object> params = new ArrayList<>();

        String sql = "select  count(*) from product pr  " +
                " join brand br on pr.brand_id = br.id  " +
                " join category ct on pr.category_id = ct.id " +
                " where 1=1 ";

        StringBuilder query = new StringBuilder(sql);

        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            query.append(" and pr.name like ? ");
            params.add("%" + filter.getKeyword() + "%");
        }

        if (filter.getCategories() != null && !filter.getCategories().isEmpty()) {
            query.append(" and ct.name in (")
                    .append(String.join(",", Collections.nCopies(filter.getCategories().size(), "?")))
                    .append(") ");
            params.addAll(filter.getCategories());
        }

        if (filter.getBrands() != null && !filter.getBrands().isEmpty()) {
            query.append(" and br.name in (")
                    .append(String.join(",", Collections.nCopies(filter.getBrands().size(), "?")))
                    .append(") ");
            params.addAll(filter.getBrands());
        }

        if (filter.getModelScale() != null && !filter.getModelScale().isEmpty()) {
            query.append(" and pr.ratio in (")
                    .append(String.join(",", Collections.nCopies(filter.getModelScale().size(), "?")))
                    .append(") ");
            params.addAll(filter.getModelScale());
        }

        if (filter.getMaxPrice() > 0) {
            query.append(" and pr.final_price <= ? ");
            params.add(filter.getMaxPrice());
        }
        if (filter.getMinPrice() > 0) {
            query.append(" and pr.final_price >= ? ");
            params.add(filter.getMinPrice());
        }



        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> getProductFilter(ProductFilter filter, int page, int limit) {

        List<Product> products = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        String sql = "select   pr.* from product pr  " +
                " join brand br on pr.brand_id = br.id  " +
                " join category ct on pr.category_id = ct.id " +
                " where 1=1 ";

        StringBuilder query = new StringBuilder(sql);

        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            query.append(" and pr.name like ? ");
            params.add("%" + filter.getKeyword() + "%");
        }

        if (filter.getCategories() != null && !filter.getCategories().isEmpty()) {
            query.append(" and ct.name in (")
                    .append(String.join(",", Collections.nCopies(filter.getCategories().size(), "?")))
                    .append(") ");
            params.addAll(filter.getCategories());
        }

        if (filter.getBrands() != null && !filter.getBrands().isEmpty()) {
            query.append(" and br.name in (")
                    .append(String.join(",", Collections.nCopies(filter.getBrands().size(), "?")))
                    .append(") ");
            params.addAll(filter.getBrands());
        }

        if (filter.getModelScale() != null && !filter.getModelScale().isEmpty()) {
            query.append(" and pr.ratio in (")
                    .append(String.join(",", Collections.nCopies(filter.getModelScale().size(), "?")))
                    .append(") ");
            params.addAll(filter.getModelScale());
        }

        if (filter.getMaxPrice() > 0) {
            query.append(" and pr.final_price <= ? ");
            params.add(filter.getMaxPrice());
        }
        if (filter.getMinPrice() > 0) {
            query.append(" and pr.final_price >= ? ");
            params.add(filter.getMinPrice());
        }


        query.append(" order by pr.id desc");


        int offset = (page - 1) * limit;

        query.append("  limit  ? offset  ? ");
        params.add(limit);
        params.add(offset);
        System.out.println("SQL: " + query);
        System.out.println("Params: " + params);
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("ratio")
                );

                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        System.out.println("Products found: " + products.size());
        return products;
    }

    public List<Integer> getRelatedProductMaterial(String byWith) {
        List<Integer> products = new ArrayList<>();
        String query = "select * from product where  status = 1 " +
                " and  material = ? " +
                " order by created_at desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, byWith);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int p = rs.getInt("id");
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "select * from product ";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getBoolean("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );

                products.add(product);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public void updateFinalPrice(int id, double finalPrice, BigDecimal value, Date updatedAt) {
        String query = "update product  " +
                " set final_price = ?, discount_percent = ?, updated_at = ?,discount_updated_at = ?  " +
                " where id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setDouble(1, finalPrice);
            ps.setBigDecimal(2, value);
            ps.setDate(3, new java.sql.Date(System.currentTimeMillis()));
            ps.setDate(4, updatedAt);
            ps.setInt(5, id);

            ps.executeUpdate();
            System.out.println(ps.executeUpdate());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Product getProductByBrand(int entityId) {
        Product p = null;
        String query = "select * from product pr join brand br on pr.brand_id = br.id where br.id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, entityId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("material"),
                        rs.getString("origin"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );


            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return p;

    }

    public Product getProductByCategory(int entityId) {
        Product p = null;
        String query = "select * from product pr join category ct on pr.category_id = ct.id where ct.id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, entityId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("material"),
                        rs.getString("origin"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return p;
    }
}
