package code.salecar.dao;

import code.salecar.model.enumeration.Status;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.product.dto.ProductItemDTO;
import code.salecar.model.product.entity.ProductVariants;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.model.product.entity.Product;
import code.salecar.config.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ProductDAO {


    /**
     * Lấy danh sách ID sản phẩm theo BrandId.
     */
    public List<Long> getProductIdsByBrandId(int brandId) {
        List<Long> ids = new ArrayList<>();
        String sql = "SELECT id FROM product WHERE brand_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, brandId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ids.add(rs.getLong("id"));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ids;
    }

    /**
     * Lấy danh sách ID sản phẩm theo CategoryId.
     */
    public List<Long> getProductIdsByCategoryId(long categoryId) {
        List<Long> ids = new ArrayList<>();
        String sql = "SELECT id FROM product WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ids.add(rs.getLong("id"));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ids;
    }

    // Lấy danh sách sản phẩm mới nhất (dùng cho trang chủ)
    /**
     * Lấy sản phẩm mới — chỉ lấy product có tồn tại variant.
     */
    public List<ProductItemDTO> getProductNew() {
        List<ProductItemDTO> products = new ArrayList<>();
        String query = "select * from product pr where pr.status = 1 " +
                "and exists (select 1 from product_variants pv where pv.product_id = pr.id) " +
                "order by pr.created_at desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItemDTO p = new ProductItemDTO.Builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .price(rs.getDouble("price"))
                        .finalPrice(rs.getDouble("final_price"))
                        .discountPercent(rs.getDouble("discount_percent"))
                        .brandId(rs.getInt("brand_id"))
                        .categoryId(rs.getInt("category_id"))
                        .ratio(rs.getString("ratio"))
                        .build();
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;

    }

    /**
     * Lấy sản phẩm hot — chỉ lấy product có tồn tại variant.
     */
    public List<ProductItemDTO> getProductHot() {
        List<ProductItemDTO> products = new ArrayList<>();
        String query = "select * from product pr where pr.status = 1 " +
                "and exists (select 1 from product_variants pv where pv.product_id = pr.id) " +
                "order by pr.price desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItemDTO p = new ProductItemDTO.Builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .price(rs.getDouble("price"))
                        .finalPrice(rs.getDouble("final_price"))
                        .discountPercent(rs.getDouble("discount_percent"))
                        .brandId(rs.getInt("brand_id"))
                        .categoryId(rs.getInt("category_id"))
                        .ratio(rs.getString("ratio"))
                        .build();
                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }


    /**
     * Lấy sản phẩm khuyến mãi — chỉ lấy product có discount_percent > 0 và có variant.
     */
    public List<ProductItemDTO> getProductSale() {
        List<ProductItemDTO> products = new ArrayList<>();
        String query = "select * from product pr where pr.status = 1 " +
                "and pr.discount_percent > 0 " +
                "and exists (select 1 from product_variants pv where pv.product_id = pr.id) " +
                "order by pr.discount_percent desc limit 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItemDTO p = new ProductItemDTO.Builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .price(rs.getDouble("price"))
                        .finalPrice(rs.getDouble("final_price"))
                        .discountPercent(rs.getDouble("discount_percent"))
                        .brandId(rs.getInt("brand_id"))
                        .categoryId(rs.getInt("category_id"))
                        .ratio(rs.getString("ratio"))
                        .build();
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

        String sql = "select count(*) from product pr " +
                " join brand br on pr.brand_id = br.id " +
                " join category ct on pr.category_id = ct.id " +
                " where 1=1 " +
                " and exists (select 1 from product_variants pv where pv.product_id = pr.id) ";

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
    public List<ProductItemDTO> getProductFilter(ProductFilter filter, int page, int limit) {

        List<ProductItemDTO> products = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        String sql = "select pr.* from product pr " +
                " join brand br on pr.brand_id = br.id " +
                " join category ct on pr.category_id = ct.id " +
                " where 1=1 " +
                " and exists (select 1 from product_variants pv where pv.product_id = pr.id) ";

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
                ProductItemDTO p = new ProductItemDTO.Builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .price(rs.getDouble("price"))
                        .finalPrice(rs.getDouble("final_price"))
                        .discountPercent(rs.getDouble("discount_percent"))
                        .brandId(rs.getInt("brand_id"))
                        .categoryId(rs.getInt("category_id"))
                        .ratio(rs.getString("ratio"))
                        .build();


                products.add(p);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        System.out.println("Products found: " + products.size());
        return products;
    }


    //Lấy thông tin chi tiết của sản phẩm để hiển thị ở trang chi tiết sản phẩm
    public Product getProductByID(long id) {
        Product p = null;
        String query = "select * from product where id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p =  Product.builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .price(rs.getDouble("price"))
                        .finalPrice(rs.getDouble("final_price"))
                        .discountPercent(rs.getDouble("discount_percent"))
                        .brandId(rs.getInt("brand_id"))
                        .categoryId(rs.getInt("category_id"))
                        .ratio(rs.getString("ratio"))
                        .size(rs.getString("size"))
                        .material(rs.getString("material"))
                        .origin(rs.getString("origin"))
                        .description(rs.getString("description"))
                        .status(Status.fromCode(rs.getInt("status")))
                        .build();

                Timestamp tsc = rs.getTimestamp("created_at");
                LocalDateTime createdAt = (tsc != null) ? tsc.toLocalDateTime() : LocalDateTime.now();
                Timestamp tsu = rs.getTimestamp("updated_at");
                LocalDateTime updatedAt = (tsu != null) ? tsu.toLocalDateTime() : LocalDateTime.now();
                Timestamp tsd = rs.getTimestamp("discount_updated_at");
                LocalDateTime discountAt = (tsd != null) ? tsd.toLocalDateTime() : LocalDateTime.now();
                p.setCreatedAt(createdAt);
                p.setUpdatedAt(updatedAt);
                p.setDiscountUpdatedAt(discountAt);

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return p;
    }

    //Lấy danh sách ID sản phẩm liên quan cùng chất liệu (material) để hiển thị ở phần sản phẩm liên quan trong trang chi tiết sản phẩm
    /**
     * Lấy sản phẩm liên quan — chỉ lấy product có tồn tại variant.
     */
    public List<Integer> getRelatedProductMaterial(String byWith) {
        List<Integer> products = new ArrayList<>();
        String query = "select pr.id from product pr where pr.status = 1 " +
                " and pr.material = ? " +
                " and exists (select 1 from product_variants pv where pv.product_id = pr.id) " +
                " order by pr.created_at desc limit 4";
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
    public List<ProductItemDTO> getAllProducts() {
        List<ProductItemDTO> products = new ArrayList<>();
        String query = "select * from product ";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItemDTO product = new ProductItemDTO.Builder()
                        .id(rs.getInt("id"))
                        .price(rs.getDouble("price"))
                        .discountPercent(rs.getDouble("discount_percent"))
                        .brandId(rs.getInt("brand_id"))
                        .categoryId(rs.getInt("category_id"))
                        .createdAt(rs.getTimestamp("created_at").toLocalDateTime())
                        .build();
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
    public void updateFinalPrice(long id, double finalPrice, BigDecimal value, LocalDateTime updatedAt) {
        String query = "update product  " +
                " set final_price = ?, discount_percent = ?, updated_at = ?,discount_updated_at = ?  " +
                " where id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setDouble(1, finalPrice);
            ps.setBigDecimal(2, value);
            ps.setDate(3, new java.sql.Date(System.currentTimeMillis()));
            ps.setTimestamp(4, Timestamp.valueOf(updatedAt));
            ps.setLong(5, id);

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
    /**
     * Lấy sản phẩm liên quan cùng brand — chỉ lấy product có tồn tại variant.
     */
    public List<ProductItemDTO> getRelatedProductBrand(long brandId) {
        List<ProductItemDTO> products = new ArrayList<>();
        String query = "select pr.* from product pr where pr.brand_id = ? " +
                " and exists (select 1 from product_variants pv where pv.product_id = pr.id) ";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, brandId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductItemDTO product = new ProductItemDTO.Builder()
                        .id(rs.getInt("id"))
                        .build();


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
    public List<ProductItemDTO> getProductForAdmin(ProductFilter filter, int page, int limit) {
        List<ProductItemDTO> products = new ArrayList<>();
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
            query.append(" and pr.status = ? ");
            params.add(filter.getStatus());
        }

        if (filter.getStock() != null && !filter.getStock().isEmpty()) {
            switch (filter.getStock()) {
                case "high":
                    query.append(" and (SELECT COALESCE(SUM(inv.quantity), 0) FROM inventory inv WHERE inv.product_id = pr.id) > 50 ");
                    break;
                case "medium":
                    query.append(" and (SELECT COALESCE(SUM(inv.quantity), 0) FROM inventory inv WHERE inv.product_id = pr.id) BETWEEN 10 AND 50 ");
                    break;
                case "low":
                    query.append(" and (SELECT COALESCE(SUM(inv.quantity), 0) FROM inventory inv WHERE inv.product_id = pr.id) < 10 ");
                    break;
            }
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
                ProductItemDTO product = new ProductItemDTO.Builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .price(rs.getDouble("price"))
                        .finalPrice(rs.getDouble("final_price"))
                        .discountPercent(rs.getDouble("discount_percent"))
                        .brandId(rs.getInt("brand_id"))
                        .categoryId(rs.getInt("category_id"))
                        .status(Status.fromCode(rs.getInt("status")))
                        .createdAt(rs.getTimestamp("created_at").toLocalDateTime())
                        .updatedAt(rs.getTimestamp("updated_at").toLocalDateTime())
                        .build();
                products.add(product);
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
            query.append(" and pr.status = ? ");
            params.add(filter.getStatus());
        }

        if (filter.getStock() != null && !filter.getStock().isEmpty()) {
            switch (filter.getStock()) {
                case "high":
                    query.append(" and (SELECT COALESCE(SUM(inv.quantity), 0) FROM inventory inv WHERE inv.product_id = pr.id) > 50 ");
                    break;
                case "medium":
                    query.append(" and (SELECT COALESCE(SUM(inv.quantity), 0) FROM inventory inv WHERE inv.product_id = pr.id) BETWEEN 10 AND 50 ");
                    break;
                case "low":
                    query.append(" and (SELECT COALESCE(SUM(inv.quantity), 0) FROM inventory inv WHERE inv.product_id = pr.id) < 10 ");
                    break;
            }
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
    public void updateBasicInfo(ProductDetailDTO product) {
        String query = "update product  " +
                " set name = ?, category_id = ?, brand_id = ?,status = ?  " +
                " where id = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, product.getProduct().getName());
            ps.setLong(2, product.getCategory().getCategoryId());
            ps.setLong(3, product.getBrand().getBrandId());
            ps.setInt(4, product.getProduct().getStatus().getCode());
            ps.setLong(5, product.getProduct().getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    /**
     * Cập nhật toàn bộ thông tin sản phẩm (bao gồm thuộc tính, mô tả)
     */
    public void updateProductDetail(long productId, String name, int categoryId, int brandId,
                                     int status, String ratio, String size,
                                     String material, String origin, String description) {
        String query = "UPDATE product SET name = ?, category_id = ?, brand_id = ?, status = ?, " +
                "ratio = ?, size = ?, material = ?, origin = ?, description = ?, " +
                "updated_at = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, name);
            ps.setInt(2, categoryId);
            ps.setInt(3, brandId);
            ps.setInt(4, status);
            ps.setString(5, ratio);
            ps.setString(6, size);
            ps.setString(7, material);
            ps.setString(8, origin);
            ps.setString(9, description);
            ps.setTimestamp(10, new Timestamp(System.currentTimeMillis()));
            ps.setLong(11, productId);

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    //Thêm sản phẩm mới vào cơ sở dữ liệu và trả về ID của sản phẩm vừa được thêm
    public long insertProduct(ProductDetailDTO product) {

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

            ps.setString(1, product.getProduct().getName());
            ps.setDouble(2, product.getProduct().getPrice());
            ps.setDouble(3, product.getProduct().getFinalPrice());
            ps.setDouble(4, product.getProduct().getDiscountPercent());

            ps.setNull(5, java.sql.Types.TIMESTAMP);

            ps.setLong(6, product.getProduct().getBrandId());
            ps.setLong(7, product.getProduct().getCategoryId());

            ps.setString(8, product.getProduct().getDescription());
            ps.setString(9, product.getProduct().getRatio());
            ps.setString(10, product.getProduct().getSize());
            ps.setString(11, product.getProduct().getMaterial());
            ps.setString(12, product.getProduct().getOrigin());

            ps.setInt(13, product.getProduct().getStatus().getCode());

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
        String query = "INSERT INTO product_variants (product_id, name, price, sku, final_price) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, variant.getProductId());
            ps.setString(2, variant.getVariantName());
            ps.setBigDecimal(3, variant.getPrice());
            ps.setString(4, variant.getSku());
            // Nếu variant đã có finalPrice thì dùng, nếu không thì mặc định bằng price
            BigDecimal finalPrice = variant.getFinalPrice() != null ? variant.getFinalPrice() : variant.getPrice();
            ps.setBigDecimal(5, finalPrice);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Chỉ cập nhật trạng thái sản phẩm (không cần brand/category).
     * Dùng khi tự động set INACTIVE cho product không variant.
     */
    public void updateStatus(long productId, Status status) {
        String query = "UPDATE product SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, status.getCode());
            ps.setLong(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Xoá variant theo ID
     */
    public void deleteVariant(long variantId) {
        String sql = "DELETE FROM product_variants WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, variantId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Xóa sản phẩm và các bản ghi liên quan.
     * Xóa theo thứ tự: inventory, product_variants, product_images, reviews, discounts, product
     */
    public boolean deleteProduct(long productId) {
        String[] deleteQueries = {
                "DELETE FROM inventory WHERE product_id = ?",
                "DELETE FROM product_variants WHERE product_id = ?",
                "DELETE FROM product_images WHERE product_id = ?",
                "DELETE FROM reviews WHERE product_id = ?",
                "DELETE FROM discount WHERE entity_type = 'PRODUCT' AND entity_id = ?",
                "DELETE FROM product WHERE id = ?"
        };

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            for (String sql : deleteQueries) {
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setLong(1, productId);
                    ps.executeUpdate();
                }
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }
            }
            throw new RuntimeException("Error deleting product with id: " + productId, e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }
}
