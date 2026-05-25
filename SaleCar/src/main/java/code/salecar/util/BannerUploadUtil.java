package code.salecar.util;

import code.salecar.config.AppConfig;
import jakarta.servlet.http.Part;

import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * Shared utility for banner image upload and validation.
 * Uses upload.base-dir from application.properties (modelcar-storage/banners).
 * Files are served via UploadFileServlet at /uploads/banners/*.
 */
public class BannerUploadUtil {

    private static final String BANNER_SUBDIR = "banners";
    private static final String ALLOWED_EXT = "jpg|jpeg|png|webp";

    /**
     * Upload banner image part to the banners directory under upload.base-dir.
     *
     * @return image URL (context path + /uploads/banners/filename) on success,
     *         currentImageUrl if no file uploaded (keeps existing),
     *         null if validation fails (caller should return early).
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

            // Return URL path served by UploadFileServlet (/uploads/*)
            return contextPath + "/uploads/" + BANNER_SUBDIR + "/" + newFileName;
        } catch (Exception e) {
            throw new RuntimeException("Failed to upload banner image", e);
        }
    }

    /**
     * Delete a banner image file from disk given its URL.
     */
    public static void deleteImageFile(String imageUrl) {
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            return;
        }
        try {
            String baseDir = AppConfig.get("upload.base-dir");
            if (baseDir == null || baseDir.isEmpty()) return;

            // Extract relative path from URL: /context/uploads/banners/filename -> banners/filename
            String urlPath = imageUrl;
            int uploadsIdx = urlPath.indexOf("/uploads/");
            if (uploadsIdx >= 0) {
                urlPath = urlPath.substring(uploadsIdx + "/uploads/".length());
            }

            java.nio.file.Path filePath = Paths.get(baseDir, urlPath);
            Files.deleteIfExists(filePath);
        } catch (Exception e) {
            // Log but don't throw — file deletion failure shouldn't block DB operation
            System.err.println("Warning: Could not delete banner image file: " + e.getMessage());
        }
    }

    /**
     * Validate redirect URL: must be null/empty, or start with http://, https://, or /.
     */
    public static boolean isValidLink(String link) {
        return link == null || link.trim().isEmpty()
                || link.trim().startsWith("http://")
                || link.trim().startsWith("https://")
                || link.trim().startsWith("/");
    }

    /**
     * Safely parse an integer parameter with a default fallback.
     */
    public static int parseIntSafe(String value, int defaultValue) {
        if (value == null || value.trim().isEmpty()) return defaultValue;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    /**
     * Safely parse a long parameter with a default fallback.
     */
    public static long parseLongSafe(String value, long defaultValue) {
        if (value == null || value.trim().isEmpty()) return defaultValue;
        try {
            return Long.parseLong(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
