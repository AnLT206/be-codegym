<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Tự động chuyển hướng ngay đến Servlet quản lý sản phẩm
    response.sendRedirect(request.getContextPath() + "/products");
%>
