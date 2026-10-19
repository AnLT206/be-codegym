# Product Management Web Application (JSP & Servlet)

## Overview
This is a complete, production-ready Product Management web application built with **Java Servlet**, **JSP**, **JSTL**, and **MySQL**, adhering to the MVC Model 2 architecture pattern. It fulfills all requirements for the Final Exam of Module 3: Web Application Development with JSP & Servlet.

## Key Features
- **Display Product List**: Lists all products from MySQL with ID, Name, Price (formatted in currency), Quantity, and Stock Status badge.
- **Add Product**: Form with comprehensive input validation (client-side and server-side).
- **Edit Product**: Pre-fills existing data and updates product records securely.
- **Delete Product**: Delete action with modal confirmation preventing accidental deletions.
- **Search by Name**: Real-time filtering by product name.
- **UTF-8 Character Encoding**: Full support for Vietnamese characters across all requests, responses, JSPs, and MySQL connections via `EncodingFilter`.
- **SQL Injection Prevention**: Built entirely with `PreparedStatement` and safe parameter binding.
- **Post-Redirect-Get (PRG) Pattern**: Prevents duplicate form submissions on page refresh.

## Project Architecture
- `com.codegym.model.Product`: JavaBean representing the Product entity.
- `com.codegym.dao.DBConnection`: JDBC connection manager with automatic UTF-8 & Timezone configuration.
- `com.codegym.dao.IProductDAO`: CRUD Interface.
- `com.codegym.dao.ProductDAO`: Concrete DAO implementation with PreparedStatement.
- `com.codegym.controller.ProductServlet`: Central controller managing routing and business actions.
- `com.codegym.filter.EncodingFilter`: Global UTF-8 encoding filter for all endpoints.
- `views/`: JSP views styled with modern Bootstrap 5 and custom CSS.

## Quick Start
1. Execute `database/product_management.sql` in MySQL.
2. Check DB password in `src/main/java/com/codegym/dao/DBConnection.java`.
3. Open in IntelliJ IDEA / Eclipse and run with Apache Tomcat 9/8.5/10.
4. Access `http://localhost:8080/products`.
