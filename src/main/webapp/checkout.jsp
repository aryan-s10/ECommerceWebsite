<%@ page import="model.User" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - ShopEasy</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            background-color: white;
            margin: 100px auto 40px;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            color: #555;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin-top: 25px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .btn:hover {
            background-color: #218838;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container">
    <h2>Checkout</h2>

    <%
        User user = (User) session.getAttribute("user");
        List<model.CartItem> cartItems = (List<model.CartItem>) session.getAttribute("cart");

        double subtotal = 0.0;
        double taxRate = 0.10;
        double tax = 0.0;
        double total = 0.0;

        if (user != null && cartItems != null && !cartItems.isEmpty()) {
    %>
        <p>Confirm your order, <strong><%= user.getName() %></strong>.</p>

        <table style="width:100%; margin-top: 20px; border-collapse: collapse;">
            <tr style="background-color: #f8f8f8;">
                <th style="text-align:left; padding: 10px;">Product</th>
                <th style="text-align:right; padding: 10px;">Price</th>
                <th style="text-align:right; padding: 10px;">Quantity</th>
                <th style="text-align:right; padding: 10px;">Total</th>
            </tr>
            <%
                for (model.CartItem item : cartItems) {
                    double itemTotal = item.getProduct().getPrice() * item.getQuantity();
                    subtotal += itemTotal;
            %>
            <tr>
                <td style="padding: 10px;"><%= item.getProduct().getName() %></td>
                <td style="text-align:right; padding: 10px;">₹<%= item.getProduct().getPrice() %></td>
                <td style="text-align:right; padding: 10px;"><%= item.getQuantity() %></td>
                <td style="text-align:right; padding: 10px;">₹<%= itemTotal %></td>
            </tr>
            <% } %>
        </table>

        <%
            tax = subtotal * taxRate;
            total = subtotal + tax;
        %>

        <div style="text-align:right; margin-top: 20px;">
            <p><strong>Subtotal:</strong> ₹<%= String.format("%.2f", subtotal) %></p>
            <p><strong>Tax (10%):</strong> ₹<%= String.format("%.2f", tax) %></p>
            <p><strong>Total:</strong> ₹<%= String.format("%.2f", total) %></p>
        </div>

        <form action="OrderController" method="post">
            <input type="hidden" name="action" value="placeOrder">
            <button type="submit" class="btn">Place Order</button>
        </form>
    <%
        } else if (user != null) {
    %>
        <p>Your cart is empty. <a href="ProductController?action=viewAll">Go back to shopping</a>.</p>
    <%
        } else {
    %>
        <p>Please <a href="login.jsp">login</a> to proceed with checkout.</p>
    <%
        }
    %>
</div>


</body>
</html>
