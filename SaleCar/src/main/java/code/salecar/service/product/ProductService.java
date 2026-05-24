package code.salecar.service.product;

import code.salecar.dao.ProductVariantsDAO;
import code.salecar.model.Image;
import code.salecar.model.brand.BrandInfo;
import code.salecar.model.category.Category;
import code.salecar.model.category.CategoryInfo;
import code.salecar.model.enumeration.DiscountValueType;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.product.dto.ProductItemDTO;
import code.salecar.model.product.entity.*;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.dao.ProductDAO;
import code.salecar.model.brand.Brand;
import code.salecar.service.Image.ImageService;
import code.salecar.service.file.ActivityLogFileService;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class ProductService {
    ProductDAO productDAO = new ProductDAO();
    BrandService bs = new BrandService();
    DiscountService ds = new DiscountService();
    ReviewsService rs = new ReviewsService();
    CategoryService cs = new CategoryService();
    ImageService is = new ImageService();
    DiscountService discountService = new DiscountService();
    ProductVariantsService pvs = new ProductVariantsService();
    ActivityLogFileService ls = new ActivityLogFileService();
    ProductVariantsDAO  pvDAO = new ProductVariantsDAO();
    // Lấy chi tiết sản phẩm theo ID
    public ProductDetailDTO getProductByID(long id) {

        // 1. Lấy entity Product
        Product product = productDAO.getProductByID(id);
        long productId = product.getId();

        // 2. Lấy Brand và tạo BrandInfo
        Brand brand = bs.getBrandByID(product.getBrandId());
        BrandInfo brandInfo = brand != null
                ? BrandInfo.builder().id(brand.getId()).name(brand.getName()).link(brand.getLinkBrand()).logo(brand.getImage()).build()
                : null;

        // 3. Lấy Category và tạo CategoryInfo
        Category category = cs.getCategoryById(product.getCategoryId());
        CategoryInfo categoryInfo = category != null
                ? CategoryInfo.builder().id(category.getId()).name(category.getName()).build()
                : null;

//         4. Lấy danh sách ảnh (chỉ URL)
        List<String> images = is.getImageProduct(productId);

//         5. Lấy thông tin tồn kho và đã bán
//        ProductSalesInfo inventory = InventoryService.findByProductId(productId);
//        ProductSalesInfo salesInfo = new ProductSalesInfo(
//                inventory != null ? inventory.getQuantity() : 0,
//                inventory != null ? inventory.getSoldQuantity() : 0
//        );

//         6. Lấy discount đang active (nếu có)
        Discount discount = ds.findActiveByProductId(productId);
        DiscountInfo discountInfo = null;
        if (discount != null) {
            discountInfo = DiscountInfo.builder()
                    .discountId(discount.getId())
                    .name(discount.getName())
                    .discountType(discount.getValueType())
                    .value(discount.getValue())
                    .startAt(discount.getStartAt())
                    .endAt(discount.getEndAt())
                    .build();
        }

        // 7. Lấy danh sách review và map sang ReviewSummary
        List<Review> reviews = rs.getReviewsByID(productId);
        List<ReviewSummary> reviewSummaries = reviews.stream()
                .map(r -> new ReviewSummary(
                        r.getRating(),
                        r.getComment(),
                        r.getUserName(),
                        r.getAvatar(),
                        r.getCreatedAt()
                ))
                .collect(Collectors.toList());

        // 8. Tính phân bố rating (từ danh sách review)
        ProductRatingDistribution ratingDist = calculateRatingDistribution(reviews);

        // 9. Lấy product vảiant
        List<ProductVariants> variants = pvs.getVariantById(productId);

        //10. Log
        List<ActivityLog> activityLog = ls.readLogs(productId);

        // 10. Dùng Builder để tạo ProductDetailDTO
        return ProductDetailDTO.builder()
                .product(product)
                .brand(brandInfo)
                .category(categoryInfo)
                .images(images)
//                .salesInfo(salesInfo)
                .activeDiscount(discountInfo)
                .reviews(reviewSummaries)
                .ratingDist(ratingDist)
                .variants(variants)
                .activityLogs(activityLog)
                .build();

    }

    // Tinh toán phân bố rating (số lượng đánh giá 1 sao, 2 sao, ..., 5 sao)
    private ProductRatingDistribution calculateRatingDistribution(List<Review> reviews) {
        int one = 0, two = 0, three = 0, four = 0, five = 0;
        for (Review r : reviews) {
            switch (r.getRating()) {
                case 1:
                    one++;
                    break;
                case 2:
                    two++;
                    break;
                case 3:
                    three++;
                    break;
                case 4:
                    four++;
                    break;
                case 5:
                    five++;
                    break;
            }
        }
        return ProductRatingDistribution.builder()
                .oneStar(one).twoStar(two).threeStar(three).fourStar(four).fiveStar(five)
                .build();
    }

    // Tính điểm trung bình của các đánh giá
    private double caculateRates(List<Review> reviews) {
        int sum = 0;
        for (Review r : reviews) {
            sum += r.getRating();
        }
        double avg = 0;
        if (sum > 0) {
            avg = (double) sum / (double) reviews.size();
        }
        return avg;
    }

    // Tổng số sản phẩm theo bộ lọc
    public int getTotalProduct(ProductFilter filter) {
        return productDAO.getTotalProduct(filter);
    }

    // Lấy danh sách sản phẩm theo bộ lọc và phân trang
    public List<ProductItemDTO> getProductFilter(ProductFilter filter, int page, int limit) {
        List<ProductItemDTO> product = productDAO.getProductFilter(filter, page, limit);
        addMoreInformation(product);
        return product;
    }

//    private void sortDiscount(ProductFilter filter, List<Product> products) {
//        if (filter.isSortByHighestDiscount() && filter.isSortByNewestDiscount()) {
//            products.sort((a, b) -> {
//
//                double priceCompare =
//                        Double.compare(b.getFinalPrice(), a.getFinalPrice());
//
//                if (priceCompare != 0) {
//                    return (int) priceCompare;
//                }
//
//                if (a.getDiscount() == null || b.getDiscount() == null) {
//                    return 0;
//                }
//
//                return b.getDiscount().getStartAt()
//                        .compareTo(a.getDiscount().getStartAt());
//            });
//        } else if (filter.isSortByHighestDiscount()) {
//            products.sort((a, b) -> Double.compare(b.getRatePrice(), a.getRatePrice()));
//        } else if (filter.isSortByNewestDiscount()) {
//            products.sort((a, b) -> {
//                if (a.getDiscount() == null && b.getDiscount() == null) return 0;
//                if (a.getDiscount() == null) return 1;
//                if (b.getDiscount() == null) return -1;
//
//                return b.getDiscount().getStartAt()
//                        .compareTo(a.getDiscount().getStartAt());
//            });
//        }
//    }

//    private void applyDiscount(List<Product> products) {
//        for (Product product : products) {
//            Discount discount = ds.getDiscount(product);
//            if (discount != null) {
//                product.setDiscount(discount);
//                double finalPrice = caculateDiscount(product.getPrice(), discount);
//                product.setFinalPrice(finalPrice);
//
//                if (discount.getValueType() == Discount.DiscountValueType.AMOUNT) {
//                    int rate = product.getPrice() < discount.getValue().doubleValue() ? 0 : (int) (discount.getValue().doubleValue() * 100 / product.getPrice());
//                    product.setRatePrice(rate);
//                } else {
//                    int rate = (int) discount.getValue().doubleValue();
//                    product.setRatePrice(rate);
//                }
//
//            } else {
//                product.setFinalPrice(product.getPrice());
//                product.setRatePrice(0);
//
//            }
//        }
//    }

    //
    private double caculateDiscount(double price, Discount discount) {

        if (discount.getValueType() == DiscountValueType.PERCENT) {
            return price * (1 - discount.getValue().doubleValue() / 100);
        }
        if (discount.getValueType() == DiscountValueType.AMOUNT) {
            return price - discount.getValue().doubleValue();
        }
        return price;
    }

    //
    public List<ProductDetailDTO> getRelatedProductMaterial(String byWith) {

        List<Integer> ids = productDAO.getRelatedProductMaterial(byWith);
        List<ProductDetailDTO> products = new ArrayList<>();

        for (Integer id : ids) {
            ProductDetailDTO p = getProductByID(id);

            if (p != null) {
                products.add(p);
            }
        }

        return products;
    }

    // Lấy danh sách sản phẩm yêu thích của người dùng theo bộ lọc và phân trang
    public List<ProductDetailDTO> sortProducFilter(List<ProductDetailDTO> favoritesProducts, ProductFilter filter) {

        if (filter.getCategories().isEmpty() &&
                filter.getBrands().isEmpty() && filter.getMaxPrice() != null &&
                !filter.isSortByNewestDiscount() && !filter.isSortByHighestDiscount()) {
            return favoritesProducts;
        }

        Stream<ProductDetailDTO> stream = favoritesProducts.stream();

        // Keyword
        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            String keyword = filter.getKeyword().toLowerCase().trim();
            stream = stream.filter(p -> p.getProduct().getName().toLowerCase().trim().contains(keyword));
        }

        // category
        if (!filter.getCategories().isEmpty() && !filter.getCategories().get(0).equals("all")) {
            stream = stream.filter(p -> filter.getCategories().contains(p.getCategory().getName()));
        }

        // brand
        if (!filter.getBrands().isEmpty() && !filter.getBrands().get(0).equals("all")) {
            stream = stream.filter(p -> filter.getBrands().contains(p.getBrand().getName()));
        }

        //maxPrice
        if (filter.getMaxPrice() != null) {
            stream = stream.filter(p -> p.getProduct().getPrice() <= filter.getMaxPrice().doubleValue());
        }


        List<ProductDetailDTO> result = stream.collect(Collectors.toList());

//        if (filter.isSortByNewestDiscount()) {
//            result.sort((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()));
//        }
//        if (filter.isSortByHighestDiscount()) {
//            result.sort((a, b) -> Double.compare(b.getFinalPrice(), a.getFinalPrice()));
//        }
        return result;
    }

    //
    public int getTotalScale() {
        return productDAO.getTotalScale();
    }

    //
    public List<String> getScaleName() {
        return productDAO.getScaleName();
    }

    //
    public BigDecimal getMaxPrice() {
        return productDAO.getMaxPrice();
    }

    //
    public List<ProductItemDTO> getProductNew() {
        return productDAO.getProductNew();
    }

    //
    public List<ProductItemDTO> getProductHot() {
        return productDAO.getProductHot();
    }

    //
    public List<ProductDetailDTO> getRelatedProductBrand(long brandId) {
        List<ProductItemDTO> items = productDAO.getRelatedProductBrand(brandId);
        List<ProductDetailDTO> details = new ArrayList<>();
        for (ProductItemDTO item : items.subList(0, items.size() > 8 ? 8 : items.size())) {
            details.add(getProductByID(item.getId()));
        }

        return details;
    }

    //
    public List<ProductItemDTO> getProductForAdmin(ProductFilter productFilter, int page, int limit) {
        List<ProductItemDTO> products = productDAO.getProductForAdmin(productFilter, page, limit);
        addMoreInformation(products);
        return products;
    }

    //
    public void addMoreInformation(List<ProductItemDTO> pi) {
        for (ProductItemDTO productItemDTO : pi) {
            String brand = bs.getBrandName(productItemDTO.getBrandId());
            productItemDTO.setBrandName(brand != null ? brand : "");

            String categoryName = cs.getCategoryName(productItemDTO.getCategoryId());
            productItemDTO.setCategoryName(categoryName != null ? categoryName : "");

            List<String> image = is.getImageProduct(productItemDTO.getId());
            image.add(is.getImage(Image.entityType.product, productItemDTO.getId()));
            productItemDTO.setImage(image.get(0));

            List<Review> reviews = rs.getReviewsByID(productItemDTO.getId());
            if (reviews != null && !reviews.isEmpty()) {
                productItemDTO.setAvgRating(caculateRates(reviews));
            } else {
                productItemDTO.setAvgRating(0);
            }

            productItemDTO.setQuantity(pvDAO.getQuantityById(productItemDTO.getId()));
        }
    }

    //
    public int getTotalProductForAdmin(ProductFilter productFilter) {
        return productDAO.getTotalProductForAdmin(productFilter);
    }

    //
    public void updateBasicInfo(ProductDetailDTO product) {
        productDAO.updateBasicInfo(product);
    }

    /**
     * Xóa sản phẩm theo ID
     * @return true nếu xóa thành công
     */
    public boolean deleteProduct(long productId) {
        productDAO.deleteProduct(productId);
        return true;
    }

    /* Tạo sản phẩm mới
    1. Gán giá: Lấy giá của màu sắc/phiên bản đầu tiên gán vào sản phẩm chính (Đây là cách làm đúng để hiển thị giá "Từ..." trên trang danh sách).
    2. Lưu sản phẩm chính: Gọi insertProduct để tạo bản ghi trong bảng product và lấy về productId.
    3. Lưu biến thể: Dùng vòng lặp for để gán productId vào từng biến thể và lưu vào bảng product_variants.
    4. Tải ảnh & Khuyến mãi: Sau khi Service trả về productId, Controller (product_create.java) sẽ tiếp tục lưu ảnh vào bảng product_images và tạo khuyến mãi nếu có.
     */
    public long createProduct(ProductDetailDTO productDTO) {
        Product p = productDTO.getProduct();

        // 1. Lấy giá từ biến thể đầu tiên gán cho sản phẩm chính để hiển thị
        if (productDTO.getVariants() != null && !productDTO.getVariants().isEmpty()) {
            double basePrice = productDTO.getVariants().get(0).getPrice().doubleValue();
            p.setPrice(basePrice);

            // Tính toán Final Price dựa trên Discount Percent
            double discount = p.getDiscountPercent();
            double finalPrice = basePrice * (100 - discount) / 100;
            p.setFinalPrice(finalPrice);
        }

        // 2. Lưu thông tin sản phẩm chính
        long productId = productDAO.insertProduct(productDTO);

        // 3. Nếu lưu sản phẩm thành công, lưu tiếp các biến thể
        if (productId > 0) {
            for (ProductVariants variant : productDTO.getVariants()) {
                variant.setProductId(productId);
                productDAO.insertVariant(variant);
            }
        }

        return productId;
    }
}
