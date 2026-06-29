<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<jsp:include page="navbar.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>🧾 Your Order History</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 30px;
        }

        h3 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .order-container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 14px 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .no-orders {
            text-align: center;
            font-size: 18px;
            color: #666;
            margin-top: 40px;
        }
    </style>
</head>
<body>

<div class="order-container">
    <h3>🧾 Your Order History</h3>

    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
    %>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Total Bill (₹)</th>
                <th>Order Date</th>
            </tr>
            <% for (Order o : orders) { %>
                <tr>
                    <td><%= o.getId() %></td>
                    <td>₹<%= String.format("%.2f", o.getTotalAmount()) %></td>
                    <td><%= new java.text.SimpleDateFormat("dd MMM yyyy HH:mm").format(o.getOrderDate()) %></td>
                </tr>
            <% } %>
        </table>
    <%
        } else {
    %>
        <p class="no-orders">You haven’t placed any orders yet.</p>
    <%
        }
    %>
</div>

</body>
</html>
