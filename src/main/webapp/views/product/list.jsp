<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm - Quản Lý Sản Phẩm</title>

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

        <!-- Thông báo thành công nếu có -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                <div>${successMessage}</div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Thông báo lỗi nếu có -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                <div>${errorMessage}</div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Khung chính danh sách -->
        <div class="main-card">
            <div class="card-header d-flex flex-wrap align-items-center justify-content-between gap-3">
                <div>
                    <h4 class="card-title text-primary">
                        <i class="bi bi-list-task me-1"></i> Danh Sách Sản Phẩm
                    </h4>
                    <small class="text-muted">Tổng số sản phẩm: <strong>${products != null ? products.size() : 0}</strong></small>
                </div>

                <div class="d-flex flex-wrap align-items-center gap-2">
                    <!-- Form tìm kiếm theo tên sản phẩm -->
                    <form class="d-flex" action="${pageContext.request.contextPath}/products" method="get">
                        <input type="hidden" name="action" value="search">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control form-control-sm" 
                                   placeholder="Tìm kiếm theo tên..." value="${keyword}">
                            <button class="btn btn-outline-primary btn-sm" type="submit" title="Tìm kiếm">
                                <i class="bi bi-search"></i>
                            </button>
                            <c:if test="${not empty keyword}">
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm" title="Xóa bộ lọc">
                                    <i class="bi bi-x-circle"></i>
                                </a>
                            </c:if>
                        </div>
                    </form>

                    <!-- Nút Thêm Mới Sản Phẩm -->
                    <a href="${pageContext.request.contextPath}/products?action=create" class="btn btn-primary btn-sm d-flex align-items-center gap-1">
                        <i class="bi bi-plus-circle"></i>
                        <span>Thêm Sản Phẩm Mới</span>
                    </a>
                </div>
            </div>

            <!-- Bảng dữ liệu sản phẩm -->
            <div class="table-responsive">
                <table class="table table-custom table-hover align-middle">
                    <thead>
                        <tr>
                            <th scope="col" class="text-center" style="width: 80px;">ID</th>
                            <th scope="col">Tên Sản Phẩm</th>
                            <th scope="col" class="text-end" style="width: 180px;">Giá Bán</th>
                            <th scope="col" class="text-center" style="width: 140px;">Số Lượng</th>
                            <th scope="col" class="text-center" style="width: 140px;">Trạng Thái</th>
                            <th scope="col" class="text-center" style="width: 180px;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty products}">
                                <c:forEach var="prod" items="${products}">
                                    <tr>
                                        <!-- ID -->
                                        <td class="text-center fw-bold text-muted">#${prod.id}</td>

                                        <!-- Tên sản phẩm -->
                                        <td>
                                            <span class="fw-semibold text-dark">${prod.name}</span>
                                        </td>

                                        <!-- Giá sản phẩm (định dạng tiền tệ VNĐ) -->
                                        <td class="text-end fw-bold text-primary">
                                            <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>

                                        <!-- Số lượng -->
                                        <td class="text-center">
                                            <span class="fw-medium">${prod.quantity}</span>
                                        </td>

                                        <!-- Trạng thái còn hàng / hết hàng -->
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${prod.quantity > 0}">
                                                    <span class="badge badge-stock badge-in-stock">
                                                        <i class="bi bi-check2-circle"></i> Còn hàng
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-stock badge-out-of-stock">
                                                        <i class="bi bi-x-circle"></i> Hết hàng
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <!-- Thao tác: Sửa & Xóa -->
                                        <td class="text-center">
                                            <div class="d-inline-flex gap-2">
                                                <!-- Nút Sửa -->
                                                <a href="${pageContext.request.contextPath}/products?action=edit&id=${prod.id}" 
                                                   class="btn-action btn-action-edit" title="Sửa sản phẩm">
                                                    <i class="bi bi-pencil-square"></i>
                                                    <span>Sửa</span>
                                                </a>

                                                <!-- Nút Xóa có xác nhận -->
                                                <button type="button" 
                                                        class="btn-action btn-action-delete border-0 btn-delete" 
                                                        data-id="${prod.id}" 
                                                        data-name="<c:out value='${prod.name}' />" 
                                                        title="Xóa sản phẩm">
                                                    <i class="bi bi-trash"></i>
                                                    <span>Xóa</span>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <div class="mb-2">
                                            <i class="bi bi-inbox fs-1 text-secondary opacity-50"></i>
                                        </div>
                                        <p class="mb-2 fs-6">Chưa có sản phẩm nào trong cơ sở dữ liệu!</p>
                                        <c:if test="${not empty keyword}">
                                            <p class="small text-danger">Không tìm thấy sản phẩm nào khớp với từ khóa "<strong>${keyword}</strong>".</p>
                                            <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-outline-primary">Xem tất cả</a>
                                        </c:if>
                                        <c:if test="${empty keyword}">
                                            <a href="${pageContext.request.contextPath}/products?action=create" class="btn btn-sm btn-primary">
                                                <i class="bi bi-plus-circle"></i> Thêm sản phẩm đầu tiên
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

    </main>

    <!-- Modal Xác Nhận Xóa Sản Phẩm -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="deleteModalLabel">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> Xác Nhận Xóa Sản Phẩm
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <p class="mb-2">Bạn có chắc chắn muốn xóa sản phẩm sau khỏi hệ thống?</p>
                    <div class="alert alert-light border text-dark fw-bold" id="deleteProductName">
                        <!-- Tên sản phẩm sẽ được gán động bằng JS -->
                    </div>
                    <small class="text-danger">
                        <i class="bi bi-info-circle"></i> Hành động này sẽ xóa vĩnh viễn sản phẩm khỏi cơ sở dữ liệu và không thể hoàn tác.
                    </small>
                    <input type="hidden" id="deleteProductId" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                        <i class="bi bi-x-lg"></i> Hủy Bỏ
                    </button>
                    <a id="btnConfirmDelete" href="#" class="btn btn-danger btn-sm">
                        <i class="bi bi-trash"></i> Đồng Ý Xóa
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
