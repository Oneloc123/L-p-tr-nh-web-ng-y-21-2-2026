package code.salecar.util;

import java.util.UUID;

public class FileUtil {
    public static String generateFileName(String originalName) {

        String extension = "";

        int lastDot = originalName.lastIndexOf(".");

        if (lastDot >= 0) {
            extension = originalName.substring(lastDot);
        }

        return UUID.randomUUID() + extension;
    }
}
