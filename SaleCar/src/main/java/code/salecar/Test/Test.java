package code.salecar.Test;

import code.salecar.utils.DBConnection;

import java.sql.Connection;

public class Test {

    public static void main(String[] args) {
        try {
            Connection conn = DBConnection.getConnection();

            if (conn != null)
                System.out.println("✅ Connected database!");
            else
                System.out.println("❌ Connection failed");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}