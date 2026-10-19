package com.codegym.controller;

import com.codegym.dao.IProductDAO;
import com.codegym.dao.ProductDAO;
import com.codegym.model.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Controller chính xử lý các yêu cầu liên quan đến quản lý sản phẩm
 * Áp dụng mô hình MVC (Model-View-Controller)
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "search":
                    searchProducts(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "create":
                    createProduct(request, response);
                    break;
                case "edit":
                    updateProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    /**
     * Hiển thị danh sách tất cả sản phẩm
     */
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> listProduct = productDAO.selectAllProducts();
        request.setAttribute("products", listProduct);

        // Bắt thông báo từ tham số URL (sau khi redirect)
        String messageCode = request.getParameter("message");
        if (messageCode != null) {
            switch (messageCode) {
                case "create_success":
                    request.setAttribute("successMessage", "Thêm sản phẩm mới thành công!");
                    break;
                case "update_success":
                    request.setAttribute("successMessage", "Cập nhật thông tin sản phẩm thành công!");
                    break;
                case "delete_success":
                    request.setAttribute("successMessage", "Xóa sản phẩm thành công!");
                    break;
                case "not_found":
                    request.setAttribute("errorMessage", "Không tìm thấy sản phẩm yêu cầu!");
                    break;
                case "error":
                    request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình xử lý!");
                    break;
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/list.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Hiển thị biểu mẫu thêm mới sản phẩm
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/create.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Xử lý lưu sản phẩm mới vào CSDL
     */
    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");

        String errorMessage = validateProductInput(name, priceStr, quantityStr);
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("name", name);
            request.setAttribute("price", priceStr);
            request.setAttribute("quantity", quantityStr);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/create.jsp");
            dispatcher.forward(request, response);
            return;
        }

        double price = Double.parseDouble(priceStr.trim());
        int quantity = Integer.parseInt(quantityStr.trim());

        Product newProduct = new Product(name.trim(), price, quantity);
        boolean success = productDAO.insertProduct(newProduct);

        if (success) {
            // Áp dụng mô hình PRG (Post-Redirect-Get) tránh gửi lại form khi F5
            response.sendRedirect(request.getContextPath() + "/products?message=create_success");
        } else {
            response.sendRedirect(request.getContextPath() + "/products?message=error");
        }
    }

    /**
     * Hiển thị biểu mẫu chỉnh sửa sản phẩm đã có
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products?message=not_found");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products?message=not_found");
            return;
        }

        Product existingProduct = productDAO.selectProduct(id);
        if (existingProduct == null) {
            response.sendRedirect(request.getContextPath() + "/products?message=not_found");
            return;
        }

        request.setAttribute("product", existingProduct);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/edit.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Xử lý cập nhật thông tin sản phẩm vào CSDL
     */
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");

        int id;
        try {
            id = Integer.parseInt(idStr.trim());
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/products?message=not_found");
            return;
        }

        String errorMessage = validateProductInput(name, priceStr, quantityStr);
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            Product product = new Product(id, name, 0, 0);
            request.setAttribute("product", product);
            request.setAttribute("priceInput", priceStr);
            request.setAttribute("quantityInput", quantityStr);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/edit.jsp");
            dispatcher.forward(request, response);
            return;
        }

        double price = Double.parseDouble(priceStr.trim());
        int quantity = Integer.parseInt(quantityStr.trim());

        Product product = new Product(id, name.trim(), price, quantity);
        boolean success = productDAO.updateProduct(product);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/products?message=update_success");
        } else {
            response.sendRedirect(request.getContextPath() + "/products?message=error");
        }
    }

    /**
     * Xử lý xóa sản phẩm
     */
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr.trim());
                boolean success = productDAO.deleteProduct(id);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/products?message=delete_success");
                    return;
                }
            } catch (NumberFormatException e) {
                // ID không hợp lệ
            }
        }
        response.sendRedirect(request.getContextPath() + "/products?message=error");
    }

    /**
     * Tìm kiếm sản phẩm theo tên
     */
    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Product> listProduct;
        if (keyword != null && !keyword.trim().isEmpty()) {
            listProduct = productDAO.searchByName(keyword.trim());
            request.setAttribute("keyword", keyword.trim());
        } else {
            listProduct = productDAO.selectAllProducts();
        }

        request.setAttribute("products", listProduct);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/list.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Phương thức kiểm tra tính hợp lệ của dữ liệu đầu vào (Validation)
     */
    private String validateProductInput(String name, String priceStr, String quantityStr) {
        if (name == null || name.trim().isEmpty()) {
            return "Tên sản phẩm không được để trống!";
        }
        if (name.trim().length() > 255) {
            return "Tên sản phẩm không được vượt quá 255 ký tự!";
        }

        if (priceStr == null || priceStr.trim().isEmpty()) {
            return "Giá sản phẩm không được để trống!";
        }
        try {
            double price = Double.parseDouble(priceStr.trim());
            if (price <= 0) {
                return "Giá sản phẩm phải là số dương lớn hơn 0!";
            }
        } catch (NumberFormatException e) {
            return "Giá sản phẩm phải là một số hợp lệ!";
        }

        if (quantityStr == null || quantityStr.trim().isEmpty()) {
            return "Số lượng sản phẩm không được để trống!";
        }
        try {
            int quantity = Integer.parseInt(quantityStr.trim());
            if (quantity < 0) {
                return "Số lượng sản phẩm không được là số âm (phải >= 0)!";
            }
        } catch (NumberFormatException e) {
            return "Số lượng sản phẩm phải là một số nguyên hợp lệ!";
        }

        return null; // Không có lỗi
    }
}
