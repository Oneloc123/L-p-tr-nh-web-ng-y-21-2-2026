package code.salecar.service.product;

import code.salecar.dao.ProductDAO;
import code.salecar.model.Brand;
import code.salecar.model.Discount;
import code.salecar.model.Product;

import java.util.List;

public class ProductService {
    ProductDAO productDAO = new ProductDAO();
    BrandService bs = new BrandService();
    DiscountService ds = new DiscountService();

    public Product getProductByID(int id) {
        Product product = productDAO.getProductByID(id);
        Brand brand = bs.getBrandByID(product.getBrandid());
        product.setBrandName(brand.getName());

        Discount discount = ds.getDiscount(product);

        if (discount != null) {
            product.setDiscount(discount);
            double finalPrice = caculateDiscount(product.getPrice(), discount);
            product.setFinalPrice(finalPrice);
        }else {
            product.setFinalPrice(product.getPrice());
        }

        return product;
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

    public List<Product> getProducts() {
        return productDAO.getproducts();
    }

    public List<Product> getProductsByPage(int page, int limit) {
         List<Product> products = productDAO.getProductsByPage(page, limit);

         for (Product product : products) {
             Discount discount = ds.getDiscount(product);
             if (discount != null) {
                 product.setDiscount(discount);
                 double finalPrice = caculateDiscount(product.getPrice(), discount);
                 product.setFinalPrice(finalPrice);
             }else {
                 product.setFinalPrice(product.getPrice());
             }
         }
        return  products;
    }

    public int getTotalProduct() {
        return productDAO.getTotalProduct();
    }

    public int getTotalProduct(String find, String[] categories, String[] brands) {
        return productDAO.getTotalProduct(find, categories, brands);
    }

    public List<Product> getProductFilter(String find, String[] categories, String[] brands, int page, int limit) {
        List<Product> products = productDAO.getProductFilter(find, categories, brands, page, limit);

        for (Product product : products) {
            Discount discount = ds.getDiscount(product);
            if (discount != null) {
                product.setDiscount(discount);
                double finalPrice = caculateDiscount(product.getPrice(), discount);
                product.setFinalPrice(finalPrice);
            }else {
                product.setFinalPrice(product.getPrice());
            }
        }
        return  products;
    }
}
