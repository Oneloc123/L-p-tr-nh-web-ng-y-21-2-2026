package code.salecar.service.home;

import code.salecar.model.Brand;
import code.salecar.model.product.dto.ProductItem;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.ProductService;

import java.util.ArrayList;
import java.util.List;

public class HomeService {

    ProductService productService = new ProductService();
    BrandService brandService = new BrandService();



    public List<Product> getProductByCategory(int category_id){
        return null;
    }

    public List<Product> getProductByFavorites(int uers_id){
        return null;
    }

    public List<Product> getProductSale(){
        return new ArrayList<Product>();
    }

    public List<Product> getProductSaleByCategory(int category_id){
        return null;
    }

    public List<Discount> getVoucher(){
        return null;
    }

    public List<ProductItem> getProductNew(){
        return productService.getProductNew();
    }

    public List<ProductItem> getProductHot() {
        return productService.getProductHot();
    }

    public List<Brand> getAllBrands() { return brandService.getBrands();
    }
}
