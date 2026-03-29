package code.salecar.controller.admin.user;

import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "UpdateUser", value = "/updateUser")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 2 * 1024 * 1024,
        maxRequestSize = 5 * 1024 * 1024)
public class UpdateUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // kiểm tra session
        HttpSession session = request.getSession();
        if(session==null||session.getAttribute("user")==null){
            response.sendRedirect("/login");
        }else{
            UserService us = new UserService();
            User userCheck = (User)session.getAttribute("user");
            if(!userCheck.getRole().equals("admin")){
                response.sendRedirect("/login");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            User user = us.getUserById(id);
            AddressService as = new AddressService();
            List<Address> listAddress = as.getListAddressById(user.getId());
            request.setAttribute("listAddress",listAddress);
            request.setAttribute("user",user);
            request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname").toString();
        String email = request.getParameter("email").toString();
        String phoneNumber = request.getParameter("phoneNumber").toString();
        String description = request.getParameter("description").toString();
        String statuss = request.getParameter("status");
        String role = request.getParameter("role");

        String fullnameError = UserInvalidate.checkFullname(fullname);
        if(!fullnameError.equals("true")){
            request.setAttribute("fullnameError",fullnameError);
            request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request,response);
            return;
        }
        String usernameError = UserInvalidate.checkUsername(username);
        if(!usernameError.equals("true")){
            request.setAttribute("usernameError",usernameError);
            request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request,response);
            return;
        }
        String emailError = UserInvalidate.checkEmail(email);
        if(!emailError.equals("true")){
            request.setAttribute("emailError",emailError);
            request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request,response);
            return;
        }

        String phonenumberError = UserInvalidate.checkPhonenumber(phoneNumber);
        if(!phonenumberError.equals("true")){
            request.setAttribute("phonenumberError",phonenumberError);
            request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request,response);
            return;
        }


        boolean status= false;
        if(statuss.equals("true")){
            status = true;
        }
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        String imgURL = uploads(request);

        HttpSession session = request.getSession();
        UserService us = new UserService();
        User user = us.getUserById(id);
        user.setUsername(username);
        user.setFullname(fullname);
        user.setEmail(email);
        user.setImgURL(imgURL);
        user.setPhonenumber(phoneNumber);
        user.setDescription(description);
        user.setStatus(status);
        user.setUpdatedat(new Date(System.currentTimeMillis()));
        user.setRole(role);
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
        request.getSession().setAttribute("toastMessage", "cật nhật User thành công");
        request.getSession().setAttribute("toastType", "success");

        response.sendRedirect("/userAdmin");
    }
    private String uploads(HttpServletRequest request) throws ServletException, IOException {
        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        String fileName = filePart.getSubmittedFileName();
        String lowerName = fileName.toLowerCase();
        if (!(lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg") || lowerName.endsWith(".png"))) {
            return null;
        }
        String uploadPath = getServletContext().getRealPath("/uploads/avatar");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        String newFileName = System.currentTimeMillis() + "_" + fileName;
        filePart.write(uploadPath + File.separator + newFileName);
        String avatarUrl = "uploads/avatar/" + newFileName;
        return avatarUrl;
    }
}