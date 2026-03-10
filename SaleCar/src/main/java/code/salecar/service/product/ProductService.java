package code.salecar.service.product;

import code.salecar.controller.product.ProductFilter;
import code.salecar.dao.ProductDAO;
import code.salecar.dao.ReviewsDAO;
import code.salecar.model.Brand;
import code.salecar.model.Discount;
import code.salecar.model.Product;
import code.salecar.model.Reviews;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class ProductService {
    ProductDAO productDAO = new ProductDAO();
    BrandService bs = new BrandService();
    DiscountService ds = new DiscountService();
    ReviewsService rs = new ReviewsService();
    CategoryService cs = new CategoryService();

    public Product getProductByID(int id) {
        Product product = productDAO.getProductByID(id);
        Brand brand = bs.getBrandByID(product.getBrandid());
        product.setCategoryName(cs.getCategoryName(product.getCategoryid()));
        product.setBrandName(brand.getName());
        product.setBrandLink(brand.getLinkband());

        // Áp Giảm Giá Tổng (Không Phải Voucher)
        Discount discount = ds.getDiscount(product);

        if (discount != null) {
            product.setDiscount(discount);
            double finalPrice = caculateDiscount(product.getPrice(), discount);
            product.setFinalPrice(finalPrice);

            if (discount.getValueType() == Discount.DiscountValueType.AMOUNT) {
                int rate = product.getPrice() < discount.getValue().doubleValue() ? 0 : (int) (discount.getValue().doubleValue() * 100 / product.getPrice());
                product.setRatePrice(rate);
            } else {
                int rate = (int) discount.getValue().doubleValue();
                product.setRatePrice(rate);
            }

        } else {
            product.setFinalPrice(product.getPrice());
            product.setRatePrice(0);
        }

        // Rating
        List<Reviews> reviews = rs.getReviewsByID(product.getId());
        if (reviews != null) {
            product.setReviews(reviews);
            product.setAvgRating(caculateRates(reviews));
            addStar(reviews, product);
        } else {
            product.setReviews(new ArrayList<>());
            product.setAvgRating(0);
        }

        return product;
    }

    private void addStar(List<Reviews> reviews, Product product) {
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

    public List<Product> getProductFilter(ProductFilter filter, int page, int limit) {
        List<Product> products = productDAO.getProductFilter(filter);
        applyDiscount(products);
        sortDiscount(filter, products);
        int start = (page - 1) * limit;
        int end = Math.min(start + limit, products.size());

        if (start >= products.size()) {
            return new ArrayList<>();
        }

        return products.subList(start, end);
    }

    private void sortDiscount(ProductFilter filter, List<Product> products) {
        if (filter.isSortByHighest() && filter.isSortByNewest()) {
            products.sort((a, b) -> {

                double priceCompare =
                        Double.compare(b.getFinalPrice(), a.getFinalPrice());

                if (priceCompare != 0) {
                    return (int) priceCompare;
                }

                if (a.getDiscount() == null || b.getDiscount() == null) {
                    return 0;
                }

                return b.getDiscount().getStartAt()
                        .compareTo(a.getDiscount().getStartAt());
            });
        } else if (filter.isSortByHighest()) {
            products.sort((a, b) -> Double.compare(b.getRatePrice(), a.getRatePrice()));
        } else if (filter.isSortByNewest()) {
            products.sort((a, b) -> {
                if (a.getDiscount() == null && b.getDiscount() == null) return 0;
                if (a.getDiscount() == null) return 1;
                if (b.getDiscount() == null) return -1;

                return b.getDiscount().getStartAt()
                        .compareTo(a.getDiscount().getStartAt());
            });
        }
    }

    private void applyDiscount(List<Product> products) {
        for (Product product : products) {
            Discount discount = ds.getDiscount(product);
            if (discount != null) {
                product.setDiscount(discount);
                double finalPrice = caculateDiscount(product.getPrice(), discount);
                product.setFinalPrice(finalPrice);

                if (discount.getValueType() == Discount.DiscountValueType.AMOUNT) {
                    int rate = product.getPrice() < discount.getValue().doubleValue() ? 0 : (int) (discount.getValue().doubleValue() * 100 / product.getPrice());
                    product.setRatePrice(rate);
                } else {
                    int rate = (int) discount.getValue().doubleValue();
                    product.setRatePrice(rate);
                }

            } else {
                product.setFinalPrice(product.getPrice());
                product.setRatePrice(0);

            }
        }
    }

    private double caculateDiscount(double price, Discount discount) {

        if (discount.getValueType() == Discount.DiscountValueType.RATE) {
            return price * (1 - discount.getValue().doubleValue() / 100);
        }
        if (discount.getValueType() == Discount.DiscountValueType.AMOUNT) {
            return price - discount.getValue().doubleValue();
        }
        return price;
    }

    public List<Product> getRelatedProductMaterial(String byWith) {
        List<Integer> list = productDAO.getRelatedProductMaterial(byWith);
        List<Product> products = new ArrayList<>();
        for (Integer id : list) {
            Product product = getProductByID(id);
            products.add(product);
        }
        return products;
    }

    public List<Product> sortProducFilter(List<Product> favoritesProducts, ProductFilter filter) {

        if (filter.getCategories().isEmpty() &&
            filter.getBrands().isEmpty() && filter.getMaxPrice() == -1 &&
            !filter.isSortByNewest() && !filter.isSortByHighest() ) {
            return favoritesProducts;
        }

        Stream<Product> stream = favoritesProducts.stream();

        // Keyword
        if (filter.getKeyword() != null && !filter.getKeyword().isEmpty() ) {
            String keyword = filter.getKeyword().toLowerCase().trim();
            stream = stream.filter(p -> p.getName().toLowerCase().trim().contains(keyword));
        }

        // category
        if (!filter.getCategories().isEmpty() && !filter.getCategories().get(0).equals("all")) {
            stream = stream.filter(p -> filter.getCategories().contains(p.getCategoryName()));
        }

        // brand
        if (!filter.getBrands().isEmpty()  && !filter.getBrands().get(0).equals("all")) {
            stream = stream.filter(p -> filter.getBrands().contains(p.getBrandName()));
        }

        //maxPrice
        if (filter.getMaxPrice() != -1) {
            stream = stream.filter(p -> p.getPrice() <= filter.getMaxPrice());
        }


        List<Product> result = stream.collect(Collectors.toList());

        if (filter.isSortByNewest()) {
            result.sort((a, b) -> b.getCreateat().compareTo(a.getCreateat()));
        }
        if (filter.isSortByHighest()) {
            result.sort((a, b) -> Double.compare(b.getFinalPrice(), a.getFinalPrice()));
        }
        return result;
    }
}
