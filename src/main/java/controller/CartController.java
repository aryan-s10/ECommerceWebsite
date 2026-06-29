package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Product;
import service.ProductService;

@WebServlet("/CartController")
public class CartController extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productService.getProductById(productId);

            boolean found = false;
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }

            if (!found) {
                cart.add(new CartItem(product, 1));
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("ProductController?action=viewAll");

        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            cart.removeIf(item -> item.getProduct().getId() == productId);

            session.setAttribute("cart", cart);
            response.sendRedirect("cart.jsp");

        } else if ("clear".equals(action)) {
            cart.clear();
            session.setAttribute("cart", cart);
            response.sendRedirect("cart.jsp");

        } else if ("checkout".equals(action)) {
            request.setAttribute("cartItems", cart);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}
