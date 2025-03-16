package controller;

import DAO.*;
import Model.*;
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class AccountController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        UserLogin currentUser = (UserLogin) session.getAttribute("user");

        String service = request.getParameter("service");
        
        if (service == null) {
            service = "display";
        }

        if (service.equalsIgnoreCase("display")) {
            request.setAttribute("currentUser", currentUser);
            request.getRequestDispatcher("Account.jsp").forward(request, response);
        }
        
        if(service.equalsIgnoreCase("updateAccount")){
            
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

    }

}
