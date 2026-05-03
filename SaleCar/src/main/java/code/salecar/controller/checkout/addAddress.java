package code.salecar.controller.checkout;

import code.salecar.dao.AddressDao;
import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "addAddress", value = "/add-address")
public class addAddress extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.getWriter().print("vui lòng đăng nhập để thanh toán");
            return;
        }

        int userId = user.getId();
        String name = request.getParameter("name");
        String province = request.getParameter("province");
        String commune = request.getParameter("commune");
        String street = request.getParameter("street");
        String type = request.getParameter("type");

        AddressService addSv = new AddressService();
        List<Address> crrAddr = addSv.getListAddressById(userId);

        if(crrAddr.size() < 6){
            Address addr = new Address();
            addr.setUserId(userId);
            addr.setName(name);
            addr.setProvince(province);
            addr.setCommune(commune);
            addr.setStreet(street);
            addr.setType(type);

            addSv.addAddress(addr);

            List<Address> newAddresses = addSv.getListAddressById(userId);
            session.setAttribute("listAddress", newAddresses);

            response.getWriter().print("success");
        } else {
            response.getWriter().print("full_slot");
        }
    }
}