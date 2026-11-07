package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;

    public DAO() {
        try {
            if (con == null || con.isClosed()) {
                String dbUrl = "jdbc:mysql://localhost:3306/restman?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";
                String dbClass = "com.mysql.cj.jdbc.Driver";
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, "root", "admin");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}