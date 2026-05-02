package code.salecar.service.cart;

import code.salecar.model.Cart;
import code.salecar.model.CartItem;
import code.salecar.model.product.dto.ProductDetail;

import java.util.*;

public class cartService {


    private Map<Integer, CartItem> listToMap(List<CartItem> list) {
        Map<Integer, CartItem> map = new HashMap<>();
        for (CartItem item : list) {
            map.put(item.getProductId(), item);
        }
        return map;
    }

    // 1. thêm sp
    public void addProduct(Cart cart, ProductDetail product, int quantity) {
        if (quantity <= 0) {
            quantity = 1;
        }

        List<CartItem> currentItems = cart.getItems(); // Lấy List từ Cart.java
        boolean exists = false;

        for (CartItem item : currentItems) {
            if (item.getProductId() == product.getId()) {
                item.upQuantity(quantity);
                exists = true;
                break;
            }
        }

        if (!exists) {
            currentItems.add(new CartItem(product, quantity, product.getPrice()));
        }

        // Cập nhật ngược lại vào Cart
        cart.setItems(listToMap(currentItems));
    }

    // 2. update sp (sl,giá)
    public void updateItem(Cart cart, ProductDetail product, int quantity) {
        List<CartItem> currentItems = cart.getItems();
        boolean found = false;

        for (CartItem item : currentItems) {
            if (item.getProductId() == product.getId()) {
                item.setQuantity(quantity);
                item.setPrice(product.getPrice());
                found = true;
                break;
            }
        }

        if (!found) {
            currentItems.add(new CartItem(product, quantity, product.getPrice()));
        }

        cart.setItems(listToMap(currentItems));
    }

    // 3. xóa 1 món
    public CartItem delItem(Cart cart, int id) {
        List<CartItem> currentItems = cart.getItems();
        CartItem removed = null;

        Iterator<CartItem> iterator = currentItems.iterator();
        while (iterator.hasNext()) {
            CartItem item = iterator.next();
            if (item.getProductId() == id) {
                removed = item;
                iterator.remove();
                break;
            }
        }

        cart.setItems(listToMap(currentItems));
        return removed;
    }

    // 4. xóa hết
    public List<CartItem> delAll(Cart cart) {
        List<CartItem> data = cart.getItems();
        cart.setItems(new HashMap<>());
        return data;
    }

    // 5. lấy sp theo id
    public CartItem getItemById(Cart cart, int id) {
        for (CartItem item : cart.getItems()) {
            if (item.getProductId() == id) {
                return item;
            }
        }
        return null;
    }

    // 6. số loại mặt hàng
    public int getSize(Cart cart) {
        return cart.getItems().size();
    }

    // 7. list sp
    public List<CartItem> getItemsList(Cart cart) {
        return cart.getItems();
    }

    // 8. tổng sl
    public int getTotalQuantity(Cart cart) {
        int total = 0;
        for (CartItem item : cart.getItems()) {
            total += item.getQuantity();
        }
        return total;
    }

    // 9. tổng tiền
    public double getTotal(Cart cart) {
        double total = 0;
        for (CartItem item : cart.getItems()) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
}