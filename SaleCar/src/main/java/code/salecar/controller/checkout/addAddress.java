package code.salecar.controller.checkout;

import code.salecar.dao.AddressDao;
import code.salecar.model.Address;
import code.salecar.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "addAddress", value = "/add-address")
public class addAddress extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        //lay thuoc tinh
        int userId = user.getId();
        String name = request.getParameter("name");
        String province = request.getParameter("province");
        String street = request.getParameter("street");
        String type = request.getParameter("type");
        String commune = request.getParameter("commune");

        AddressDao aDao = new AddressDao();
        int numAddress = aDao.countAddress(userId);

        if(numAddress < 6){
            Address addr = new Address(userId, street,commune, province, type, name);
            aDao.addAddress(addr);
            response.getWriter().print("success");
        }else {
            response.getWriter().print("full_slot");
            return;
        }
    }
}