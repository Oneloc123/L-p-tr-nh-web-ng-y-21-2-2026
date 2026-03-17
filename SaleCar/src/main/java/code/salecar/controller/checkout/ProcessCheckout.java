    package code.salecar.controller.checkout;

    import code.salecar.dao.OrderDAO;
    import code.salecar.model.Cart;
    import code.salecar.model.Order;
    import code.salecar.model.User;
    import jakarta.servlet.*;
    import jakarta.servlet.http.*;
    import jakarta.servlet.annotation.*;

    import java.io.IOException;

    @WebServlet(name = "ProcessCheckout", value = "/process-checkout")
    public class ProcessCheckout extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            User user = (User) session.getAttribute("user");

            if (user == null){
                response.sendRedirect("login");
                return;
            }else {
                if (cart == null){
                    cart = new Cart();
                }else {
                    String name = request.getParameter("fullName");
                    String phone = request.getParameter("phone");
                    String shippingAddress = request.getParameter("shippingAddress");

                    // set dữ liệu cho order
                    String fullInfor = name + "- SĐT: " + phone + " - Địa chỉ: " + shippingAddress;
                    Order order = new Order();
                    order.setUserId(user.getId());
                    order.setTotalAmount(cart.getTotal());
                    order.setShippingAddress(fullInfor);
                    order.setPaymentMethod(request.getParameter("paymentMethod"));
                    order.setOrderStatus("Đang xử lý");

                    try {
                        OrderDAO orderDAO = new OrderDAO();
                        orderDAO.insertOrder(order, cart);


                        session.removeAttribute("cart");
                        response.sendRedirect("order");

                    } catch (Exception e) {
                        e.printStackTrace();

                        response.getWriter().println("Lỗi lưu đơn hàng: " + e.getMessage());
                    }

                }
        }
        }
    }