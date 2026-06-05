package code.salecar.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class GHNService {


    private static final String GHN_URL = "https://online-gateway.ghn.vn/shiip/public-api/";
    private static final String TOKEN = "f90dd8f4-5a71-11f1-95ac-8a1494473068";
    private static final int SHOP_ID = 6461039;


    // Mặc định: Quận 1, TP.HCM
    private static final int FROM_DISTRICT_ID = 1454;
    private static final String FROM_WARD_CODE = "21211";

    private HttpURLConnection createConnection(String endpoint, String method) throws Exception {
        URL url = new URL(GHN_URL + endpoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod(method);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Token", TOKEN);
        if (SHOP_ID > 0) {
            conn.setRequestProperty("ShopId", String.valueOf(SHOP_ID));
        }
        conn.setDoInput(true);
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(10000);
        return conn;
    }

    private String readResponse(HttpURLConnection conn) throws Exception {
        int responseCode = conn.getResponseCode();
        BufferedReader reader;
        if (responseCode >= 200 && responseCode < 300) {
            reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
        } else {
            reader = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
        }
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();
        return response.toString();
    }

    public String getProvinces() {
        try {
            HttpURLConnection conn = createConnection("master-data/province", "GET");
            conn.setDoOutput(false);
            String response = readResponse(conn);
            conn.disconnect();
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"code\":500,\"message\":\"Loi ket noi GHN: " + e.getMessage() + "\"}";
        }
    }


    public String getDistricts(int provinceId) {
        try {
            HttpURLConnection conn = createConnection("master-data/district", "POST");
            conn.setDoOutput(true);
            String body = "{\"province_id\": " + provinceId + "}";
            try (OutputStream os = conn.getOutputStream()) {
                os.write(body.getBytes(StandardCharsets.UTF_8));
                os.flush();
            }
            String response = readResponse(conn);
            conn.disconnect();
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"code\":500,\"message\":\"Loi ket noi GHN: " + e.getMessage() + "\"}";
        }
    }


    public String getWards(int districtId) {
        try {
            HttpURLConnection conn = createConnection("master-data/ward", "POST");
            conn.setDoOutput(true);
            String body = "{\"district_id\": " + districtId + "}";
            try (OutputStream os = conn.getOutputStream()) {
                os.write(body.getBytes(StandardCharsets.UTF_8));
                os.flush();
            }
            String response = readResponse(conn);
            conn.disconnect();
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"code\":500,\"message\":\"Loi ket noi GHN: " + e.getMessage() + "\"}";
        }
    }


    public long calculateFee(int toDistrictId, String toWardCode) {
        try {
            HttpURLConnection conn = createConnection("v2/shipping-order/fee", "POST");
            conn.setDoOutput(true);

            String body = "{"
                    + "\"from_district_id\": " + FROM_DISTRICT_ID + ","
                    + "\"from_ward_code\": \"" + FROM_WARD_CODE + "\","
                    + "\"to_district_id\": " + toDistrictId + ","
                    + "\"to_ward_code\": \"" + toWardCode + "\","
                    + "\"weight\": 2000,"
                    + "\"service_type_id\": 2,"
                    + "\"insurance_value\": 0"
                    + "}";

            try (OutputStream os = conn.getOutputStream()) {
                os.write(body.getBytes(StandardCharsets.UTF_8));
                os.flush();
            }

            String response = readResponse(conn);
            conn.disconnect();


            if (response.contains("\"code\":200") && response.contains("\"total\":")) {
                int idx = response.indexOf("\"total\":");
                if (idx >= 0) {
                    int start = idx + 8;
                    int end = response.indexOf(",", start);
                    if (end < 0) {
                        end = response.indexOf("}", start);
                    }
                    if (end > start) {
                        String totalStr = response.substring(start, end).trim();
                        return Long.parseLong(totalStr);
                    }
                }
            }

            return 30000;
        } catch (Exception e) {
            e.printStackTrace();
            return 30000;
        }
    }
}
