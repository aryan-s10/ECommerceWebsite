package service;

import model.CartItem;
import model.Product;

import jakarta.servlet.http.HttpSession;
import java.util.*;

public class CartService {

    private static final String CART_SESSION_KEY = "cart";

    // Get cart from session (or create new if not exists)
    public List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute(CART_SESSION_KEY);
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute(CART_SESSION_KEY, cart);
        }
        return cart;
    }

    // Add product to cart
    public void addToCart(HttpSession session, Product product, int quantity) {
        List<CartItem> cart = getCart(session);
        for (CartItem item : cart) {
            if (item.getProduct().getId() == product.getId()) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        cart.add(new CartItem(product, quantity));
    }

    // Remove product from cart
    public void removeFromCart(HttpSession session, int productId) {
        List<CartItem> cart = getCart(session);
        cart.removeIf(item -> item.getProduct().getId() == productId);
    }

    // Clear cart
    public void clearCart(HttpSession session) {
        session.removeAttribute(CART_SESSION_KEY);
    }

    // Calculate total
    public double getCartTotal(HttpSession session) {
        List<CartItem> cart = getCart(session);
        double total = 0;
        for (CartItem item : cart) {
            total += item.getTotalPrice();
        }
        return total;
    }
}
