<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page session="true" %>
<jsp:include page="navbar.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration - ShopEasy</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eaeaea;
            margin: 0;
            padding: 0;
        }

        .content {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 70px);
        }

        .register-box {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            width: 400px;
        }

        h2 {
            margin-bottom: 25px;
            color: #333;
            text-align: center;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
        }

        .info {
            color: green;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
        }

        .login-link {
            margin-top: 15px;
            text-align: center;
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user != null) {
%>
    <div class="content">
        <div class="register-box">
            <div class="info">
                You are already logged in as <%= user.getName() %>.<br>
                Please <a href="LogoutController">logout</a> to create a new account.
            </div>
        </div>
    </div>
<%
    } else {
%>

<div class="content">
    <div class="register-box">
        <h2>Create Your Account</h2>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <form action="RegisterController" method="post">
            <input type="text" name="name" placeholder="Full Name" required />
            <input type="email" name="email" placeholder="Email Address" required />
            <input type="text" name="phone" placeholder="Phone Number" required />
            <input type="password" name="password" placeholder="Password" required />
            <input type="submit" value="Register" />
        </form>

        <div class="login-link">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
</div>

<% } %>

</body>
</html>
