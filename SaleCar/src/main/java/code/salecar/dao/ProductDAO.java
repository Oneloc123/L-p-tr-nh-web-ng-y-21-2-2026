package code.salecar.dao;

import code.salecar.controller.product.ProductFilter;
import code.salecar.model.Product;
import code.salecar.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
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
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
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
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
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
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("meterial"),
                        rs.getString("orign"),
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


        StringBuilder query = new StringBuilder("select   count(*) from product pr  join brand br on pr.brand_id = br.id  join category ct on pr.category_id = ct.id  where 1=1 ");

        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            query.append(" and pr.name like ? ");
            params.add("%" + filter.getKeyword() + "%");
        }

        if (filter.getCategories() != null && filter.getCategories().size() > 0) {
            query.append(" and ct.name in (")
                    .append(String.join(",", Collections.nCopies(filter.getCategories().size(), "?")))
                    .append(") ");
            params.addAll(filter.getCategories());
        }

        if (filter.getBrands() != null && filter.getBrands().size() > 0) {
            query.append(" and br.name in (")
                    .append(String.join(",", Collections.nCopies(filter.getBrands().size(), "?")))
                    .append(") ");
            params.addAll(filter.getBrands());
        }

        if (filter.getMaxPrice() > 0) {
            query.append(" and pr.price <= ? ");
            params.add(filter.getMaxPrice());
        }





        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

//            int index = 1;
//            if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
//                ps.setString(index++, "%" + filter.getKeyword() + "%");
//            }
//            if (filter.getCategories() != null && filter.getCategories().size() > 0) {
//                for (String c : filter.getCategories()) {
//                    ps.setString(index++, c);
//                }
//            }
//            if (filter.getBrands() != null && filter.getBrands().size() > 0) {
//                for (String b : filter.getBrands()) {
//                    ps.setString(index++, b);
//                }
//            }
//
//            if (filter.getMaxPrice() > 0) {
//                ps.setDouble(index++, filter.getMaxPrice());
//            }
//
//
//            int offset = (page - 1) * limit;
//
//            ps.setInt(index++, limit);
//            ps.setInt(index, offset);

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i+1, params.get(i));
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

    public List<Product> getProductFilter(ProductFilter filter) {
        List<Product> products = new ArrayList<>();

        List<Object> params = new ArrayList<>();


        StringBuilder query = new StringBuilder("select distinct  pr.* from product pr  join brand br on pr.brand_id = br.id  join category ct on pr.category_id = ct.id  where 1=1 ");

        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            query.append(" and pr.name like ? ");
            params.add("%" + filter.getKeyword() + "%");
        }

        if (filter.getCategories() != null && filter.getCategories().size() > 0) {
            query.append(" and ct.name in (")
                    .append(String.join(",", Collections.nCopies(filter.getCategories().size(), "?")))
                    .append(") ");
            params.addAll(filter.getCategories());
        }

        if (filter.getBrands() != null && filter.getBrands().size() > 0) {
            query.append(" and br.name in (")
                    .append(String.join(",", Collections.nCopies(filter.getBrands().size(), "?")))
                    .append(") ");
            params.addAll(filter.getBrands());
        }

        if (filter.getMaxPrice() > 0) {
            query.append(" and pr.price <= ? ");
            params.add(filter.getMaxPrice());
        }




        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

//            int index = 1;
//            if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
//                ps.setString(index++, "%" + filter.getKeyword() + "%");
//            }
//            if (filter.getCategories() != null && filter.getCategories().size() > 0) {
//                for (String c : filter.getCategories()) {
//                    ps.setString(index++, c);
//                }
//            }
//            if (filter.getBrands() != null && filter.getBrands().size() > 0) {
//                for (String b : filter.getBrands()) {
//                    ps.setString(index++, b);
//                }
//            }
//
//            if (filter.getMaxPrice() > 0) {
//                ps.setDouble(index++, filter.getMaxPrice());
//            }
//
//
//            int offset = (page - 1) * limit;
//
//            ps.setInt(index++, limit);
//            ps.setInt(index, offset);

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i+1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("ratio")
                );
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return products;
    }
}
