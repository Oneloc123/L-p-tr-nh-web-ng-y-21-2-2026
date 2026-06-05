package code.salecar.controller.admin.user;

import code.salecar.config.AppConfig;
import code.salecar.model.Address;
import code.salecar.model.Addresses;
import code.salecar.model.User;
import code.salecar.model.invalidate.UserInvalidate;
import code.salecar.service.address.AddressService;
import code.salecar.service.address.AddressesService;
import code.salecar.service.user.UserService;
import code.salecar.util.FileUtil;
import code.salecar.util.NotificationUtil;
import code.salecar.util.UploadUserImageUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
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
            AddressesService as = new AddressesService();
            List<Addresses> listAddress = as.getListAddressById(user.getId());
            request.setAttribute("listAddress",listAddress);
            request.setAttribute("user",user);
            request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        UserService us = new UserService();
        User user = us.getUserById(id);

        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String description = request.getParameter("description");
        String statuss = request.getParameter("status");
        String role = request.getParameter("role");

        user.setUsername(username);
        user.setFullname(fullname);
        user.setEmail(email);
        user.setPhonenumber(phoneNumber);
        user.setDescription(description);
        user.setRole(role);
        boolean status = "true".equals(statuss);
        user.setStatus(status);

        boolean hasError = false;

        String fullnameError = UserInvalidate.checkFullname(fullname);
        if(!fullnameError.equals("true")){
            request.setAttribute("fullnameError", fullnameError);
            hasError = true;
        }

        String usernameError = UserInvalidate.checkUsername(username);
        if(!usernameError.equals("true")){
            request.setAttribute("usernameError", usernameError);
            hasError = true;
        }

        String emailError = UserInvalidate.checkEmail(email);
        if(!emailError.equals("true")){
            request.setAttribute("emailError", emailError);
            hasError = true;
        }

        String phonenumberError = UserInvalidate.checkPhonenumber(phoneNumber);
        if(!phonenumberError.equals("true")){
            request.setAttribute("phonenumberError", phonenumberError);
            hasError = true;
        }

        if (hasError) {
            AddressesService as = new AddressesService();
            List<Addresses> listAddress = as.getListAddressById(id);
            request.setAttribute("listAddress", listAddress);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request, response);
            return;
        }

        try {
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                    String fileName = Paths.get(submittedFileName).getFileName().toString();
                    String ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();

                    if (!ext.matches("jpg|jpeg|png|webp")) {
                        request.setAttribute("toastMessage", "Chỉ chấp nhận file ảnh JPG, PNG, WEBP");
                        request.setAttribute("toastType", "error");

                        AddressesService as = new AddressesService();
                        request.setAttribute("listAddress", as.getListAddressById(id));
                        request.setAttribute("user", user);
                        request.getRequestDispatcher("/admin/user-admin-edit.jsp").forward(request, response);
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
                    user.setImgURL("/uploads/users/" + newFileName);
                }
            }
        } catch (ServletException e) {
            System.err.println("Warning: Could not process avatar upload: " + e.getMessage());
        }

        user.setUpdatedat(new Date(System.currentTimeMillis()));
        us.UpdateProfile(user);

        request.getSession().setAttribute("toastMessage", "Cập nhật User thành công");
        request.getSession().setAttribute("toastType", "success");

        response.sendRedirect("/userAdmin");
    }
}