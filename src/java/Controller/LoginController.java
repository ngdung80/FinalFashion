/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.UserLogin;

/**
 *
 * @author hatrung
 */
public class LoginController extends HttpServlet {

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
            out.println("<title>Servlet LoginControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginControl at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if (action != null) {
            if (!action.isEmpty()) {
                request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
            }
        }
        
        String login = request.getParameter("lg");
        int lg = Integer.parseInt(login);
        if (lg == 1) {
            response.sendRedirect("Login.jsp");
        } else {
            HttpSession session = request.getSession();
            session.removeAttribute("account");
            session.removeAttribute("cart");
            session.removeAttribute("size");
            response.sendRedirect("home");
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
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String remember = request.getParameter("remember");
        UserDAO dao = new UserDAO();
        UserLogin u = dao.login(username, password);
        if (u == null) {
            String er = "Email or Password incorrect! Please enter again!";
            request.setAttribute("error", er);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
        if (remember != null && remember.equals("on")) {
            Cookie cookiename = new Cookie("cookname", username);
            cookiename.setMaxAge(3600);  // 1 tieng, tang len neu can
            Cookie cookiepass = new Cookie("cookpass", password);
            cookiepass.setMaxAge(3600);
            Cookie cookremember = new Cookie("cookremember", remember);
            cookremember.setMaxAge(3600);

            cookiename.setHttpOnly(true);
            cookiepass.setHttpOnly(true);
            cookremember.setHttpOnly(true);

            response.addCookie(cookiename);
            response.addCookie(cookiepass);
            response.addCookie(cookremember);
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", u);
        
        //tu doi sang trang 
        switch (u.getRole()) {
            case 1 -> {
                request.getRequestDispatcher("Admin.jsp").forward(request, response);
            }
            
            case 2 -> {
                request.getRequestDispatcher("Marketing.jsp").forward(request, response);
            }
            
            case 3 -> {
                request.getRequestDispatcher("Sales.jsp").forward(request, response);
            }
            
            case 4 -> {
                response.sendRedirect("home");
            }
        }
    }

}
