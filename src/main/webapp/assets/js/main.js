/**
 * JavaScript cho ứng dụng Quản Lý Sản Phẩm
 */

document.addEventListener("DOMContentLoaded", function () {
    // Tự động ẩn các thông báo alert sau 4 giây
    const alerts = document.querySelectorAll(".alert-dismissible");
    alerts.forEach(function (alert) {
        setTimeout(function () {
            try {
                if (window.bootstrap && bootstrap.Alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                } else {
                    alert.style.transition = "opacity 0.5s ease";
                    alert.style.opacity = "0";
                    setTimeout(() => alert.remove(), 500);
                }
            } catch (e) {
                // Ignore
            }
        }, 4000);
    });

    // Lắng nghe sự kiện click vào nút xóa (.btn-delete)
    document.addEventListener("click", function (event) {
        const deleteBtn = event.target.closest(".btn-delete");
        if (deleteBtn) {
            event.preventDefault();
            const id = deleteBtn.getAttribute("data-id");
            const name = deleteBtn.getAttribute("data-name");
            confirmDelete(id, name);
        }
    });
});

/**
 * Hàm mở Modal hoặc hộp thoại xác nhận xóa sản phẩm
 * @param {number} id - ID sản phẩm cần xóa
 * @param {string} name - Tên sản phẩm cần xóa
 */
function confirmDelete(id, name) {
    const modalElement = document.getElementById("deleteConfirmModal");
    if (modalElement && window.bootstrap && bootstrap.Modal) {
        document.getElementById("deleteProductName").textContent = name;
        document.getElementById("deleteProductId").value = id;
        const deleteUrl = `${window.location.pathname}?action=delete&id=${id}`;
        document.getElementById("btnConfirmDelete").setAttribute("href", deleteUrl);

        const modal = new bootstrap.Modal(modalElement);
        modal.show();
    } else {
        // Fallback hộp thoại chuẩn nếu chưa nạp được Bootstrap JS
        const isConfirmed = confirm(`Bạn có chắc chắn muốn xóa sản phẩm "${name}" (ID: ${id}) không?\nHành động này không thể hoàn tác!`);
        if (isConfirmed) {
            window.location.href = `${window.location.pathname}?action=delete&id=${id}`;
        }
    }
}
