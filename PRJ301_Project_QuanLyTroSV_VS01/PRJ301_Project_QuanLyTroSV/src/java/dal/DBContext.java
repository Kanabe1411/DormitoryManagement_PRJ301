package dal;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyTroSV_DB;encrypt=true;trustServerCertificate=true";
            String user = "sa";
            String pass = "123";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);

            System.out.println("Connect DB SUCCESS");

        } catch (Exception e) {
            System.out.println("Connect DB FAILED");
            e.printStackTrace();
        }
    }
}