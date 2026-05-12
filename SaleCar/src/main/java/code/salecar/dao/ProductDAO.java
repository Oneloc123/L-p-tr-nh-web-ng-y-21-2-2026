package code.salecar.dao;

import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.dto.ProductItem;
import code.salecar.model.product.entity.ProductVariants;
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


    // Lấy danh sách sản phẩm mới nhất (dùng cho trang chủ)
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

    //
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


    //Tổng số lượng sản phẩm theo filter (không phân trang)
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

    //Lấy danh sách sản phẩm theo filter và phân trang (dùng cho trang danh sách sản phẩm ở phần user)
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
//        System.out.println("SQL: " + query);
//        System.out.println("Params: " + params);
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


    //Lấy thông tin chi tiết của sản phẩm để hiển thị ở trang chi tiết sản phẩm
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

    //Lấy danh sách ID sản phẩm liên quan cùng chất liệu (material) để hiển thị ở phần sản phẩm liên quan trong trang chi tiết sản phẩm
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


    //Lấy tất cả sản phẩm (dùng để cập nhật giá sau khi có thông tin giảm giá mới nhất)
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

    //Cập nhật giá sau khi có thông tin giảm giá mới nhất (giá cuối cùng, phần trăm giảm giá, thời gian cập nhật)
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


    //Lấy tổng số lượng scale (tỉ lệ) của sản phẩm để làm tham số filter
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

    //Lấy tên các scale (tỉ lệ) của sản phẩm để làm tham số filter
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

    // Lấy  giá cao nhất của sản phẩm để làm tham số filter
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

    // Lấy các sản phẩm liên quan cùng thương hiệu
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

    //Lấy danh sách sản phẩm cho admin với filter và phân trang
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
                    query.append(" order by pr.created_at asc");
                    break;
                case CREATED_DESC:
                    query.append(" order by pr.created_at desc");
                    break;
            }
        } else {
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

    //Tổng danh sách sản phẩm cho admin với filter (không phân trang)
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
                    query.append(" order by pr.created_at asc");
                    break;
                case CREATED_DESC:
                    query.append(" order by pr.created_at desc");
                    break;
            }
        } else {
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

    //Cập nhật thông tin cơ bản của sản phẩm (tên, danh mục, thương hiệu, trạng thái)
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
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    //Thêm sản phẩm mới vào cơ sở dữ liệu và trả về ID của sản phẩm vừa được thêm
    public int insertProduct(ProductDetail product) {

        String query =
                "INSERT INTO product " +
                        "(" +
                        "name, " +
                        "price, " +
                        "final_price, " +
                        "discount_percent, " +
                        "discount_updated_at, " +
                        "brand_id, " +
                        "category_id, " +
                        "description, " +
                        "ratio, " +
                        "size, " +
                        "material, " +
                        "origin, " +
                        "status, " +
                        "created_at, " +
                        "updated_at" +
                        ") " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(
                        query,
                        Statement.RETURN_GENERATED_KEYS
                )
        ) {

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setDouble(3, product.getFinalPrice());
            ps.setDouble(4, product.getDiscountPercent());

            ps.setNull(5, java.sql.Types.TIMESTAMP);

            ps.setInt(6, product.getBrandId());
            ps.setInt(7, product.getCategoryId());

            ps.setString(8, product.getDescription());
            ps.setString(9, product.getRatio());
            ps.setString(10, product.getSize());
            ps.setString(11, product.getMaterial());
            ps.setString(12, product.getOrigin());

            ps.setInt(13, product.getStatus());

            Timestamp now = new Timestamp(System.currentTimeMillis());

            ps.setTimestamp(14, now);
            ps.setTimestamp(15, now);

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                return -1;
            }

            ResultSet rs = ps.getGeneratedKeys();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        return -1;
    }

    //
    public void insertVariant(ProductVariants variant) {
        String query = "INSERT INTO product_variants (product_id, name, price, sku) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, variant.getProductId());
            ps.setString(2, variant.getVariantName());
            ps.setBigDecimal(3, new BigDecimal(variant.getPrice()));
            ps.setString(4, variant.getSku());
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
