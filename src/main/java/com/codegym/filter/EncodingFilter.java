package com.codegym.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * Filter tự động thiết lập bảng mã UTF-8 cho toàn bộ request và response,
 * đảm bảo dữ liệu Tiếng Việt có dấu không bị lỗi font hay biến thành dấu hỏi (?)
 */
@WebFilter(filterName = "EncodingFilter", urlPatterns = "/*")
public class EncodingFilter implements Filter {

    private static final String ENCODING = "UTF-8";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding(ENCODING);
        response.setCharacterEncoding(ENCODING);
        response.setContentType("text/html; charset=" + ENCODING);
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Hủy filter khi ứng dụng dừng
    }
}
