# HƯỚNG DẪN CÀI ĐẶT, CHẠY VÀ NỘP BÀI KIỂM TRA CUỐI MODULE

> **Đề bài:** Phát Triển Ứng Dụng Web với JSP & Servlet - Hệ Thống Quản Lý Sản Phẩm (Product Management)  
> **Cấu trúc:** Chuẩn mô hình MVC Model 2 (Model - View - Controller - DAO)

---

## 1. Cấu Trúc Mã Nguồn Dự Án

```
codegym_be/
├── database/
│   └── product_management.sql          # File SQL tạo Database, Bảng & Dữ liệu mẫu
├── src/
│   └── main/
│       ├── java/com/codegym/
│       │   ├── model/Product.java      # Model thực thể Product (JavaBean)
│       │   ├── dao/
│       │   │   ├── DBConnection.java   # Tiện ích kết nối MySQL qua JDBC
│       │   │   ├── IProductDAO.java    # Interface CRUD sản phẩm
│       │   │   └── ProductDAO.java     # Triển khai SQL với PreparedStatement
│       │   ├── controller/
│       │   │   └── ProductServlet.java # Servlet điều hướng (Create, Read, Update, Delete, Search)
│       │   └── filter/
│       │       └── EncodingFilter.java # Bộ lọc UTF-8 chống lỗi font Tiếng Việt
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── web.xml             # File cấu hình ứng dụng web
│           │   ├── lib/                # Chứa đầy đủ các thư viện .jar (MySQL, JSTL, Servlet API)
│           │   └── classes/            # Các file .class đã được biên dịch sẵn
│           ├── views/
│           │   ├── common/             # Header, Navbar, Footer dùng chung
│           │   └── product/
│           │       ├── list.jsp        # Hiển thị danh sách, tìm kiếm, modal xác nhận xóa
│           │       ├── create.jsp      # Biểu mẫu thêm mới sản phẩm
│           │       └── edit.jsp        # Biểu mẫu cập nhật sản phẩm
│           ├── assets/
│           │   ├── css/style.css       # Giao diện hiện đại, responsive
│           │   └── js/main.js          # Xử lý xác nhận xóa, auto-close alerts
│           └── index.jsp               # Tự động chuyển hướng về /products
├── pom.xml                             # Cấu hình chuẩn Maven
├── build.gradle                        # Cấu hình chuẩn Gradle
├── settings.gradle
├── ProductManagement.war               # File gói ứng dụng Web hoàn chỉnh sẵn sàng chạy
└── [Ma_So_Sinh_Vien]_FinalExam.zip     # File zip nộp bài
```

---

## 2. Bước 1: Khởi Tạo Cơ Sở Dữ Liệu MySQL

1. Mở công cụ quản lý MySQL của bạn (MySQL Workbench, Navicat, phpMyAdmin hoặc Terminal MySQL).
2. Mở và thực thi toàn bộ nội dung file:
   `database/product_management.sql`
3. File SQL sẽ tự động:
   - Tạo cơ sở dữ liệu `product_management` với mã hóa `utf8mb4`.
   - Tạo bảng `products` với các cột:
     - `id` (INT, PRIMARY KEY, AUTO_INCREMENT)
     - `name` (VARCHAR(255), NOT NULL)
     - `price` (DOUBLE, NOT NULL)
     - `quantity` (INT, NOT NULL)
   - Chèn sẵn 10 bản ghi sản phẩm mẫu Tiếng Việt để kiểm thử.

---

## 3. Bước 2: Cấu Hình Tài Khoản Kết Nối MySQL

Mở file:
`src/main/java/com/codegym/dao/DBConnection.java`

Kiểm tra dòng 17-18:
```java
private static final String USERNAME = getEnvOrProp("DB_USER", "root");
private static final String PASSWORD = getEnvOrProp("DB_PASSWORD", "root");
```
- Nếu mật khẩu MySQL trên máy của bạn là rỗng `""` hoặc `"123456"`, hãy sửa lại giá trị mặc định cho đúng.

---

## 4. Bước 3: Chạy Ứng Dụng Trên Apache Tomcat

### Cách 1: Chạy trực tiếp bằng IntelliJ IDEA (Khuyên dùng)
1. Mở IntelliJ IDEA -> chọn **Open** -> trỏ đến thư mục `codegym_be`.
2. IntelliJ sẽ nhận diện file `pom.xml`.
3. Vào menu **Run** -> **Edit Configurations...**:
   - Nhấn dấu **+** -> Chọn **Tomcat Server** -> **Local**.
   - Tại tab **Deployment**: Nhấn dấu **+** -> Chọn **Artifact** -> chọn `ProductManagement:war exploded` (hoặc Deploy file `ProductManagement.war`).
   - Đặt Application context: `/` hoặc `/ProductManagement`.
