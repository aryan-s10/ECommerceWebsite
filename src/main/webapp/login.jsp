<%@ page import="model.User" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="navbar.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - ShopEasy</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            padding: 0;
            margin: 0;
        }
        .login-box {
            max-width: 400px;
            margin: 80px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error, .info {
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .error {
            color: red;
        }
        .info {
            color: green;
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user != null) {
%>
    <div class="login-box">
        <div class="info">Already logged in as <%= user.getName() %>. Please <a href="LogoutController">logout</a> to login as a different user.</div>
    </div>
<%
    } else {
%>
    <div class="login-box">
        <h2>Login</h2>

        <% String error = (String) request.getAttribute("errorMessage"); %>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <form action="LoginController" method="post">
            <input type="email" name="email" placeholder="Email" required />
            <input type="password" name="password" placeholder="Password" required />
            <input type="submit" value="Login" />
        </form>
         <p>New user? <a href="register.jsp">Register here</a></p>
    </div>
    
   

<% } %>

</body>
</html>
