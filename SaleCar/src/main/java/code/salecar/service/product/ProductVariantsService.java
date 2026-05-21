package code.salecar.service.product;

import code.salecar.dao.ProductVariantsDAO;
import code.salecar.model.product.entity.ProductVariants;

import java.util.List;

public class ProductVariantsService {
    ProductVariantsDAO pvd = new ProductVariantsDAO();

    public List<ProductVariants> getVariantById(long productId) {
        return pvd.getVariantById(productId);
    }

    public ProductVariants getVariantByVariantId(long variantId) {
        return pvd.getVariantByVariantId(variantId);
    }

    public void update(ProductVariants variant) {
        pvd.update(variant);
    }
}
