-- ========================================================
-- BÀI KIỂM TRA CUỐI MODULE 3: PHÁT TRIỂN ỨNG DỤNG WEB VỚI JSP & SERVLET
-- CƠ SỞ DỮ LIỆU: QUẢN LÝ SẢN PHẨM (product_management)
-- ========================================================

-- 1. Tạo cơ sở dữ liệu nếu chưa tồn tại (sử dụng bảng mã utf8mb4 hỗ trợ tiếng Việt đầy đủ)
CREATE DATABASE IF NOT EXISTS product_management
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 2. Sử dụng cơ sở dữ liệu vừa tạo
USE product_management;

-- 3. Xóa bảng cũ nếu đã tồn tại để tránh xung đột dữ liệu
DROP TABLE IF EXISTS products;

-- 4. Tạo bảng products theo đúng yêu cầu đề bài
-- id: PRIMARY KEY, AUTO_INCREMENT
-- name: Tên sản phẩm
-- price: Giá sản phẩm
-- quantity: Số lượng sản phẩm
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    quantity INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Thêm dữ liệu mẫu ban đầu để kiểm thử
INSERT INTO products (name, price, quantity) VALUES
('iPhone 15 Pro Max 256GB', 29990000, 15),
('Samsung Galaxy S24 Ultra', 27490000, 20),
('Laptop Asus Zenbook 14 OLED', 24990000, 10),
('MacBook Air M3 13 inch 16GB', 31500000, 8),
('Bàn phím cơ Akko MonsGeek M1W', 2150000, 35),
('Chuột không dây Logitech MX Master 3S', 2390000, 42),
('Màn hình Dell UltraSharp U2724D 2K', 9850000, 12),
('Tai nghe chống ồn Sony WH-1000XM5', 6890000, 18),
('Loa Bluetooth JBL Charge 5', 3490000, 25),
('Ổ cứng di động SSD Kingston XS1000 1TB', 1890000, 50);

-- 6. Truy vấn kiểm tra dữ liệu mẫu
SELECT * FROM products;
