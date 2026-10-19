package com.codegym.model;

import java.io.Serializable;

/**
 * Model đại diện cho thực thể Sản phẩm (Product)
 * Tương ứng với bảng `products` trong cơ sở dữ liệu MySQL
 */
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private double price;
    private int quantity;

    // Constructor mặc định (no-arg constructor)
    public Product() {
    }

    // Constructor không có id (sử dụng khi thêm mới sản phẩm - id tự tăng AUTO_INCREMENT)
    public Product(String name, double price, int quantity) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    // Constructor đầy đủ tham số (sử dụng khi lấy dữ liệu từ DB hoặc cập nhật)
    public Product(int id, String name, double price, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                '}';
    }
}
