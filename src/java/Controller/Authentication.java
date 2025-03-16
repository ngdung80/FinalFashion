/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.UserLogin;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author havie
 */
public class Authentication {

    public static boolean isCustomer(UserLogin user) {
        int roleId = 4;
        return user != null && user.getRole() == roleId;
    }

    public static boolean isAdmin(UserLogin user) {
        int roleId = 1;
        return user != null && user.getRole() == roleId;
    }

    public static boolean isMarketing(UserLogin user) {
        int roleId = 2;
        return user != null && user.getRole() == roleId;
    }

    public static boolean isSales(UserLogin user) {
        int roleId = 3;
        return user != null && user.getRole() == roleId;
    }

    public static void accessDenied(HttpSession session, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("access_denied.jsp");
    }
}
