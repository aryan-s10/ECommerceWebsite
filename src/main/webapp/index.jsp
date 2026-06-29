<%@ page import="model.User" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to ShopEasy</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            text-align: center;
            padding-top: 50px;
        }
        .container {
            background-color: white;
            padding: 40px;
            margin: auto;
            width: 50%;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
        h1 {
            color: #333;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin: 10px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
%>

<div class="container">
    <h1>Welcome to ShopEasy</h1>
    <p>Your one-stop shop for everything!</p>

    <% if (user != null) { %>
        <h2>Hello, <%= user.getName() %> 👋</h2>
        <a href="ProductController?action=viewAll" class="btn">Browse Products</a>
        <a href="LogoutController" class="btn">Logout</a>
    <% } else { %>
        <a href="login.jsp" class="btn">Login</a>
        <a href="register.jsp" class="btn">Register</a>
        <a href="ProductController?action=viewAll" class="btn">Browse Products</a>
    <% } %>
</div>

</body>
</html>
