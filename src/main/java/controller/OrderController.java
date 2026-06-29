package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.User;
import service.OrderService;

import java.io.IOException;
import java.util.List;

@WebServlet("/OrderController")
public class OrderController extends HttpServlet {
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("checkout".equals(action)) {
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } else {
            response.sendRedirect("cart.jsp"); // fallback if no action or unknown
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("placeOrder".equals(action)) {
            placeOrder(request, response);
        } else {
            // If action is not placeOrder, redirect user to cart or error page
            response.sendRedirect("cart.jsp");
        }
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user != null && cart != null && !cart.isEmpty()) {
            boolean success = orderService.placeOrder(user.getId(), cart);

            if (success) {
                session.removeAttribute("cart"); // Clear the cart
                request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
            } else {
                // Handle failure gracefully
                request.setAttribute("error", "Something went wrong while placing your order.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("cart.jsp");
        }
    }
}
