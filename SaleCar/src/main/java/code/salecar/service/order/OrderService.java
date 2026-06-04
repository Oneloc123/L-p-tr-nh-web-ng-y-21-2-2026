package code.salecar.service.order;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Cart;
import code.salecar.model.CartItem;
import code.salecar.model.Order;
import code.salecar.model.OrderItem;
import code.salecar.model.User;
import code.salecar.service.inventory.InventoryService;
import code.salecar.service.user.UserService;

import java.util.List;

public class OrderService {
    OrderDAO ordDAO = new OrderDAO();
    UserService userSV = new UserService();


    public List<Order> getOrderByDays(int days){
        return ordDAO.getOrdersByLastDays(days);
    }
    public List<Order> getOrderByDaysPrevious(int days){
        return ordDAO.getOrdersByPreviousDays(days);
    }

    /**
     * Xử lý đơn hàng: validate stock → tạo order → trả về kết quả.
     * Nếu bất kỳ item nào không đủ stock, trả về null.
     */
    public Order processOrder(User user, Cart cart, String name, String phone, String shippingAddress, String paymentMethod, double shippingFee) {

        if (user == null || cart == null || cart.getItems().isEmpty()) {
            return null;
        }

        /* Kiểm tra tồn kho cho từng item trong giỏ */
        InventoryService invService = new InventoryService();
        for (CartItem item : cart.getItems()) {
            /* variantId > 0 nghĩa là có variant, cần check stock theo variant */
            if (item.getVariantId() > 0) {
                if (!invService.hasEnoughStock(item.getVariantId(), item.getQuantity())) {
                    /* Không đủ stock — từ chối tạo đơn */
                    return null;
                }
            }
        }

        String fullInfor = name + " - SĐT: " + phone + " - Địa chỉ: " + shippingAddress;

        // Tổng tiền = tiền hàng + phí ship
        double totalAmount = cart.getTotal() + shippingFee;

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(fullInfor);
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus("Đang xử lý");
        order.setShippingFee(shippingFee);


        try {
            ordDAO.insertOrder(order, cart);
            return order;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Hủy đơn hàng: cập nhật trạng thái + hoàn kho (nếu đã trừ kho trước đó).
     */
    public void cancelOrder(int orderId, int userId, String reason){

        String finalStatus = "Đã huỷ (" + reason + ")";

        ordDAO.updateOrderStatusAndReason(orderId, userId, finalStatus);

        /* Hoàn kho nếu đơn đã được trừ kho trước đó */
        InventoryService invService = new InventoryService();
        if (invService.isInventoryDeducted(orderId)) {
            invService.restoreStock(orderId);
        }
    }
    public List<OrderItem> getOrderItem(int orderId){
        return ordDAO.getOrderItemsByOrderId(orderId);
    }

    public List<Order> getOrderByUserId(int userId){
        List<Order> result = ordDAO.getOrdersByUserId(userId);
        return result;
    }

    public  List<Order> getOrdByKeyWord(String Key){
        List<Order> orderList = ordDAO.getOrdByKeyWord(Key);
        for (Order ord : orderList){
            ord.setItems(ordDAO.getOrderItemsByOrderId(ord.getId()));
        }
        return orderList;
    }

    public List<Order> filterOrder(String status) {


            return ordDAO.filterOrd(status);

    }
}
