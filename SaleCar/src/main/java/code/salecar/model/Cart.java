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

    private Map<Integer, CartItem> items;
    private double finalTotal;


    public Cart() {
        items = new HashMap<Integer, CartItem>();
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


    public void setItems(Map<Integer, CartItem> items) {
        this.items = items;
    }

    public void addProduct(ProductDetailDTO product, int quantity) {

        if (quantity <= 0) {
            quantity = 1;
        }
        int productId = (int) product.getProduct().getId();

        if (!items.containsKey(productId)) {
            items.put(productId, new CartItem(product, quantity, product.getProduct().getPrice()));;
        } else {
            items.get(productId).upQuantity(quantity);
        }
    }


    public void updateItem(ProductDetailDTO product, int quantity) {
        int productId = (int) product.getProduct().getId();
        items.put(productId, new CartItem(product, quantity, product.getProduct().getPrice()));
    }

    //xoa item
    public CartItem delItem(int id) {

        return items.remove(id);
    }

    //xoa het
    public List<CartItem> delAll() {
        List<CartItem> data = new ArrayList<>(items.values());
        items.clear();
        return data;
    }

    public CartItem getItemById(int id) {
        return items.get(id);
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
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }


}
