package code.salecar.service.product;

import code.salecar.dao.ExportReceiptDAO;
import code.salecar.dao.ImportReceiptDAO;
import code.salecar.dao.InventoryDAO;
import code.salecar.dao.ProductDAO;
import code.salecar.dao.ProductVariantsDAO;
import code.salecar.model.User;
import code.salecar.model.product.entity.ActivityLog;
import code.salecar.model.product.entity.Product;
import code.salecar.model.product.entity.ProductVariants;
import code.salecar.service.file.ActivityLogFileService;

import java.util.Date;
import java.util.List;

public class ProductVariantsService {
    ProductVariantsDAO pvd = new ProductVariantsDAO();
    ProductDAO productDAO = new ProductDAO();
    ImportReceiptDAO ird = new ImportReceiptDAO();
    ExportReceiptDAO erd = new ExportReceiptDAO();
    InventoryDAO iv = new InventoryDAO();
    public List<ProductVariants> getVariantById(long productId) {
        List<ProductVariants> list = pvd.getVariantById(productId);
        for (ProductVariants pv : list) {
            pv.setQuantity(iv.getQuantity(pv.getId()));
        }
        return list;
    }

    public ProductVariants getVariantByVariantId(long variantId) {
        ProductVariants pv = pvd.getVariantByVariantId(variantId);
        pv.setQuantity(iv.getQuantity(variantId));
        return pv;
    }

    public void createImportReceipt(ProductVariants variant, User user) {
        int irId = ird.createImportReceipt(user);

        createImportReceiptItem(irId,variant);
    }

    public void createImportReceiptItem(int improtId,ProductVariants variant) {
        ird.createImportReceiptItem(improtId,variant);

        iv.update(variant);

    }

    /**
     * Đồng bộ product.price với MIN variant price.
     * Gọi sau khi variant thay đổi (thêm/sửa/xóa).
     */
    public void syncProductPrice(long productId) {
        productDAO.syncProductPrice(productId);
    }

    public void createExportReceipt(ProductVariants variants, User user) {
        int erId = erd.createImportReceipt(user);
        createExportReceiptItem(erId,variants);
        pvd.update(variants);
    }

    public void createExportReceiptItem(int exportID,ProductVariants variant) {
        erd.createExportReceiptItem(exportID,variant);
        iv.update(variant);

    }
}