4. Nhấn **Run** hoặc **Debug**.
5. Trình duyệt sẽ tự động mở trang web tại địa chỉ:
   `http://localhost:8080/products`

### Cách 2: Chạy trực tiếp bằng Eclipse
1. Mở Eclipse -> **File** -> **Import...** -> **Existing Maven Projects** -> trỏ đến thư mục `codegym_be`.
2. Chuột phải vào project -> **Run As** -> **Run on Server** -> Chọn Apache Tomcat 9 (hoặc Tomcat 8.5/10).
3. Nhấn **Finish**.

### Cách 3: Chạy nhanh bằng Apache Tomcat độc lập (Không cần mở IDE)
1. Copy file `ProductManagement.war` (đã được đóng gói sẵn trong thư mục dự án) vào thư mục `webapps` của Apache Tomcat (ví dụ: `C:\apache-tomcat-9.0.xx\webapps\`).
2. Vào thư mục `bin` của Tomcat, chạy `startup.bat` (trên Windows).
3. Mở trình duyệt và truy cập:
   `http://localhost:8080/ProductManagement/products`

---

## 5. Hướng Dẫn Kiểm Thử Đầy Đủ Các Chức Năng

| Chức năng | Thao tác thực hiện | Kết quả mong đợi |
|-----------|--------------------|-------------------|
| **Xem danh sách** | Truy cập `/products` | Hiển thị bảng sản phẩm với ID, Tên, Giá tiền (định dạng VNĐ ₫), Số lượng, Trạng thái (Còn hàng/Hết hàng). |
| **Thêm mới sản phẩm** | Bấm nút **"+ Thêm Sản Phẩm Mới"** -> Điền Tên, Giá, Số lượng -> Bấm **Thêm Sản Phẩm** | Dữ liệu được lưu vào MySQL, tự động chuyển về danh sách và hiện thông báo màu xanh: *"Thêm sản phẩm mới thành công!"*. |
| **Kiểm tra dữ liệu lỗi (Validation)** | Để trống tên hoặc nhập giá âm / số lượng âm | Hệ thống chặn lại, hiển thị thông báo lỗi rõ ràng bằng tiếng Việt, giữ nguyên các giá trị người dùng đã nhập. |
| **Sửa sản phẩm** | Bấm nút **"Sửa"** tại một sản phẩm bất kỳ -> Cập nhật thông tin -> Bấm **Cập Nhật Thông Tin** | Dữ liệu cập nhật vào MySQL, quay về danh sách với thông báo: *"Cập nhật thông tin sản phẩm thành công!"*. |
| **Xóa sản phẩm** | Bấm nút **"Xóa"** tại một sản phẩm | Xuất hiện **Hộp thoại / Modal xác nhận** hỏi rõ tên sản phẩm cần xóa. Chỉ khi bấm **"Đồng Ý Xóa"** thì sản phẩm mới bị xóa khỏi CSDL kèm thông báo *"Xóa sản phẩm thành công!"*. |
| **Tìm kiếm (Bonus)** | Nhập tên vào ô tìm kiếm -> Bấm kính lúp | Bảng lọc các sản phẩm có tên khớp với từ khóa. Có nút "X" để xóa bộ lọc quay về toàn bộ danh sách. |

---

## 6. Hướng Dẫn Đổi Tên File Nộp Bài

Đề bài yêu cầu:
> Tên file nộp: `[Mã_số_sinh_viên]_FinalExam.zip`

File nộp đã được đóng gói sẵn tại thư mục dự án với tên:
`[Ma_So_Sinh_Vien]_FinalExam.zip`

**Bạn chỉ cần:**
Đổi tên file `[Ma_So_Sinh_Vien]_FinalExam.zip` thành mã số sinh viên của bạn trước khi nộp.  
*Ví dụ:*
- Nếu mã số sinh viên là `CG12345` -> Đổi tên thành: `CG12345_FinalExam.zip`
- Nếu mã số là `C1023G1_NguyenVanA` -> Đổi tên thành: `C1023G1_NguyenVanA_FinalExam.zip`

File zip này đã bao gồm toàn bộ:
- Toàn bộ mã nguồn Java, JSP, CSS, JS
- File cấu hình `pom.xml`, `build.gradle`, `web.xml`
- File `product_management.sql` (kèm dữ liệu mẫu)
- File `ProductManagement.war` đã đóng gói sẵn
- Đầy đủ thư viện .jar trong `WEB-INF/lib` để giáo viên chấm bài chạy được ngay mà không gặp bất kỳ lỗi thiếu dependency nào.
