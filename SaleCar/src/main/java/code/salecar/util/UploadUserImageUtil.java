package code.salecar.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.ServletException;

public class UploadUserImageUtil {
    private static final String BASE_DIR = "D:" + File.separator + "uploads";

    public static String uploadImage(HttpServletRequest request, String partName, String subDir)
            throws ServletException, IOException, IllegalArgumentException {

        Part filePart = request.getPart(partName);
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        long maxFileSize = 4 * 1024 * 1024;
        if (filePart.getSize() > maxFileSize) {
            throw new IllegalArgumentException("Kích thước file không được vượt quá 4MB");
        }

        String fileName = filePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        if (!extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".png")) {
            throw new IllegalArgumentException("Chỉ chấp nhận file ảnh định dạng .jpg, .jpeg, .png");
        }
        String newFileName = UUID.randomUUID().toString() + extension;
        String uploadPath = BASE_DIR + File.separator + subDir;
        File dir = new File(uploadPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        filePart.write(uploadPath + File.separator + newFileName);
        return "/uploads/" + subDir + "/" + newFileName;
    }
}