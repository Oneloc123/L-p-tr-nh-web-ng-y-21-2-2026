package code.salecar.controller.admin;

import code.salecar.dao.OrderDAO;
import code.salecar.model.Order;
import code.salecar.model.User;
import code.salecar.service.order.OrderService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashBoardAdmin", value = "/admin/dashboard")
public class DashBoardAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        OrderService os = new OrderService();
        List<Order> listOrder = os.getOrderByDays(7);
        List<Order> listOrderPre = os.getOrderByDaysPrevious(7);

        double totalPriceOrder = 0;
        int totalOrder = 0;

        int totalOrderInProcess = 0;
        int totalOrderCancelled = 0;
        int totalOrderDelivered = 0;

        for (Order o : listOrder){
            //
            totalPriceOrder += o.getTotalAmount();
            totalOrder ++;
            if(o.getOrderStatus().equals("Đang xử lý")){
                totalOrderInProcess++;
            }
            if(o.getOrderStatus().equals("CANCELLED")){
                totalOrderCancelled++;
            }
            if(o.getOrderStatus().equals("DELIVERED")){
                totalOrderDelivered++;
            }

        }

        double totalPriceOrderPre = 0;
        int totalOrderPre = 0;

        for (Order o : listOrderPre){
            //
            totalPriceOrderPre += o.getTotalAmount();
            totalOrderPre ++;
        }
        double averagePriceOrderPre = 0;
        if (totalOrderPre > 0) {
            averagePriceOrderPre = Math.round((totalPriceOrderPre / totalOrderPre) * 100.0) / 100.0;
        }

        double averagePriceOrder = 0;
        if (totalOrder > 0) {
            averagePriceOrder = Math.round((totalPriceOrder / totalOrder) * 100.0) / 100.0;
        }

        request.setAttribute("averagePriceOrder", Math.round(averagePriceOrder));
        request.setAttribute("totalOrder",totalOrder);
        request.setAttribute("totalPriceOrder", Math.round(totalPriceOrder));

        request.setAttribute("growPriceOder",calculateGrowthRate(totalPriceOrder,totalPriceOrderPre));
        request.setAttribute("growTotalOrder",calculateGrowthRate(totalOrder,totalOrderPre));
        request.setAttribute("growAverage",calculateGrowthRate(averagePriceOrder,averagePriceOrderPre));

        request.setAttribute("inProcess", totalOrderInProcess);
        request.setAttribute("cancelled",totalOrderCancelled);
        request.setAttribute("delivered",totalOrderDelivered);

        request.setAttribute("listOrder",listOrder);

        request.getRequestDispatcher("/admin/dashBoardAdmin.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public double calculateGrowthRate(double currentRevenue, double previousRevenue) {
        if (previousRevenue == 0) {
            return currentRevenue > 0 ? 100.0 : 0.0;
        }

        double growthRate = ((currentRevenue - previousRevenue) / previousRevenue) * 100;

        return Math.round(growthRate * 100.0) / 100.0;
    }
}