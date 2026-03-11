package code.salecar.model;


import java.io.Serializable;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class Cart implements Serializable {
        private int id;
        private int userId;
        private Date createdAt;
        private Date updatedAt;

        private Map<Integer,CartItem> items;


    public Cart(){
        items = new HashMap<Integer, CartItem>();
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

    public void addProduct(Product product, int quantity) {

        if(quantity <= 0){quantity = 1;}

        if(!items.containsKey(product.getId())){
           items.put(product.getId(), new CartItem(product,quantity, product.getPrice()));
        }else {
            items.get(product.getId()).upQuantity(quantity);
        }
    }


    public void updateItem(Product product, int quantity){
        items.put(product.getId(), new CartItem(product, quantity, product.getPrice()));


    }

    //xoa item
    public CartItem delItem(int id){

        return items.remove(id);
    }

    //xoa het
    public List<CartItem> delAll(){
        List<CartItem> data = new ArrayList<>(items.values());
        items.clear();
        return data;
    }

    public CartItem getItemById(int id){return items.get(id);}
    public List<CartItem> getItems(){
        return new ArrayList<>(items.values());
    }

    public int getTotalQuantity(){
        AtomicInteger total = new AtomicInteger();
        items.values().forEach(cartItem -> total.addAndGet(cartItem.getQuantity()));
        return total.get();
    }

    public double getTotal(){
        double total = 0;

        for(CartItem item : items.values()){
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }

}
