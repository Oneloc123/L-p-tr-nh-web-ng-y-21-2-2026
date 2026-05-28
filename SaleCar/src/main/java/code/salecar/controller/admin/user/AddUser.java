package code.salecar.controller.admin.user;

import code.salecar.config.AppConfig;
import code.salecar.model.Address;
import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
import code.salecar.service.address.AddressService;
import code.salecar.service.user.UserService;
import code.salecar.util.FileUtil;
import code.salecar.util.NotificationUtil;
import code.salecar.util.UploadUserImageUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddUser", value = "/addUser")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 2 * 1024 * 1024,
        maxRequestSize = 5 * 1024 * 1024)
public class AddUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

            request.getRequestDispatcher("/admin/user-admin-add.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String description = request.getParameter("description");
        String phone = request.getParameter("phonenumber");
        String role = request.getParameter("role");
        String statusStr = request.getParameter("status");



        String name = request.getParameter("name");
        String street = request.getParameter("street");
        String commune = request.getParameter("commune");
        String province = request.getParameter("province");

        String fullnameError = UserInvalidate.checkFullname(fullname);
        if(!fullnameError.equals("true")){
            request.setAttribute("fullnameError",fullnameError);
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        String usernameError = UserInvalidate.checkUsername(username);
        if(!usernameError.equals("true")){
            request.setAttribute("usernameError",usernameError);
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        String emailError = UserInvalidate.checkEmail(email);
        if(!emailError.equals("true")){
            request.setAttribute("emailError",emailError);
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        String passwordError = UserInvalidate.checkPassword(password);
        if(!passwordError.equals("true")){
            request.setAttribute("passwordError",passwordError);
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }
        String phonenumberError = UserInvalidate.checkPhonenumber(phone);
        if(!phonenumberError.equals("true")){
            request.setAttribute("phonenumberError",phonenumberError);
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }

        UserService us = new UserService();
        User user = us.getUserByUsername(username);
        if(user!=null){
            request.setAttribute("usernameError","tên đăng nhập đã tồn tại");
            request.getRequestDispatcher("/admin/user-admin.jsp").forward(request,response);
            return;
        }

        String addressesJson = request.getParameter("addressesJson");
        List<Address> addressList = new ArrayList<>();
        if (addressesJson != null && !addressesJson.isEmpty()) {
            try {
                Gson gson = new Gson();
                Type listType = new TypeToken<List<Address>>() {}.getType();
                addressList = gson.fromJson(addressesJson, listType);
            } catch (Exception e) {
                request.setAttribute("addressError",e.getMessage());
                request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request,response);
                return;
            }
        }

        String link = "";
        try {
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                    String fileName = Paths.get(submittedFileName).getFileName().toString();
                    String ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();

                    if (!ext.matches("jpg|jpeg|png|webp")) {
                        NotificationUtil.setError(request.getSession(), "Chỉ chấp nhận file ảnh JPG, PNG, WEBP");
                        response.sendRedirect("/admin/user-admin-edit.jsp");
                        return;
                    }

                    String newFileName = FileUtil.generateFileName(fileName);
                    String baseDir = AppConfig.get("upload.base-dir");
                    if (baseDir == null || baseDir.isEmpty()) {
                        throw new RuntimeException("upload.base-dir not configured in application.properties");
                    }

                    java.nio.file.Path uploadPath = Paths.get(baseDir, "users");
                    Files.createDirectories(uploadPath);
                    java.nio.file.Path filePath = uploadPath.resolve(newFileName);
                    filePart.write(filePath.toString());

                    link = "/uploads/users/" + newFileName;
                }
            }
        } catch (ServletException e) {
            System.err.println("Warning: Could not process logo upload: " + e.getMessage());
            return;
        }

        boolean status = true;
        if(statusStr.equals("false")){
            status = false;
        }
        User u = new User();
        u.setUsername(username);
        u.setPassword(password);
        u.setFullname(fullname);
        u.setEmail(email);
        u.setDescription(description);
        u.setPhonenumber(phone);
        u.setRole(role);
        u.setStatus(status);
        u.setImgURL(link);
        u.setCreatedat(new Date(System.currentTimeMillis()));
        u.setUpdatedat(new Date(System.currentTimeMillis()));
        us.register(u);
        u = us.getUserByUsername(username);

        AddressService addressService = new AddressService();
        for (Address addr : addressList) {
            addr.setUserId(u.getId());
            addressService.addAddress(addr);
        }

        //alert
        request.getSession().setAttribute("toastMessage", "Thêm User thành công");
        request.getSession().setAttribute("toastType", "success");

        response.sendRedirect("/userAdmin");
    }


}