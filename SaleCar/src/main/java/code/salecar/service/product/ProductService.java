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

public class ProductService {
    ProductDAO productDAO = new ProductDAO();
    BrandService bs = new BrandService();
    DiscountService ds = new DiscountService();
    ReviewsService rs = new ReviewsService();


    public Product getProductByID(int id) {
        Product product = productDAO.getProductByID(id);
        Brand brand = bs.getBrandByID(product.getBrandid());
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
        }else {
            product.setReviews(new ArrayList<>());
            product.setAvgRating(0);
        }

        return product;
    }

    private double caculateRates(List<Reviews> reviews) {
        int sum = 0;
        for (Reviews r : reviews) {
            sum += r.getRating();
        }
        return (double) sum / (double) reviews.size();
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


}
