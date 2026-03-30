package code.salecar.service.product;

import code.salecar.model.Image;
import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.dto.ProductItem;
import code.salecar.model.product.dto.ProductRating;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.dao.ProductDAO;
import code.salecar.model.Brand;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.Reviews;
import code.salecar.service.Image.ImageService;

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

    public ProductDetail getProductByID(int id) {

        Product product = productDAO.getProductByID(id);
        ProductDetail detail = new ProductDetail(product);
        if (detail == null) {
            return null;
        }

        //get img
        List<String> image = is.getImageProduct(detail.getId());
        image.add(is.getImage(Image.entityType.brand, detail.getBrandId()));
        detail.setImage(image);

        Brand brand = bs.getBrandByID(detail.getBrandId());
        if (brand != null) {
            detail.setBrandName(brand.getName());
            detail.setBrandLink(brand.getLinkBrand());
        }

        String categoryName = cs.getCategoryName(detail.getCategoryId());
        detail.setCategoryName(categoryName != null ? categoryName : "");

        // Rating
        List<Reviews> reviews = rs.getReviewsByID(detail.getId());
        ProductRating rating = new ProductRating(detail.getId());
        if (reviews != null && !reviews.isEmpty()) {
            detail.setReviews(reviews);
            detail.setAvgRating(caculateRates(reviews));
            addStar(reviews, rating);
        } else {
            detail.setReviews(new ArrayList<>());
            detail.setAvgRating(0);
        }
        detail.setRating(rating);


        return detail;
    }

    private void addStar(List<Reviews> reviews, ProductRating product) {
        for (Reviews review : reviews) {
            switch (review.getRating()) {
                case 1:
                    product.setOneStar(product.getOneStar() + 1);
                    break;
                case 2:
                    product.setTwoStar(product.getTwoStar() + 1);
                    break;
                case 3:
                    product.setThreeStar(product.getThreeStar() + 1);
                    break;
                case 4:
                    product.setFourStar(product.getFourStar() + 1);
                    break;
                case 5:
                    product.setFiveStar(product.getFiveStar() + 1);
                    break;

            }
        }
    }

    private double caculateRates(List<Reviews> reviews) {
        int sum = 0;
        for (Reviews r : reviews) {
            sum += r.getRating();
        }
        double avg = 0;
        if (sum > 0) {
            avg = (double) sum / (double) reviews.size();
        }
        return avg;
    }

    public int getTotalProduct(ProductFilter filter) {
        return productDAO.getTotalProduct(filter);
    }

    public List<ProductItem> getProductFilter(ProductFilter filter, int page, int limit) {
        List<ProductItem> product = productDAO.getProductFilter(filter, page, limit);
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

    private double caculateDiscount(double price, Discount discount) {

        if (discount.getValueType() == Discount.DiscountValueType.RATE) {
            return price * (1 - discount.getValue().doubleValue() / 100);
        }
        if (discount.getValueType() == Discount.DiscountValueType.AMOUNT) {
            return price - discount.getValue().doubleValue();
        }
        return price;
    }

    public List<ProductDetail> getRelatedProductMaterial(String byWith) {

        List<Integer> ids = productDAO.getRelatedProductMaterial(byWith);
        List<ProductDetail> products = new ArrayList<>();

        for (Integer id : ids) {
            ProductDetail p = getProductByID(id);

            if (p != null) {
                products.add(p);
            }
        }

        return products;
    }

    public List<ProductDetail> sortProducFilter(List<ProductDetail> favoritesProducts, ProductFilter filter) {

        if (filter.getCategories().isEmpty() &&
                filter.getBrands().isEmpty() && filter.getMaxPrice() != null &&
                !filter.isSortByNewestDiscount() && !filter.isSortByHighestDiscount()) {
            return favoritesProducts;
        }

        Stream<ProductDetail> stream = favoritesProducts.stream();

        // Keyword
        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            String keyword = filter.getKeyword().toLowerCase().trim();
            stream = stream.filter(p -> p.getName().toLowerCase().trim().contains(keyword));
        }

        // category
        if (!filter.getCategories().isEmpty() && !filter.getCategories().get(0).equals("all")) {
            stream = stream.filter(p -> filter.getCategories().contains(p.getCategoryName()));
        }

        // brand
        if (!filter.getBrands().isEmpty() && !filter.getBrands().get(0).equals("all")) {
            stream = stream.filter(p -> filter.getBrands().contains(p.getBrandName()));
        }

        //maxPrice
        if (filter.getMaxPrice() != null) {
            stream = stream.filter(p -> p.getPrice() <= filter.getMaxPrice().doubleValue());
        }


        List<ProductDetail> result = stream.collect(Collectors.toList());

//        if (filter.isSortByNewestDiscount()) {
//            result.sort((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()));
//        }
//        if (filter.isSortByHighestDiscount()) {
//            result.sort((a, b) -> Double.compare(b.getFinalPrice(), a.getFinalPrice()));
//        }
        return result;
    }

    public int getTotalScale() {
        return productDAO.getTotalScale();
    }

    public List<String> getScaleName() {
        return productDAO.getScaleName();
    }

    public BigDecimal getMaxPrice() {
        return productDAO.getMaxPrice();
    }

    public List<ProductItem> getProductNew() {
        return productDAO.getProductNew();
    }

    public List<ProductItem> getProductHot() {
        return productDAO.getProductHot();
    }

    public List<ProductDetail> getRelatedProductBrand(int brandId) {
        List<ProductItem> items = productDAO.getRelatedProductBrand(brandId);
        List<ProductDetail> details = new ArrayList<>();
        for (ProductItem item : items.subList(0, items.size() > 8 ? 8 : items.size())) {
            details.add(getProductByID(item.getId()));
        }

        return details;
    }

    public List<ProductItem> getProductForAdmin(ProductFilter productFilter, int page, int limit) {
        List<ProductItem> products = productDAO.getProductForAdmin(productFilter, page, limit);
        addMoreInformation(products);
        return products;
    }

    public void addMoreInformation(List<ProductItem> pi) {
        for (ProductItem productItem : pi) {
            String brand = bs.getBrandName(productItem.getBrandId());
            productItem.setBrandName(brand != null ? brand : "");

            String categoryName = cs.getCategoryName(productItem.getCategoryId());
            productItem.setCategoryName(categoryName != null ? categoryName : "");

            List<String> image = is.getImageProduct(productItem.getId());
            image.add(is.getImage(Image.entityType.brand, productItem.getBrandId()));
            productItem.setImage(image.get(0));

            List<Reviews> reviews = rs.getReviewsByID(productItem.getId());
            if (reviews != null && !reviews.isEmpty()) {
                productItem.setAvgRating(caculateRates(reviews));
            } else {
                productItem.setAvgRating(0);
            }
        }
    }

    public int getTotalProductForAdmin(ProductFilter productFilter) {
        return productDAO.getTotalProductForAdmin(productFilter);
    }

    public void updateBasicInfo(ProductDetail product) {
        productDAO.updateBasicInfo(product);
    }
}
