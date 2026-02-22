package code.salecar.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.io.InputStream;

public class DBConnection {

    private static String url;
    private static String username;
    private static String password;
    private static String driver;

    static {
        try {
            Properties props = new Properties();

            InputStream input =
                    DBConnection.class
                            .getClassLoader()
                            .getResourceAsStream("db.properties");

            props.load(input);

            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
            driver = props.getProperty("db.driver");

            Class.forName(driver);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(url, username, password);
    }
}
