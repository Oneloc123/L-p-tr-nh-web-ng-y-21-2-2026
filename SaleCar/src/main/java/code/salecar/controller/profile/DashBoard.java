package code.salecar.controller.profile;

import code.salecar.dao.OrderDAO;
import code.salecar.model.*;
import code.salecar.model.product.dto.ProductDetailDTO;
import code.salecar.model.product.entity.Voucher;
import code.salecar.service.address.AddressService;
import code.salecar.service.address.AddressesService;
import code.salecar.service.product.FavoritesService;
import code.salecar.service.product.VoucherService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashBoard", value = "/dashboard")
public class DashBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            // User
            User user = (User)session.getAttribute( "user");
            AddressesService as = new AddressesService();
            request.setAttribute("user",user);
            // Order
            OrderDAO os = new OrderDAO();
            List<Order> listOrder = os.getOrdersByUserId(user.getId());
            int totalOrders = 0;
            double totalSpending = 0;

            int pendingCount=0;
            int processingCount=0;
            int deliveredCount=0;
            int cancelledCount=0;
            int shippingCount=0;

            for (Order o : listOrder){
                totalOrders++;
                totalSpending+= o.getTotalAmount();
                if(o.getOrderStatus().equals("Đang xử lý")){
                    processingCount++;
                }
                if(o.getOrderStatus().equals("CANCELLED")){
                    cancelledCount++;
                }
                if(o.getOrderStatus().equals("DELIVERED")){
                    deliveredCount++;
                }
                if(o.getOrderStatus().equals("SHIPPING")){
                    shippingCount++;
                }
                if(o.getOrderStatus().equals("CONFIRMED")){
                    pendingCount++;
                }
            }
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalSpending",totalSpending);
            request.setAttribute("listOrder",listOrder);
            // WishList
            FavoritesService fs = new FavoritesService();
            List<ProductDetailDTO> listWishList = fs.getFavorites(user.getId());
            int countWishList = 0;
            for(ProductDetailDTO p :listWishList){
                countWishList++;
            }
            request.setAttribute("totalFavorites",countWishList);
            // Cart
            Cart cart = (Cart)session.getAttribute("cart");
            if(cart == null){cart = new Cart();}
            session.setAttribute("cart", cart);
            int countCartItem = cart.getTotalQuantity();
            request.setAttribute("cartItemCount",countCartItem);

            VoucherService vs = new VoucherService();
            List<Voucher> listVC = vs.getVouchers();
            int countVC = 0;
            for(Voucher v : listVC){
                countVC ++;
            }
            request.setAttribute("totalVoucher", countVC);

            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("processingCount", processingCount);
            request.setAttribute("shippingCount", shippingCount);
            request.setAttribute("deliveredCount", deliveredCount);
            request.setAttribute("cancelledCount", cancelledCount);

            request.setAttribute("vouchers",listVC);

            Addresses add = as.getMainAddressById(user.getId());

            request.setAttribute("address",add);


            request.getRequestDispatcher("/pages/dashBoard.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}