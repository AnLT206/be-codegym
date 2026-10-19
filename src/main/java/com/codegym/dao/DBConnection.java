package com.codegym.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp tiện ích quản lý kết nối cơ sở dữ liệu MySQL qua JDBC
 */
public class DBConnection {

    // =========================================================================
    // CẤU HÌNH THÔNG SỐ KẾT NỐI MYSQL
    // Lưu ý: Thầy cô / Sinh viên có thể đổi USERNAME và PASSWORD tại đây
    // hoặc thiết lập qua Environment Variables (DB_USER, DB_PASSWORD)
    // =========================================================================
    private static final String HOST = getEnvOrProp("DB_HOST", "localhost");
    private static final String PORT = getEnvOrProp("DB_PORT", "3306");
    private static final String DATABASE_NAME = getEnvOrProp("DB_NAME", "product_management");
    private static final String USERNAME = getEnvOrProp("DB_USER", "root");
    private static final String PASSWORD = getEnvOrProp("DB_PASSWORD", "root"); // Đổi thành "" hoặc "123456" nếu cần

    // Chuỗi kết nối JDBC với cấu hình hỗ trợ Tiếng Việt UTF-8 và tránh lỗi SSL / Timezone
    private static final String JDBC_URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE_NAME
            + "?useUnicode=true"
            + "&characterEncoding=UTF-8"
            + "&useSSL=false"
            + "&serverTimezone=UTC"
            + "&allowPublicKeyRetrieval=true";

    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    private static String getEnvOrProp(String key, String defaultValue) {
        String val = System.getProperty(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }
        val = System.getenv(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }
        return defaultValue;
    }

    // Khởi tạo Driver một lần duy nhất
    static {
        try {
            Class.forName(JDBC_DRIVER);
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy MySQL JDBC Driver!");
            e.printStackTrace();
        }
    }

    /**
     * Mở và trả về đối tượng Connection tới cơ sở dữ liệu
     * @return Connection
     * @throws SQLException nếu xảy ra lỗi kết nối
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
    }

    /**
     * Phương thức kiểm tra kết nối CSDL (dùng để test)
     */
    public static void main(String[] args) {
        try (Connection conn = getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Kết nối CSDL MySQL thành công!");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi kết nối CSDL MySQL: " + e.getMessage());
        }
    }
}
