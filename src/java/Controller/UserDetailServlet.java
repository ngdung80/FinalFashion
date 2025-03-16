//package Controller;
//
//import DAO.UserDBContext;
//import Model.User;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//@WebServlet("/listuser") // Thêm annotation để định nghĩa servlet
//public class UserDetailServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        // Lấy tham số userID từ request và kiểm tra nếu nó không null hoặc rỗng
//        String userIDParam = request.getParameter("id"); // Đổi từ userID thành id để phù hợp với URL
//        if (userIDParam != null && !userIDParam.isEmpty()) {
//            try {
//                int userID = Integer.parseInt(userIDParam);
//                UserDBContext userDB = new UserDBContext();
//                User user = userDB.getUserById(userID);
//
//                if (user != null) {
//                    request.setAttribute("user", user);
//                    request.getRequestDispatcher("ListUser.jsp").forward(request, response);
//                } else {
//                    response.sendRedirect("error.jsp?message=User not found for ID: " + userID);
//                }
//            } catch (NumberFormatException e) {
//                response.sendRedirect("error.jsp?message=Invalid user ID format."); // Redirect đến error.jsp với thông điệp
//            }
//        } else {
//            response.sendRedirect("error.jsp?message=User ID is required"); // Redirect đến error.jsp nếu không có userID
//        }
//    }
//}
