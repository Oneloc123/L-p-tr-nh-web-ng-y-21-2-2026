package code.salecar.controller.admin.brand;

import code.salecar.config.AppConfig;
import code.salecar.model.brand.Brand;
import code.salecar.model.enumeration.Status;
import code.salecar.service.product.BrandService;
import code.salecar.util.FileUtil;
import code.salecar.util.NotificationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/admin/brands/edit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class brand_edit extends HttpServlet {
    BrandService brandService = new BrandService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int brandId = Integer.parseInt(idParam.trim());
                Brand brand = brandService.getBrandByID(brandId);
                if (brand == null) {
                    NotificationUtil.setError(request.getSession(), "Không tìm thấy thương hiệu");
                    response.sendRedirect("/admin/brands");
                    return;
                }
                request.setAttribute("brand", brand);
                request.getRequestDispatcher("/admin/brand/brand-edit.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                NotificationUtil.setError(request.getSession(), "ID thương hiệu không hợp lệ");
                response.sendRedirect("/admin/brands");
            }
        } else {
            response.sendRedirect("/admin/brands");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Thiếu ID thương hiệu");
            response.sendRedirect("/admin/brands");
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());

            // Fetch existing brand to preserve current image & other fields
            Brand brand = brandService.getBrandByID(id);
            if (brand == null) {
                NotificationUtil.setError(request.getSession(), "Không tìm thấy thương hiệu");
                response.sendRedirect("/admin/brands");
                return;
            }

            String nameParam = request.getParameter("name");
            if (nameParam == null || nameParam.trim().isEmpty()) {
                NotificationUtil.setError(request.getSession(), "Tên thương hiệu không được để trống");
                response.sendRedirect("/admin/brands/edit?id=" + idParam);
                return;
            }
            brand.setName(nameParam.trim());

            String statusParam = request.getParameter("status");
            if (statusParam != null && !statusParam.isEmpty()) {
                brand.setStatus(Status.fromString(statusParam.trim()));
            } else {
                brand.setStatus(Status.ACTIVE);
            }

            String linkBrandParam = request.getParameter("linkBrand");
            brand.setLinkBrand(linkBrandParam != null ? linkBrandParam.trim() : null);

            String descriptionParam = request.getParameter("description");
            brand.setDescription(descriptionParam != null ? descriptionParam : null);

            // Handle logo upload
            try {
                Part filePart = request.getPart("logo");
                if (filePart != null && filePart.getSize() > 0) {
                    String submittedFileName = filePart.getSubmittedFileName();
                    if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                        String fileName = Paths.get(submittedFileName).getFileName().toString();
                        String ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();

                        if (!ext.matches("jpg|jpeg|png|webp")) {
                            NotificationUtil.setError(request.getSession(), "Chỉ chấp nhận file ảnh JPG, PNG, WEBP");
                            response.sendRedirect("/admin/brands/edit?id=" + idParam);
                            return;
                        }

                        String newFileName = FileUtil.generateFileName(fileName);
                        String baseDir = AppConfig.get("upload.base-dir");
                        if (baseDir == null || baseDir.isEmpty()) {
                            throw new RuntimeException("upload.base-dir not configured in application.properties");
                        }

                        java.nio.file.Path uploadPath = Paths.get(baseDir, "brands");
                        Files.createDirectories(uploadPath);
                        java.nio.file.Path filePath = uploadPath.resolve(newFileName);
                        filePart.write(filePath.toString());

                        brand.setLogo("/uploads/brands/" + newFileName);
                    }
                }
                // If no file uploaded, brand.getLogo() still has the existing value from DB
            } catch (ServletException e) {
                // Request is not multipart — continue without updating image
                System.err.println("Warning: Could not process logo upload: " + e.getMessage());
            }

            boolean updated = brandService.updateBrand(brand);
            if (updated) {
                NotificationUtil.setSuccess(request.getSession(), "Cập nhật thương hiệu thành công!");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể cập nhật thương hiệu");
            }
            response.sendRedirect("/admin/brands");

        } catch (NumberFormatException e) {
            NotificationUtil.setError(request.getSession(), "ID thương hiệu không hợp lệ");
            response.sendRedirect("/admin/brands");
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi cập nhật thương hiệu: " + e.getMessage());
            response.sendRedirect("/admin/brands");
        }
    }
}