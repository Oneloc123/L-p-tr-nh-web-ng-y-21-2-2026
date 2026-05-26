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

@WebServlet("/admin/brands/create")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class brand_create extends HttpServlet {
    private final BrandService brandService = new BrandService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/brand/brand-create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nameParam = request.getParameter("name");
        String linkBrandParam = request.getParameter("linkBrand");
        String statusParam = request.getParameter("status");
        String descriptionParam = request.getParameter("description");

        // Validate name
        if (nameParam == null || nameParam.trim().isEmpty()) {
            NotificationUtil.setError(request.getSession(), "Tên thương hiệu không được để trống");
            response.sendRedirect("/admin/brands/create");
            return;
        }

        Brand brand = new Brand();
        brand.setName(nameParam.trim());
        brand.setLinkBrand(linkBrandParam != null ? linkBrandParam.trim() : null);
        brand.setDescription(descriptionParam != null ? descriptionParam : null);
        brand.setStatus(statusParam != null && statusParam.equals("active") ? Status.ACTIVE : Status.INACTIVE);

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
                        response.sendRedirect("/admin/brands/create");
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
        } catch (ServletException e) {
            System.err.println("Warning: Could not process logo upload: " + e.getMessage());
        }

        try {
            long brandId = brandService.createBrand(brand);
            if (brandId > 0) {
                NotificationUtil.setSuccess(request.getSession(), "Tạo thương hiệu thành công!");
            } else {
                NotificationUtil.setError(request.getSession(), "Không thể tạo thương hiệu");
            }
        } catch (Exception e) {
            NotificationUtil.setError(request.getSession(), "Lỗi khi tạo thương hiệu: " + e.getMessage());
        }

        response.sendRedirect("/admin/brands");
    }
}