<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Sản Phẩm - Quản Lý Sản Phẩm</title>

    <!-- Bootstrap 5 CSS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

    <!-- Header / Navbar -->
    <jsp:include page="/views/common/navbar.jsp" />

    <main class="container mb-5">
        <div class="form-card">
            <div class="d-flex align-items-center justify-content-between border-bottom pb-3 mb-4">
                <div>
                    <h4 class="mb-1 text-primary fw-bold">
                        <i class="bi bi-pencil-square me-2"></i> Chỉnh Sửa Thông Tin Sản Phẩm
                    </h4>
                    <span class="badge bg-secondary">Mã sản phẩm: #${product.id}</span>
                </div>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-arrow-left"></i> Quay lại danh sách
                </a>
            </div>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                    <div>${errorMessage}</div>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Biểu mẫu cập nhật sản phẩm -->
            <form action="${pageContext.request.contextPath}/products" method="post" id="editProductForm">
                <!-- Action directive cho Servlet -->
                <input type="hidden" name="action" value="edit">

                <!-- ID sản phẩm (hidden) -->
                <input type="hidden" name="id" value="${product.id}">

                <!-- 1. ID hiển thị (chỉ xem) -->
                <div class="mb-3">
                    <label class="form-label text-muted">ID Sản Phẩm (Không thể sửa đổi)</label>
                    <input type="text" class="form-control bg-light" value="#${product.id}" disabled readonly>
                </div>

                <!-- 2. Tên sản phẩm -->
                <div class="mb-3">
                    <label for="name" class="form-label">
                        Tên Sản Phẩm <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-tag"></i></span>
                        <input type="text" class="form-control" id="name" name="name" 
                               value="${product.name}" required maxlength="255">
                    </div>
                    <div class="form-text">Cập nhật tên sản phẩm nếu cần (tối đa 255 ký tự).</div>
                </div>

                <!-- 3. Giá sản phẩm -->
                <div class="mb-3">
                    <label for="price" class="form-label">
                        Giá Bán (VNĐ) <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-cash"></i></span>
                        <input type="number" class="form-control" id="price" name="price" 
                               value="${priceInput != null ? priceInput : product.price}" 
                               required min="0.01" step="any">
                        <span class="input-group-text">₫</span>
                    </div>
                    <div class="form-text">Giá bán phải là số dương lớn hơn 0.</div>
                </div>

                <!-- 4. Số lượng sản phẩm -->
                <div class="mb-4">
                    <label for="quantity" class="form-label">
                        Số Lượng <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-boxes"></i></span>
                        <input type="number" class="form-control" id="quantity" name="quantity" 
                               value="${quantityInput != null ? quantityInput : product.quantity}" 
                               required min="0" step="1">
                        <span class="input-group-text">chiếc</span>
                    </div>
                    <div class="form-text">Số lượng sản phẩm còn trong kho (phải &gt;= 0).</div>
                </div>

                <!-- Nút Submit và Hủy -->
                <div class="d-flex justify-content-end gap-2 pt-2 border-top">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                        <i class="bi bi-x-circle"></i> Hủy Bỏ
                    </a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check2-square"></i> Cập Nhật Thông Tin
                    </button>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
