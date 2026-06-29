<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="navbar.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding-top: 60px;
        }
        .container {
            background-color: white;
            padding: 40px;
            margin: auto;
            width: 60%;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #28a745;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
        .btn:hover {
            background-color: #0069d9;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>🎉 Order Placed Successfully!</h2>
    <p>Thank you for shopping with us. Your order has been received.</p>
    <a href="index.jsp" class="btn">Continue Shopping</a>
</div>

</body>
</html>
