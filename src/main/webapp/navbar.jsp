<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>

<style>
    nav {
        background-color: #343a40;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: white;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        box-sizing: border-box;
    }

    .nav-left, .nav-right {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    nav a {
        color: white;
        text-decoration: none;
        padding: 6px 10px;
        border-radius: 4px;
        transition: background-color 0.2s ease;
        white-space: nowrap;
    }

    nav a:hover {
        background-color: #495057;
    }

    nav span {
        color: #ffc107;
        margin-right: 10px;
        font-weight: bold;
    }
</style>

<nav>
    <div class="nav-left">
        <a href="index.jsp">ShopEasy</a>
        <a href="ProductController?action=viewAll">Products</a>
        
        <a href="cart.jsp">Cart</a>
        <% if (user != null) { %>
            <a href="UserDashboardController">Dashboard</a>
        <% } %>
    </div>
    <div class="nav-right">
        <% if (user != null) { %>
            <span>Hello, <%= user.getName() %>!</span>
            <a href="LogoutController">Logout</a>
        <% } else { %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        <% } %>
    </div>
</nav>

<!-- Spacer to push content below fixed navbar -->
<div style="height: 60px;"></div>
