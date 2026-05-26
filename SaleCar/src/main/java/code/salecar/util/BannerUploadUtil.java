package code.salecar.util;

import code.salecar.config.AppConfig;
import jakarta.servlet.http.Part;

import java.nio.file.Files;
import java.nio.file.Paths;

/** Tiện ích dùng chung cho upload và xác thực ảnh banner.
 * Sử dụng upload.base-dir từ application.properties (modelcar-storage/banners).
 * File được phục vụ qua UploadFileServlet tại /uploads/banners/*.
 */
public class BannerUploadUtil {

    private static final String BANNER_SUBDIR = "banners";
    private static final String ALLOWED_EXT = "jpg|jpeg|png|webp";

    /** Upload ảnh banner vào thư mục banners dưới upload.base-dir.
     * @return URL ảnh (context path + /uploads/banners/filename) nếu thành công,
     *         currentImageUrl nếu không có file nào được upload (giữ ảnh cũ),
     *         null nếu xác thực thất bại.
     */
    public static String uploadImage(Part filePart, String contextPath, String currentImageUrl) {
        if (filePart == null || filePart.getSize() <= 0) {
            return currentImageUrl;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();

        if (!ext.matches(ALLOWED_EXT)) {
            return null; // invalid file type
        }

        try {
            String newFileName = FileUtil.generateFileName(fileName);
            String baseDir = AppConfig.get("upload.base-dir");
            if (baseDir == null || baseDir.isEmpty()) {
                throw new RuntimeException("upload.base-dir not configured in application.properties");
            }

            java.nio.file.Path uploadPath = Paths.get(baseDir, BANNER_SUBDIR);
            Files.createDirectories(uploadPath);
            java.nio.file.Path filePath = uploadPath.resolve(newFileName);
            filePart.write(filePath.toString());

            /** Trả về đường dẫn URL được phục vụ bởi UploadFileServlet (/uploads/*) */
            return contextPath + "/uploads/" + BANNER_SUBDIR + "/" + newFileName;
        } catch (Exception e) {
            throw new RuntimeException("Failed to upload banner image", e);
        }
    }

    /** Xoá file ảnh banner khỏi đĩa dựa vào URL */
    public static void deleteImageFile(String imageUrl) {
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            return;
        }
        try {
            String baseDir = AppConfig.get("upload.base-dir");
            if (baseDir == null || baseDir.isEmpty()) return;

            /** Trích xuất đường dẫn tương đối từ URL: /context/uploads/banners/filename -> banners/filename */
            String urlPath = imageUrl;
            int uploadsIdx = urlPath.indexOf("/uploads/");
            if (uploadsIdx >= 0) {
                urlPath = urlPath.substring(uploadsIdx + "/uploads/".length());
            }

            java.nio.file.Path filePath = Paths.get(baseDir, urlPath);
            Files.deleteIfExists(filePath);
        } catch (Exception e) {
            /** Ghi log nhưng không ném ngoại lệ — lỗi xoá file không nên chặn thao tác DB */
            System.err.println("Warning: Could not delete banner image file: " + e.getMessage());
        }
    }

    /** Xác thực URL chuyển hướng: phải là null/rỗng, hoặc bắt đầu bằng http://, https://, hoặc / */
    public static boolean isValidLink(String link) {
        return link == null || link.trim().isEmpty()
                || link.trim().startsWith("http://")
                || link.trim().startsWith("https://")
                || link.trim().startsWith("/");
    }

    /** Phân tích an toàn tham số integer với giá trị mặc định */
    public static int parseIntSafe(String value, int defaultValue) {
        if (value == null || value.trim().isEmpty()) return defaultValue;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    /** Phân tích an toàn tham số long với giá trị mặc định */
    public static long parseLongSafe(String value, long defaultValue) {
        if (value == null || value.trim().isEmpty()) return defaultValue;
        try {
            return Long.parseLong(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
