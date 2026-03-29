package code.salecar.controller.profile;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProfileEdit", value = "/profileEdit")
public class ProfileEdit extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            User user = (User)session.getAttribute("user");
            AddressService as = new AddressService();
            List<Address> listAddress = as.getListAddressById(user.getId());
            request.setAttribute("listAddress",listAddress);
            request.setAttribute("user",user);
            request.getRequestDispatcher("/pages/profile-edit.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname").toString();
        String email = request.getParameter("email").toString();
        String phoneNumber = request.getParameter("phoneNumber").toString();
        String description = request.getParameter("description").toString();
        String statuss = request.getParameter("status");

        String fullnameError = UserInvalidate.checkFullname(fullname);
        if(!fullnameError.equals("true")){
            request.setAttribute("fullnameError",fullnameError);
            request.getRequestDispatcher("/pages/profile-edit.jsp").forward(request,response);
            return;
        }

        String emailError = UserInvalidate.checkEmail(email);
        if(!emailError.equals("true")){
            request.setAttribute("emailError",emailError);
            request.getRequestDispatcher("/pages/profile-edit.jsp").forward(request,response);
            return;
        }

        String phonenumberError = UserInvalidate.checkPhonenumber(phoneNumber);
        if(!phonenumberError.equals("true")){
            request.setAttribute("phonenumberError",phonenumberError);
            request.getRequestDispatcher("/pages/profile-edit.jsp").forward(request,response);
            return;
        }

        boolean status= false;
        if(statuss.equals("active")){
            status = true;
        }
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        user.setFullname(fullname);
        user.setEmail(email);
        user.setPhonenumber(phoneNumber);
        user.setDescription(description);
        user.setStatus(status);
        user.setUpdatedat(new Date(System.currentTimeMillis()));
        UserService us = new UserService();
        us.UpdateProfile(user);

        if(addressId!=0){
            AddressService as = new AddressService();
            as.setMainAddress(addressId,user.getId());
        }
        AddressService as = new AddressService();
        List<Address> listAddress = as.getListAddressById(user.getId());

        if(!listAddress.isEmpty()){
            for(Address a :listAddress){
                String street = request.getParameter("street"+a.getId());
                String commune = request.getParameter("commune"+a.getId());
                String province = request.getParameter("province"+a.getId());
                a.setStreet(street);
                a.setCommune(commune);
                a.setProvince(province);
                as.updateAddress(a);
            }
        }
        request.setAttribute("listAddress", listAddress);
        request.setAttribute("user", user);

        //alert
        request.getSession().setAttribute("toastMessage", "cật nhật thành công");
        request.getSession().setAttribute("toastType", "success");

        request.getRequestDispatcher("/pages/profile-edit.jsp").forward(request,response);
    }
}