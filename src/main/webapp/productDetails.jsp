<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Details - ShopEasy</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            display: flex;
            overflow: hidden;
        }

        .product-image {
            flex: 1;
            padding: 20px;
        }

        .product-image img {
            width: 100%;
            height: auto;
            border-radius: 8px;
        }

        .product-info {
            flex: 2;
            padding: 30px;
        }

        .product-info h2 {
            margin-top: 0;
            color: #333;
        }

        .product-info p {
            margin: 10px 0;
            color: #555;
        }

        .price {
            font-size: 22px;
            font-weight: bold;
            color: #007bff;
        }

        .add-to-cart-form {
            margin-top: 20px;
        }

        .add-to-cart-form input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        .add-to-cart-form input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<%
    Product product = (Product) request.getAttribute("product");
    if (product != null) {
%>
    <div class="container">
        <div class="product-image">
            <img src="<%= product.getImage() %>" alt="Product Image">
        </div>
        <div class="product-info">
            <h2><%= product.getName() %></h2>
            <p><%= product.getDescription() %></p>
            <p class="price">₹ <%= product.getPrice() %></p>

            <form class="add-to-cart-form" action="CartController" method="post">
                <input type="hidden" name="action" value="add" />
                <input type="hidden" name="productId" value="<%= product.getId() %>" />
                <input type="submit" value="Add to Cart" />
            </form>
        </div>
    </div>
<%
    } else {
%>
    <p style="text-align: center; margin-top: 50px;">Product not found.</p>
<%
    }
%>

</body>
</html>
