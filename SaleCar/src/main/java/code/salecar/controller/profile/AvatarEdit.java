package code.salecar.controller.profile;

import code.salecar.config.AppConfig;
import code.salecar.model.User;
import code.salecar.service.user.UserService;
import code.salecar.util.FileUtil;
import code.salecar.util.NotificationUtil;
import code.salecar.util.UploadUserImageUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;


@WebServlet(name = "AvatarEdit", value = "/avatarEdit")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 2 * 1024 * 1024,
        maxRequestSize = 5 * 1024 * 1024)

public class AvatarEdit extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"))
                || request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json");

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
                        response.sendRedirect("/pages/avatar-edit.jsp");
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

//        String avatarUrl;
//        try {
//            avatarUrl = UploadUserImageUtil.uploadImage(request, "avatar", "avatar");
//
//            if (avatarUrl == null) {
//                request.setAttribute("avatarError", "vui lòng chọn file ảnh");
//                request.getRequestDispatcher("/pages/avatar-edit.jsp").forward(request, response);
//                return;
//            }
//        } catch (IllegalArgumentException e) {
//            request.setAttribute("avatarError", e.getMessage());
//            request.getRequestDispatcher("/pages/avatar-edit.jsp").forward(request, response);
//            return;
//        }

        UserService us =new UserService();
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        user.setImgURL(link);
        us.UpdateProfile(user);
        request.getSession().setAttribute("user", user);
        request.getSession().setAttribute("toastMessage", "thay đổi ảnh thành công");
        request.getSession().setAttribute("toastType", "success");

        if (isAjax) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("success");
        } else {
            response.sendRedirect(request.getContextPath() + "/profileEdit");
        }
    }
}