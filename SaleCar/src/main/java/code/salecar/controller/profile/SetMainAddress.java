package code.salecar.controller.profile;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.service.address.AddressService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "setMainAddress", value = "/setMainAddress")
public class SetMainAddress extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int addressId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        AddressService as = new AddressService();
        as.setMainAddress(addressId,user.getId());
        List<Address> listAddress = as.getListAddressById(user.getId());
        request.setAttribute("listAddress", listAddress);
        request.setAttribute("user", user);

        request.getSession().setAttribute("toastMessage", "cật nhật thành công");
        request.getSession().setAttribute("toastType", "success");

        request.getRequestDispatcher("/pages/profile-edit.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}