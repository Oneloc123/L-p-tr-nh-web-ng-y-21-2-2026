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

    /**
     * Nhập kho: tạo phiếu nhập + ghi delta vào import_receipt_items + cập nhật inventory (+delta).
     * @param variant Biến thể nhập
     * @param user    Người thực hiện
     * @param quantity Số lượng NHẬP (delta), không phải tổng sau nhập
     */
    public void createImportReceipt(ProductVariants variant, User user, int quantity) {
        int irId = ird.createImportReceipt(user);
        createImportReceiptItem(irId, variant, quantity);
    }

    /**
     * Tạo chi tiết phiếu nhập: ghi import_receipt_items + cập nhật inventory (+delta).
     */
    public void createImportReceiptItem(int importId, ProductVariants variant, int quantity) {
        ird.createImportReceiptItem(importId, variant, quantity);
        iv.adjustQuantity(variant.getProductId(), variant.getId(), quantity);
    }

    /**
     * Đồng bộ product.price với MIN variant price.
     * Gọi sau khi variant thay đổi (thêm/sửa/xóa).
     */
    public void syncProductPrice(long productId) {
        productDAO.syncProductPrice(productId);
    }

    /**
     * Xuất kho thủ công: tạo phiếu xuất + ghi delta vào export_receipt_items + cập nhật inventory (-delta).
     * @param variant Biến thể xuất
     * @param user    Người thực hiện
     * @param quantity Số lượng XUẤT (delta), không phải tổng sau xuất
     */
    public void createExportReceipt(ProductVariants variant, User user, int quantity) {
        int erId = erd.createExportReceipt(user);
        createExportReceiptItem(erId, variant, quantity);
    }

    /**
     * Tạo chi tiết phiếu xuất: ghi export_receipt_items + cập nhật inventory (-delta).
     */
    public void createExportReceiptItem(int exportId, ProductVariants variant, int quantity) {
        erd.createExportReceiptItem(exportId, variant, quantity);
        iv.adjustQuantity(variant.getProductId(), variant.getId(), -quantity);
    }
}
