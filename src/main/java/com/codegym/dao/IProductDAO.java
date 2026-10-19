package com.codegym.dao;

import com.codegym.model.Product;
import java.sql.SQLException;
import java.util.List;

/**
 * Interface định nghĩa các thao tác CRUD với thực thể Product
 */
public interface IProductDAO {

    /**
     * Lấy toàn bộ danh sách sản phẩm trong cơ sở dữ liệu
     * @return danh sách sản phẩm
     */
    List<Product> selectAllProducts();

    /**
     * Lấy thông tin một sản phẩm theo ID
     * @param id mã sản phẩm
     * @return đối tượng Product nếu tìm thấy, ngược lại trả về null
     */
    Product selectProduct(int id);

    /**
     * Thêm mới một sản phẩm vào cơ sở dữ liệu
     * @param product sản phẩm cần thêm
     * @return true nếu thêm thành công, false nếu thất bại
     * @throws SQLException nếu xảy ra lỗi SQL
     */
    boolean insertProduct(Product product) throws SQLException;

    /**
     * Cập nhật thông tin sản phẩm
     * @param product sản phẩm có thông tin mới
     * @return true nếu cập nhật thành công, false nếu thất bại
     * @throws SQLException nếu xảy ra lỗi SQL
     */
    boolean updateProduct(Product product) throws SQLException;

    /**
     * Xóa sản phẩm khỏi cơ sở dữ liệu theo ID
     * @param id mã sản phẩm cần xóa
     * @return true nếu xóa thành công, false nếu thất bại
     * @throws SQLException nếu xảy ra lỗi SQL
     */
    boolean deleteProduct(int id) throws SQLException;

    /**
     * Tìm kiếm sản phẩm theo tên (hỗ trợ tìm kiếm gần đúng)
     * @param keyword từ khóa tìm kiếm
     * @return danh sách sản phẩm khớp từ khóa
     */
    List<Product> searchByName(String keyword);
}
