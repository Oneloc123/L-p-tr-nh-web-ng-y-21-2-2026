package code.salecar.model;


import code.salecar.model.product.dto.ProductDetailDTO;

import java.io.Serializable;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

public class Cart implements Serializable {
    private int id;
    private int userId;
    private Date createdAt;
    private Date updatedAt;

    /**
     * Map key: productId + "_" + variantId
     * Giúp phân biệt cùng sản phẩm nhưng khác variant.
     */
    private Map<String, CartItem> items;
    private double finalTotal;


    public Cart() {
        items = new HashMap<String, CartItem>();
    }

    public double getFinalTotal() {
        return finalTotal;
    }

    public void setFinalTotal(double finalTotal) {
        this.finalTotal = finalTotal;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }


    public void setItems(Map<String, CartItem> items) {
        this.items = items;
    }

    /**
     * Thêm sản phẩm kèm variant vào giỏ hàng.
     */
    public void addProduct(ProductDetailDTO product, int variantId, String variantName, String variantSku, double price, double variantFinalPrice, int quantity) {
        if (quantity <= 0) quantity = 1;
        int productId = (int) product.getProduct().getId();
        String key = productId + "_" + variantId;

        if (!items.containsKey(key)) {
            items.put(key, new CartItem(product, variantId, variantName, variantSku, price, variantFinalPrice, quantity));
        } else {
            items.get(key).upQuantity(quantity);
        }
    }

    /**
     * Giữ lại overload cũ (không variant) cho tương thích.
     */
    public void addProduct(ProductDetailDTO product, int quantity) {
        double price = product.getPrice();
        double finalPrice = product.getFinalPrice();
        addProduct(product, 0, "", "", price, finalPrice, quantity);
    }


    public void updateItem(ProductDetailDTO product, int quantity) {
        int productId = (int) product.getProduct().getId();
        // Tìm item đầu tiên có productId khớp để update
        for (Map.Entry<String, CartItem> entry : items.entrySet()) {
            if (entry.getValue().getProductId() == productId) {
                String key = entry.getKey();
                CartItem existing = entry.getValue();
                items.put(key, new CartItem(product, existing.getVariantId(), existing.getVariantName(), existing.getVariantSku(), existing.getPrice(), existing.getVariantFinalPrice(), quantity));
                return;
            }
        }
    }

    //xoa item
    public CartItem delItem(String key) {
        return items.remove(key);
    }

    //xoa item theo productId (giữ tương thích)
    public CartItem delItem(int productId) {
        // Tìm item đầu tiên có productId khớp
        String keyToRemove = null;
        for (Map.Entry<String, CartItem> entry : items.entrySet()) {
            if (entry.getValue().getProductId() == productId) {
                keyToRemove = entry.getKey();
                break;
            }
        }
        if (keyToRemove != null) {
            return items.remove(keyToRemove);
        }
        return null;
    }

    //xoa het
    public List<CartItem> delAll() {
        List<CartItem> data = new ArrayList<>(items.values());
        items.clear();
        return data;
    }

    public CartItem getItemById(int productId) {
        for (CartItem item : items.values()) {
            if (item.getProductId() == productId) {
                return item;
            }
        }
        return null;
    }

    public CartItem getItemByKey(String key) {
        return items.get(key);
    }
    public int getSize(){
        return items.size();
    }
    public List<CartItem> getItems() {
        return new ArrayList<>(items.values());
    }

    public int getTotalQuantity() {
        AtomicInteger total = new AtomicInteger();
        items.values().forEach(cartItem -> total.addAndGet(cartItem.getQuantity()));
        return total.get();
    }

    public double getTotal() {
        double total = 0;

        for (CartItem item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }


}
