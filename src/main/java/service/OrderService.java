package service;

import model.CartItem;
import model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderService {

    public boolean placeOrder(int userId, List<CartItem> cartItems) {
        String insertOrderSQL = "INSERT INTO orders (user_id, total_amount, order_date) VALUES (?, ?, NOW())";
        String insertItemSQL = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        

        Connection conn = null;
        PreparedStatement orderStmt = null;
        PreparedStatement itemStmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // ✅ Calculate total amount
            double subtotal = 0;
            for (CartItem item : cartItems) {
                subtotal += item.getProduct().getPrice() * item.getQuantity();
            }
            double tax = subtotal * 0.10;
            double totalAmount = subtotal + tax;

            // ✅ Insert into orders table
            orderStmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, totalAmount);
            orderStmt.executeUpdate();

            rs = orderStmt.getGeneratedKeys();
            if (!rs.next()) {
                conn.rollback();
                return false;
            }

            int orderId = rs.getInt(1); // newly generated order ID

            // ✅ Insert into order_items
            itemStmt = conn.prepareStatement(insertItemSQL);
            for (CartItem item : cartItems) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getProduct().getId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setDouble(4, item.getProduct().getPrice());
                itemStmt.addBatch();
            }

            itemStmt.executeBatch();
            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (orderStmt != null) orderStmt.close(); } catch (Exception ignored) {}
            try { if (itemStmt != null) itemStmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(userId);
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                orders.add(order);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}
