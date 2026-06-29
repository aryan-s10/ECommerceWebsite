<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="model.CartItem"%>
<%@ page import="model.Product"%>
<jsp:include page="navbar.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Cart</title>
<style>
body {
	font-family: Arial, sans-serif;
	background: #f5f5f5;
	padding: 30px;
}

.cart-container {
	max-width: 800px;
	margin: auto;
	background: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table th, table td {
	padding: 12px;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

table th {
	background-color: #f0f0f0;
}

.actions a {
	color: white;
	background-color: #dc3545;
	padding: 6px 12px;
	text-decoration: none;
	border-radius: 4px;
	font-size: 13px;
}

.actions a:hover {
	background-color: #c82333;
}

.total {
	text-align: right;
	margin-top: 20px;
	font-size: 18px;
	font-weight: bold;
}

.checkout-btn {
	display: block;
	width: 200px;
	margin: 30px auto 0;
	text-align: center;
	background-color: #007bff;
	color: white;
	padding: 12px 20px;
	text-decoration: none;
	border-radius: 6px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

.checkout-btn:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>

	<div class="cart-container">
		<h1>🛒 Your Shopping Cart</h1>

		<%
		List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
		double total = 0;
		if (cart != null && !cart.isEmpty()) {
		%>
		<table>
			<tr>
				<th>Product</th>
				<th>Price (₹)</th>
				<th>Quantity</th>
				<th>Total</th>
				<th>Action</th>
			</tr>
			<%
			for (CartItem item : cart) {
				double itemTotal = item.getProduct().getPrice() * item.getQuantity();
				total += itemTotal;
			%>
			<tr>
				<td><%=item.getProduct().getName()%></td>
				<td><%=item.getProduct().getPrice()%></td>
				<td><%=item.getQuantity()%></td>
				<td><%=itemTotal%></td>
				<td class="actions"><a
					href="CartController?action=remove&id=<%=item.getProduct().getId()%>">Remove</a>
				</td>
			</tr>
			<%
			}
			%>
		</table>

		<div class="total">
			Total Amount: ₹<%=total%>
		</div>

		<!-- ✅ Place Order form 
		<form action="checkout.jsp" method="get"
			style="text-align: center; margin-top: 30px;">
			<button type="submit" class="checkout-btn">Proceed to
				Checkout</button>
		</form> -->
		<form action="OrderController" method="get">
    <input type="hidden" name="action" value="checkout">
    <button type="submit" class="checkout-btn">Proceed to Checkout</button>
</form>
		

		<%
		} else {
		%>
		<p style="text-align: center; font-size: 18px;">Your cart is
			empty.</p>
		<%
		}
		%>
	</div>

</body>
</html>
