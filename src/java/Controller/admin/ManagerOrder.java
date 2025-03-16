/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Controller.Authentication;
import DAO.OrderDAO;
import Model.Order;
import Model.OrderDetail;
import Model.ProductQty;
import Model.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "ManagerOrder", urlPatterns = {"/manager-order"})
public class ManagerOrder extends HttpServlet {

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
            out.println("<title>Servlet ManagerOrder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerOrder at " + request.getContextPath() + "</h1>");
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
        UserLogin u = (UserLogin) session.getAttribute("user");
 if (u.getRole()!= 1) {
            response.sendRedirect("Home.jsp");
        } else {
            OrderDAO odao = new OrderDAO();
            List<Order> listOrder = odao.getAllOrder();

            request.setAttribute("listOrder", listOrder);

            request.getRequestDispatcher("ManagerOrder.jsp").forward(request, response);
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

        HttpSession session = request.getSession();
        UserLogin u = (UserLogin) session.getAttribute("user");
        if (u.getRole()!= 1) {
            Authentication.accessDenied(session, response);
        } else {
            String action = request.getParameter("action");

            if (action.equalsIgnoreCase("updateOrderStatus")) {

                int orderId = Integer.parseInt(request.getParameter("orderId"));

                String status = request.getParameter("newStatus");

                OrderDAO odao = new OrderDAO();

                if (status.equalsIgnoreCase("Cancel")) {

                    List<OrderDetail> dt = odao.getOrerDetailByOrderId(orderId);
                    List<ProductQty> qty = odao.getAllQty();
                    odao.updateQuantityProduct(dt, qty);
                    odao.changeStatus(orderId, "Cancel");
                } else {
                    odao.changeStatus(orderId, "Completed");
                }

                doGet(request, response);

            }
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
