package code.salecar.service.home;

import code.salecar.model.brand.Brand;
import code.salecar.model.category.Category;
import code.salecar.model.product.dto.ProductItemDTO;
import code.salecar.model.product.entity.Discount;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.Banner;
import code.salecar.model.product.entity.Voucher;
import code.salecar.model.product.filter.VoucherFilter;
import code.salecar.service.product.BannerService;
import code.salecar.service.product.BrandService;
import code.salecar.service.product.CategoryService;
import code.salecar.service.product.ProductService;
import code.salecar.service.product.VoucherService;

import java.util.ArrayList;
import java.util.List;

public class HomeService {

    ProductService productService = new ProductService();
    BrandService brandService = new BrandService();
    CategoryService categoryService = new CategoryService();
    BannerService bannerService = new BannerService();
    VoucherService voucherService = new VoucherService();


    public List<Product> getProductByCategory(int category_id){
        return null;
    }

    public List<Product> getProductByFavorites(int uers_id){
        return null;
    }

    public List<ProductItemDTO> getProductSale(){
        return productService.getProductSale();
    }

    public List<Product> getProductSaleByCategory(int category_id){
        return null;
    }

    public List<Voucher> getVouchers(){
        VoucherFilter filter = new VoucherFilter();
        filter.setTimeStatus("active");
        filter.setLimit(10);
        return voucherService.getVouchers(filter);
    }

    public List<ProductItemDTO> getProductNew(){
        return productService.getProductNew();
    }

    public List<ProductItemDTO> getProductHot() {
        return productService.getProductHot();
    }

    public List<Brand> getAllBrands() { return brandService.getBrands().subList(0,9);
    }

    public List<Category> getCategory() {
        List<Category> categories = categoryService.getCategory();
        return categories.subList(0,4);
    }

    public List<Banner> getActiveBanners() {
        return bannerService.getActiveBanners();
    }
}
