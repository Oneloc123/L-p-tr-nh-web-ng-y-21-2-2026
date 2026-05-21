package code.salecar.controller.file;

import code.salecar.config.AppConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.OutputStream;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/uploads/*")
public class UploadFileServlet
        extends HttpServlet {

    private final String baseDir =
            AppConfig.get("upload.base-dir");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {

        // ví dụ:
        // /products/00406/gallery/a.png
        String requestedFile = request.getPathInfo();
        if (requestedFile == null) {
            response.sendError(404);
            return;
        }

        // bỏ dấu /
        requestedFile = requestedFile.substring(1);

        // full path thật trên disk
        Path filePath = Paths.get(baseDir, requestedFile);
        System.out.println(filePath);

        // check tồn tại
        if (!Files.exists(filePath)) {
            response.sendError(404);
            return;
        }

        // mime type
        String mimeType = Files.probeContentType(filePath);

        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }

        response.setContentType(mimeType);

        // stream file
        OutputStream out = response.getOutputStream();
        Files.copy(filePath, out);
        out.flush();
    }
}