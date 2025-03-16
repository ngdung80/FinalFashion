/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CartDAO;
import Model.Cart;
import Model.CartItem;
import Model.ProductCart;
import Model.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Anh Tuan
 */
public class CartController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    Cart cart = (Cart) session.getAttribute("cart");
    UserLogin u = (UserLogin) session.getAttribute("user");

    // Check if the user is logged in
    if (u == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Initialize the cart if it doesn't exist or belongs to another user
    if (cart == null || cart.getUserid() != u.getUserID()) {
        cart = new Cart(u.getUserID());
        session.setAttribute("cart", cart);
    }

    // Get form data
    String productID = request.getParameter("productID");
    int pid = Integer.parseInt(productID);
    String quantity = request.getParameter("quantity");
    String where = request.getParameter("where");
    String selectedSize = request.getParameter("selectedSize"); // Get the selected size
    
    
    
    // Debugging: Print the selected size to the console
            System.out.println("Product ID: " + productID);
            System.out.println("Quantity: " + quantity);
            System.out.println("Selected Size: " + selectedSize);
            System.out.println("Where: " + where);
    // Fetch product details from the database
    CartDAO d = new CartDAO();
    ProductCart pd = d.getItemToAdd(pid);

    // Create a new CartItem with the selected size
    CartItem newItem = new CartItem(
        pd.getProductID(), 
        pd.getTitle(), 
        Integer.parseInt(quantity), 
        pd.getThumbnail(), 
        pd.getPrice(), 
        selectedSize // Include the selected size
    );

    // Debugging: Print the CartItem details to the console
    System.out.println("New CartItem: " + newItem.getTitle() + ", Size: " + newItem.getSelectedSize());

    // Add the item to the cart
    cart.addItem(newItem);

    // Redirect based on the "where" parameter
    if (where.equalsIgnoreCase("detail")) {
        response.sendRedirect("product?service=detail&productId=" + productID);
    } else if (where.equalsIgnoreCase("home")) {
        response.sendRedirect("home");
    } else {
        response.sendRedirect("shop");
    }
}

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
