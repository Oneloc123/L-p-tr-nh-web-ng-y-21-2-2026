package code.salecar.controller.admin.user;

import code.salecar.dao.AddressesDao;
import code.salecar.model.Address;
import code.salecar.model.Addresses;
import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import code.salecar.service.address.AddressesService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "AddAdressAdmin", value = "/addAdressAdmin")
public class AddAdressAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String name = request.getParameter("name");
        String street = request.getParameter("street");
        String commune = request.getParameter("commune");
        String district = request.getParameter("district");
        String province = request.getParameter("province");
        int userId = Integer.parseInt(request.getParameter("userId"));

        String fullAddress = street + ", " + commune + ", " + district + ", " + province;

        Addresses address = new Addresses();
        address.setUserId(userId);
        address.setNameAddress(name);
        address.setAddressLine(street);
        address.setWardName(commune);
        address.setDistricName(district);
        address.setProvinceName(province);
        address.setFullAddress(fullAddress);
        address.setType("normal");
        address.setCreateAt(new Date(System.currentTimeMillis()));

        AddressesDao dao = new AddressesDao();
        dao.addAddress(address);

        response.setStatus(HttpServletResponse.SC_OK);
    }
}