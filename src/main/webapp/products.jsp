<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<jsp:include page="navbar.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            margin: 0;
        }
        .products {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            padding: 20px;
        }
        .card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            width: 250px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .card img {
            max-width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 4px;
        }
        .card h3 {
            margin: 10px 0 5px;
        }
        .card p {
            font-size: 14px;
            color: #555;
        }
        .card span {
            font-weight: bold;
            color: #007bff;
        }
        .btn {
            margin-top: 10px;
            display: inline-block;
            background-color: #28a745;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <h1 style="text-align:center;">🛒 Available Products</h1>
    <div class="products">
        <%
            List<Product> products = (List<Product>) request.getAttribute("productList");
            if (products != null) {
                for (Product p : products) {
        %>
        <div class="card">
            <img src="<%= p.getImage() %>" alt="Product Image">
            <h3><%= p.getName() %></h3>
            <p><%= p.getDescription() %></p>
            <p>Price: ₹<span><%= p.getPrice() %></span></p>
            <a href="CartController?action=add&id=<%= p.getId() %>" class="btn">Add to Cart</a>
        </div>
        <%
                }
            } else {
        %>
        <p>No products found.</p>
        <%
            }
        %>
    </div>

</body>
</html>
