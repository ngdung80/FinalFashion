/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.UserLogin;

/**
 *
 * @author hatrung
 */
public class SignupController extends HttpServlet {

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
            out.println("<title>Servlet SignupControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignupControl at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        response.sendRedirect("Register.jsp");
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
        //processRequest(request, response);
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String repassword = request.getParameter("repass");
        String email = request.getParameter("email");
        
        request.setAttribute("user",username);
        request.setAttribute("pass",password);
        request.setAttribute("email",email);
        request.setAttribute("repass",repassword);
        if (password.equals(repassword)) {
            UserDAO dao = new UserDAO();
            UserLogin u = dao.checkUsers(username);
            if (u == null) {
                
                if (dao.insertUser(username, password, email, "male", 4)) {
                    String annouce = "Please Login...";
                    request.setAttribute("annouce", annouce);
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                } else {
                    String duplicate = "Email has already existed! Please enter another email...";
                    request.setAttribute("duplicate", duplicate);
                    PrintWriter out = response.getWriter();
                    out.print(username);
                    out.print(password);
                    out.print(email);
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                }
            } else {
                String duplicate = "Email has already existed! Please enter another email...";
                request.setAttribute("duplicate", duplicate);
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            }
        } else {
            String error = "Password and repassword not same! Please enter again...";
            request.setAttribute("in", error);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }

}
