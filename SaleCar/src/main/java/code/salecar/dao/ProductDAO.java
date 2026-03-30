package code.salecar.dao;

import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.dto.ProductItem;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.model.product.entity.Product;
import code.salecar.utils.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.sql.Date;
import java.util.List;

public class ProductDAO {


    //Home
    public List<ProductItem> getProductNew() {
        List<ProductItem> products = new ArrayList<>();
        String query = "select * from product where status = 1 order by created_at desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItem p = new ProductItem(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getDouble("discount_percent"),
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

    //Home
    public List<ProductItem> getProductHot() {
        List<ProductItem> products = new ArrayList<>();
        String query = "select * from product where status = 1 order by price desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItem p = new ProductItem(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getDouble("discount_percent"),
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


    //Products
    public int getTotalProduct(ProductFilter filter) {

        List<Object> params = new ArrayList<>();

        String sql = "select   count(*) from product pr  " +
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

        if (filter.getScale() != null && !filter.getScale().isEmpty()) {
            query.append(" and pr.ratio in (")
                    .append(String.join(",", Collections.nCopies(filter.getScale().size(), "?")))
                    .append(") ");
            params.addAll(filter.getScale());
        }

        if (filter.getMaxPrice() != null) {
            query.append(" and pr.final_price <= ? ");
            params.add(filter.getMaxPrice().doubleValue());
        }
        if (filter.getMinPrice() != null) {
            query.append(" and pr.final_price >= ? ");
            params.add(filter.getMinPrice().doubleValue());
        }


        if (filter.getSortBy() != null) {
            switch (filter.getSortBy()) {
                case PRICE_DESC:
                    query.append(" order by pr.price desc");
                    break;
                case PRICE_ASC:
                    query.append(" order by pr.price asc");
                    break;
                case NEWEST:
                    query.append(" order by pr.created_at desc");
                    break;
            }
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

    //Produtcs
    public List<ProductItem> getProductFilter(ProductFilter filter, int page, int limit) {

        List<ProductItem> products = new ArrayList<>();
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

        if (filter.getScale() != null && !filter.getScale().isEmpty()) {
            query.append(" and pr.ratio in (")
                    .append(String.join(",", Collections.nCopies(filter.getScale().size(), "?")))
                    .append(") ");
            params.addAll(filter.getScale());
        }

        if (filter.getMaxPrice() != null) {
            query.append(" and pr.final_price <= ? ");
            params.add(filter.getMaxPrice().doubleValue());
        }
        if (filter.getMinPrice() != null) {
            query.append(" and pr.final_price >= ? ");
            params.add(filter.getMinPrice().doubleValue());
        }


        if (filter.getSortBy() != null) {
            switch (filter.getSortBy()) {
                case PRICE_DESC:
                    query.append(" order by pr.price desc");
                    break;
                case PRICE_ASC:
                    query.append(" order by pr.price asc");
                    break;
                case NEWEST:
                    query.append(" order by pr.created_at desc");
                    break;
            }
        }


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
                ProductItem p = new ProductItem(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getDouble("discount_percent"),
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


    //Detail
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
                        rs.getDouble("discount_percent"),
                        rs.getDate("discount_updated_at"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("ratio"),
                        rs.getString("size"),
                        rs.getString("material"),
                        rs.getString("origin"),
                        rs.getInt("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return p;
    }

    //Detail
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


    //Discount
    public List<ProductItem> getAllProducts() {
        List<ProductItem> products = new ArrayList<>();
        String query = "select * from product ";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItem product = new ProductItem(
                        rs.getInt("id"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getDouble("discount_percent"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getDate("created_at")
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

    //Discount
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
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    //Scale
    public int getTotalScale() {
        String query = "SELECT COUNT(DISTINCT ratio) AS total_ratio FROM product;";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_ratio");
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return 0;
    }

    public List<String> getScaleName() {
        List<String> scaleName = new ArrayList<>();
        String query = "SELECT DISTINCT ratio FROM product;";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                scaleName.add(rs.getString(1));
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return scaleName;
    }

    public BigDecimal getMaxPrice() {
        String query = "SELECT MAX(final_price) AS max_final_price FROM product;";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return BigDecimal.ZERO;
    }

    public List<ProductItem> getRelatedProductBrand(int brandId) {
        List<ProductItem> products = new ArrayList<>();
        String query = "select * from product where brand_id = ? ";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, brandId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItem product = new ProductItem(
                        rs.getInt("id")
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

    public List<ProductItem> getProductForAdmin(ProductFilter filter, int page, int limit) {
        List<ProductItem> products = new ArrayList<>();
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

        if (filter.getCategory() != null && !filter.getCategory().isEmpty()) {
            query.append(" and ct.id in (")
                    .append(String.join(",", Collections.nCopies(filter.getCategory().size(), "?")))
                    .append(") ");
            params.addAll(filter.getCategory());
        }

        if (filter.getBrand() != null && !filter.getBrand().isEmpty()) {
            query.append(" and br.id in (")
                    .append(String.join(",", Collections.nCopies(filter.getBrand().size(), "?")))
                    .append(") ");
            params.addAll(filter.getBrand());
        }

        if (filter.getStatus() != -1) {
            query.append(" and pr.status like ? ");
            params.add("%" + filter.getStatus() + "%");
        }

        if (filter.getStock() != null && !filter.getStock().isEmpty()) {
            query.append(" and pr.stock like ? ");
            params.add("%" + filter.getStock() + "%");
        }


        if (filter.getMaxPrice() != null) {
            query.append(" and pr.final_price <= ? ");
            params.add(filter.getMaxPrice().doubleValue());
        }
        if (filter.getMinPrice() != null) {
            query.append(" and pr.final_price >= ? ");
            params.add(filter.getMinPrice().doubleValue());
        }
        if (filter.getFromDate() != null) {
            query.append(" and pr.updated_at >= ? ");
            params.add(filter.getFromDate());
        }
        if (filter.getToDate() != null) {
            query.append(" and pr.updated_at <= ? ");
            params.add(filter.getToDate());
        }
        if (filter.getSortBy() != null) {
            switch (filter.getSortBy()) {
                case PRICE_DESC:
                    query.append(" order by pr.price desc");
                    break;
                case PRICE_ASC:
                    query.append(" order by pr.price asc");
                    break;
                case NAME_ASC:
                    query.append(" order by pr.name asc");
                    break;
                case NAME_DESC:
                    query.append(" order by pr.name desc");
                    break;
                case CREATED_ASC:
                    query.append(" order by created_at asc");
                    break;
                case CREATED_DESC:
                    query.append(" order by created_at desc");
                    break;
            }
        }else {
            query.append(" order by pr.id asc");
        }


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
                ProductItem p = new ProductItem(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("final_price"),
                        rs.getDouble("discount_percent"),
                        rs.getInt("brand_id"),
                        rs.getInt("category_id"),
                        rs.getInt("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );


                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        System.out.println("Products found: " + products.size());
        return products;
    }

    public int getTotalProductForAdmin(ProductFilter filter) {
        List<Object> params = new ArrayList<>();

        String sql = "select   count(*) from product pr  " +
                " join brand br on pr.brand_id = br.id  " +
                " join category ct on pr.category_id = ct.id " +
                " where 1=1 ";

        StringBuilder query = new StringBuilder(sql);

        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            query.append(" and pr.name like ? ");
            params.add("%" + filter.getKeyword() + "%");
        }

        if (filter.getCategory() != null && !filter.getCategory().isEmpty()) {
            query.append(" and ct.id in (")
                    .append(String.join(",", Collections.nCopies(filter.getCategory().size(), "?")))
                    .append(") ");
            params.addAll(filter.getCategory());
        }

        if (filter.getBrand() != null && !filter.getBrand().isEmpty()) {
            query.append(" and br.id in (")
                    .append(String.join(",", Collections.nCopies(filter.getBrand().size(), "?")))
                    .append(") ");
            params.addAll(filter.getBrand());
        }

        if (filter.getStatus() != -1) {
            query.append(" and pr.status like ? ");
            params.add("%" + filter.getStatus() + "%");
        }

        if (filter.getStock() != null && !filter.getStock().isEmpty()) {
            query.append(" and pr.stock like ? ");
            params.add("%" + filter.getStock() + "%");
        }


        if (filter.getMaxPrice() != null) {
            query.append(" and pr.final_price <= ? ");
            params.add(filter.getMaxPrice().doubleValue());
        }
        if (filter.getMinPrice() != null) {
            query.append(" and pr.final_price >= ? ");
            params.add(filter.getMinPrice().doubleValue());
        }
        if (filter.getFromDate() != null) {
            query.append(" and pr.updated_at >= ? ");
            params.add(filter.getFromDate());
        }
        if (filter.getToDate() != null) {
            query.append(" and pr.updated_at <= ? ");
            params.add(filter.getToDate());
        }
        if (filter.getSortBy() != null) {
            switch (filter.getSortBy()) {
                case PRICE_DESC:
                    query.append(" order by pr.price desc");
                    break;
                case PRICE_ASC:
                    query.append(" order by pr.price asc");
                    break;
                case NAME_ASC:
                    query.append(" order by pr.name asc");
                    break;
                case NAME_DESC:
                    query.append(" order by pr.name desc");
                    break;
                case CREATED_ASC:
                    query.append(" order by created_at asc");
                    break;
                case CREATED_DESC:
                    query.append(" order by created_at desc");
                    break;
            }
        }else {
            query.append(" order by pr.id asc");
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
            throw new RuntimeException(e);
        }
        return 0;
    }

    public void updateBasicInfo(ProductDetail product) {
        String query = "update product  " +
                " set name = ?, category_id = ?, brand_id = ?,status = ?  " +
                " where id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getCategoryId());
            ps.setInt(3, product.getBrandId());
            ps.setInt(4, product.getStatus());
            ps.setInt(5, product.getId());

            ps.executeUpdate();
            System.out.println("Product updated ++++++++++++++++++++");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
