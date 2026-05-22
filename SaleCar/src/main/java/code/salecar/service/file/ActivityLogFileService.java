package code.salecar.service.file;

import code.salecar.config.AppConfig;
import code.salecar.model.product.entity.ActivityLog;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ActivityLogFileService {

    private final String baseDir;

    private static final SimpleDateFormat FORMAT =
            new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public ActivityLogFileService() {

        this.baseDir =
                AppConfig.get("upload.base-dir");
    }

    public void writeLog(
            long productId,
            ActivityLog log
    ) {

        try {

            Path logPath = buildLogPath(productId);

            Files.createDirectories(logPath.getParent());

            BufferedWriter bw =
                    Files.newBufferedWriter(
                            logPath,
                            java.nio.file.StandardOpenOption.CREATE,
                            java.nio.file.StandardOpenOption.APPEND
                    );

            String line =
                    escape(log.getAction()) + "|" +
                            FORMAT.format(log.getTimestamp()) + "|" +
                            escape(log.getUser()) + "|" +
                            escape(log.getDetails());

            bw.write(line);
            bw.newLine();
            bw.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ActivityLog> readLogs(
            long productId
    ) {

        List<ActivityLog> logs =
                new ArrayList<>();

        try {
            Path logPath = buildLogPath(productId);

            if (!Files.exists(logPath)) {
                return logs;
            }

            BufferedReader br = Files.newBufferedReader(logPath);

            String line;

            while ((line = br.readLine()) != null) {

                String[] parts = line.split("\\|", 4);

                if (parts.length < 4) {
                    continue;
                }

                ActivityLog log = new ActivityLog();

                log.setAction(unescape(parts[0]));
                log.setTimestamp(FORMAT.parse(parts[1]));
                log.setUser(unescape(parts[2]));
                log.setDetails(unescape(parts[3]));

                logs.add(log);
            }

            br.close();

            Collections.reverse(logs);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return logs;
    }

    private Path buildLogPath(long productId) {

        return Paths.get(
                baseDir,
                "products",
                formatProductId(productId),
                "logs",
                "activity.log"
        );
    }

    private String formatProductId(long id) {

        id++;

        if (id > 1000) {
            return "" + id;
        } else if (id > 100) {
            return "00" + id;
        } else if (id > 10) {
            return "000" + id;
        }

        return "0000" + id;
    }

    private String escape(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("|", "\\|")
                .replace("\n", " ");
    }

    private String unescape(String value) {

        return value
                .replace("\\|", "|")
                .replace("\\\\", "\\");
    }
}