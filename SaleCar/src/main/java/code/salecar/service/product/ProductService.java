package code.salecar.service.product;

import code.salecar.model.product.dto.ProductDetail;
import code.salecar.model.product.dto.ProductItem;
import code.salecar.model.product.dto.ProductRating;
import code.salecar.model.product.filter.ProductFilter;
import code.salecar.dao.ProductDAO;
import code.salecar.model.Brand;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.Reviews;

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

    public ProductDetail getProductByID(int id) {

        Product product = productDAO.getProductByID(id);
        ProductDetail detail = new ProductDetail(product);
        if (detail == null) {
            return null;
        }

        Brand brand = bs.getBrandByID(detail.getProduct().getBrandId());
        if (brand != null) {
            detail.setBrandName(brand.getName());
            detail.setBrandLink(brand.getLinkband());

        }

        String categoryName = cs.getCategoryName(detail.getProduct().getCategoryId());
        detail.setCategoryName(categoryName != null ? categoryName : "");

        // Rating
        List<Reviews> reviews = rs.getReviewsByID(detail.getProduct().getId());
        ProductRating rating = new ProductRating(product.getId());
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
        for (ProductItem productItem : product) {
            String brand = bs.getBrandName(productItem.getBrandId());
            productItem.setBrandName(brand != null ? brand : "");

            String categoryName = cs.getCategoryName(productItem.getCategoryId());
            productItem.setCategoryName(categoryName != null ? categoryName : "");
        }

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
                filter.getBrands().isEmpty() && filter.getMaxPrice() == -1 &&
                !filter.isSortByNewestDiscount() && !filter.isSortByHighestDiscount()) {
            return favoritesProducts;
        }

        Stream<ProductDetail> stream = favoritesProducts.stream();

        // Keyword
        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty()) {
            String keyword = filter.getKeyword().toLowerCase().trim();
            stream = stream.filter(p -> p.getProduct().getName().toLowerCase().trim().contains(keyword));
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
        if (filter.getMaxPrice() != -1) {
            stream = stream.filter(p -> p.getProduct().getPrice() <= filter.getMaxPrice());
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
}
