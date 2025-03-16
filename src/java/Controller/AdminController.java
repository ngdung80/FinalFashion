package Controller;

import Model.Product;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import DAO.UserDAO;
import DAO.ProductDAO;
import Model.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminController extends HttpServlet {

    private UserDAO userDAO;
    private ProductDAO productDAO;

    // Map size names to their corresponding SizeIDs
    private static final Map<String, Integer> SIZE_MAP = new HashMap<>();

    static {
        SIZE_MAP.put("S", 1);
        SIZE_MAP.put("M", 2);
        SIZE_MAP.put("L", 3);
        SIZE_MAP.put("XL", 4);
        SIZE_MAP.put("XXL", 5);
    }

    @Override
    public void init() {
        userDAO = new UserDAO();
        productDAO = new ProductDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if the user is an admin
HttpSession session = request.getSession();
        UserLogin u = (UserLogin) session.getAttribute("user");        
        if (session == null || session.getAttribute("user") == null) {
            // No session or user not logged in, redirect to login page
            response.sendRedirect("Login.jsp");
            return;
        }

        int userRole = (int) u.getRole();
        if (userRole != 1) { // Admin role ID is 1
            // User is not an admin, redirect to an error page or home page
            response.sendRedirect("Home.jsp");
            return;
        }

        // If the user is an admin, proceed with the request
        response.setContentType("text/html;charset=UTF-8");
        String section = request.getParameter("section");
        String action = request.getParameter("action");

        if (section == null) {
            section = "product";
        }

        try {
            switch (section) {
                case "user" ->
                    handleUserSection(request, response, action);
                case "product" ->
                    handleProductSection(request, response, action);
                default ->
                    response.sendRedirect("admin?section=product");
            }
        } catch (ServletException | IOException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void handleUserSection(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {

        if (action == null) {
            // Display users
            List<User> users = userDAO.getAllUsers();
            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                if (!keyword.isEmpty()) {
                    users = users.stream().filter(p -> p.getName().toLowerCase().contains(keyword.toLowerCase())).toList();
                }
            }
            request.setAttribute("users", users);
            request.setAttribute("section", "user");
            request.getRequestDispatcher("Admin.jsp").forward(request, response);
        } else {
            switch (action) {
                case "deleteUser" -> {
                    int userId = Integer.parseInt(request.getParameter("id"));
                    boolean deletionSuccessful = userDAO.deleteUser(userId);
                    setDeletionMessage(request, deletionSuccessful, "User");
                    response.sendRedirect("admin?section=user");
                }
                case "editUser" -> {
                    String method = request.getMethod();
                    if ("GET".equalsIgnoreCase(method)) {
                        List<User> users = userDAO.getAllUsers();
                        int userId = Integer.parseInt(request.getParameter("id"));

                        User user = users.stream()
                                .filter(u -> u.getId() == userId)
                                .findFirst()
                                .orElse(null);

                        if (user != null) {
                            request.setAttribute("user", user);
                            request.getRequestDispatcher("updateUser.jsp").forward(request, response);
                        } else {
                            response.sendRedirect("admin?section=user&error=notfound");
                        }
                    } else if ("POST".equalsIgnoreCase(method)) {
                        // Update user data
                        int userId = Integer.parseInt(request.getParameter("id"));
                        String userName = request.getParameter("name");
                        String fullName = request.getParameter("fullname");
                        String password = request.getParameter("pass");
                        String email = request.getParameter("email");
                        int roleId = Integer.parseInt(request.getParameter("role"));

                        User updatedUser = new User(userId, userName, "male", email, password, "", roleId, fullName); // Adjust based on User model
                        boolean updateSuccess = userDAO.updateUser(updatedUser);

                        if (updateSuccess) {
                            response.sendRedirect("admin?section=user");
                        } else {
                            response.sendRedirect("updateUser.jsp?id=" + userId + "&error=updatefailed");
                        }
                    }
                }
                default ->
                    response.sendRedirect("admin?section=user"); // Redirect for invalid action
            }
        }
    }

    private void handleProductSection(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        List<Product> products;
        if (null == action) {
            // Display products
            products = productDAO.getAllProducts();

            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                if (!keyword.isEmpty()) {
                    products = products.stream().filter(p -> p.getTitle().toLowerCase().contains(keyword.toLowerCase())).toList();
                }
            }

            request.setAttribute("products", products);
            request.setAttribute("section", "product");
            request.getRequestDispatcher("Admin.jsp").forward(request, response);
        } else {
            switch (action) {
                case "deleteProduct" -> {
                    int productId = Integer.parseInt(request.getParameter("id"));
                    boolean deletionSuccessful = productDAO.deleteProduct(productId);
                    setDeletionMessage(request, deletionSuccessful, "Product");
                    response.sendRedirect("admin?section=product");
                }
                case "editProduct" -> {
                    products = productDAO.getAllProducts();
                    String method = request.getMethod();
                    if ("GET".equalsIgnoreCase(method)) {
                        int productId = Integer.parseInt(request.getParameter("id"));
                        Product product = products.stream().filter(p -> p.getProductID() == productId).findFirst().orElse(null);
                        if (product != null) {
                            request.setAttribute("product", product);
                            request.setAttribute("section", "product");
                            request.getRequestDispatcher("editProduct.jsp").forward(request, response);
                        } else {
                            response.sendRedirect("admin?section=product&error=notfound");
                        }
                    } else if ("POST".equalsIgnoreCase(method)) {
                        // Update product details
                        int productId = Integer.parseInt(request.getParameter("id"));
                        String title = request.getParameter("name");
                        String description = request.getParameter("description");
                        String thumbnail = request.getParameter("thumbnail");
                        int price = Integer.parseInt(request.getParameter("price"));
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        int sizeID = Integer.parseInt(request.getParameter("sizeID"));
                        int brandID = Integer.parseInt(request.getParameter("brandID"));
                        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
                        String productGender = request.getParameter("productGender");

                        Product updatedProduct = new Product(
                                productId,
                                title,
                                description,
                                thumbnail,
                                price,
                                quantity,
                                sizeID,
                                "",
                                brandID,
                                "",
                                categoryID,
                                "",
                                productGender
                        );

                        boolean updateSuccess = productDAO.updateProduct(updatedProduct);

                        if (updateSuccess) {
                            response.sendRedirect("admin?section=product");
                        } else {
                            PrintWriter out = response.getWriter();
                            out.print(updatedProduct.toString());
                        }
                    }
                }

                case "addProduct" -> {
                    // Retrieve form data
                    String title = request.getParameter("title");
                    String description = request.getParameter("description");
                    String thumbnail = request.getParameter("thumbnail");
                    int price = Integer.parseInt(request.getParameter("price"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));

                    int brandID = Integer.parseInt(request.getParameter("brandID"));
                    int categoryID = Integer.parseInt(request.getParameter("categoryID"));
                    String productGender = request.getParameter("productGender");

                    String[] selectedSizes = request.getParameterValues("sizes"); // Get selected sizes

                    // Create Product object (without SizeID)
                    Product product = new Product(title, description, thumbnail, price, quantity, brandID, categoryID, productGender);

                    int productID = productDAO.addProductFixed2(product);

                    if (productID != -1) {
                        List<Integer> sizeIDs = new ArrayList<>();
                        if (selectedSizes != null) {
                            for (String size : selectedSizes) {
                                Integer sizeID = SIZE_MAP.get(size);
                                System.out.println("Converting size: " + size + " → ID: " + sizeID); // Debug
                                if (sizeID != null) {
                                    sizeIDs.add(sizeID);
                                }
                            }
                        }

                        // Ensure valid size IDs before adding to database
                        if (!sizeIDs.isEmpty()) {
                            boolean sizesAdded = productDAO.addProductSizes(productID, sizeIDs);

                            if (sizesAdded) {
                                response.sendRedirect("admin?section=product&status=success");
                            } else {
                                response.sendRedirect("addProduct.jsp?error=sizesfailed");
                            }
                        } else {
                            response.sendRedirect("addProduct.jsp?error=invalidsizes");
                        }
                    } else {
                        response.sendRedirect("addProduct.jsp?error=addfailed");
                    }
                }
            }
        }
    }

    private void setDeletionMessage(HttpServletRequest request, boolean success, String entity) {
        String message = success ? entity + " deleted successfully." : "Failed to delete " + entity + ".";
        request.getSession().setAttribute("successMessage", message);
    }
}