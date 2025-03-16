/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CartDAO;
import Model.Cart;
import Model.ProductCart;
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
public class RemoveItems extends HttpServlet {

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
            out.println("<title>Servlet RemoveItems</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RemoveItems at " + request.getContextPath() + "</h1>");
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
        String productID = request.getParameter("productID");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {

            cart.removeItem(Integer.parseInt(productID));
            session.setAttribute("cart", cart);
            response.sendRedirect("mycart");
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
        String productID = request.getParameter("productID");
        String quantity = request.getParameter("quantity");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        CartDAO d = new CartDAO();
        ProductCart pc = d.getItemToAdd(Integer.parseInt(productID));
        int availQuantity = pc.getQuantity();

        if (cart != null) {

            int qty = Integer.parseInt(quantity);

            if (qty > 0) {
                if (qty <= availQuantity) {
                    cart.updateQuantityItem(Integer.parseInt(productID), qty);
                    session.setAttribute("cart", cart);
                    response.setContentType("application/json");
                    response.getWriter().write("{\"status\":\"success\"}");
                } else {

                    response.setContentType("application/json");
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"Số lượng sản phẩm vượt quá số lượng có sẵn.\"}");
                }
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Số lượng sản phẩm không được nhỏ hơn 1.\"}");
            }
        } else {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Số lượng sản phẩm không hợp lệ.\"}");
        }
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
