package code.salecar.service.file;

import code.salecar.config.AppConfig;
import code.salecar.util.FileUtil;
import jakarta.servlet.http.Part;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileStorageService {
    private final String baseDir;

    public FileStorageService() {
        this.baseDir =
                AppConfig.get("upload.base-dir");
    }

    public String saveProductImage(long productId,Part filePart,String type
    ) throws Exception {

        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String newFileName = FileUtil.generateFileName(originalFileName);

        String relativePath =
                        "products/"
                        + exit(productId)
                        + "/"
                        + type
                        + "/"
                        + newFileName;

        Path fullPath = Paths.get(baseDir, relativePath);

        Files.createDirectories(fullPath.getParent());

        filePart.write(fullPath.toString());

        return relativePath;
    }
    private String exit(long i) {
        i++;
        if (i > 1000) return "" + i;
        else if (i > 100) return "00" + i;
        else if (i > 10) return "000" + i;
        else {
            return "0000" + i;
        }
    }

}
