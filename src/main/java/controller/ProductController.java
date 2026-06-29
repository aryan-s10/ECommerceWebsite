package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet("/ProductController")
public class ProductController extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) action = "viewAll";

        switch (action) {
            case "viewAll":
                List<Product> products = productService.getAllProducts();
                request.setAttribute("productList", products);
                request.getRequestDispatcher("products.jsp").forward(request, response);
                break;

            case "view":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Product product = productService.getProductById(id);
                    if (product != null) {
//                        request.setAttribute("product", product);
//                        request.getRequestDispatcher("productDetails.jsp").forward(request, response);
//                        
                        request.setAttribute("productList", productService.getAllProducts());
                        request.getRequestDispatcher("products.jsp").forward(request, response);

                    } else {
                        response.sendRedirect("products.jsp?error=notfound");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("products.jsp?error=invalidid");
                }
                break;

            default:
                response.sendRedirect("index.jsp");
        }
    }
}
