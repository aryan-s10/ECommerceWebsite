package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import service.OrderService;

import java.io.IOException;

@WebServlet("/UserDashboardController")
public class UserDashboardController extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("orders", orderService.getOrdersByUserId(user.getId()));
        request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
    }
}
