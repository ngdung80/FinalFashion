/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Cart;
import Model.CartItem;
import Model.Order;
import Model.ProductCart;
import Model.ProductQty;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Anh Tuan
 */
public class CartDAO extends DBContext {

     public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT OrderID, UserID, OrderStatus, SaleNotes, OrderDate, Email, Mobile, Address "
                   + "FROM Orders WHERE UserID = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId); // Set the UserID parameter

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("OrderID"));
                    order.setUserId(rs.getInt("UserID"));
                    order.setOrderStatus(rs.getString("OrderStatus"));
                    order.setSaleNote(rs.getString("SaleNotes"));
                    order.setOrderDate(rs.getTimestamp("OrderDate"));
                    order.setEmail(rs.getString("Email"));
                    order.setMobile(rs.getString("Mobile"));
                    order.setAddress(rs.getString("Address"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving orders: " + e.getMessage());
            e.printStackTrace();
        }

        return orders;
    }

    public ProductCart getItemToAdd(int productID) {
        String sql = "SELECT [ProductID]\n"
                + "      ,[Title]\n"
                + "      ,[Quantity]\n"
                + "      ,[Thumbnail]\n"
                + "      ,[Price]\n"
                + "  FROM [dbo].[Product]\n"
                + "  WHERE [ProductID] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productID);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                ProductCart c = new ProductCart(rs.getInt("ProductID"),
                        rs.getString("Title"),
                        rs.getInt("Quantity"),
                        rs.getString("Thumbnail"),
                        rs.getInt("Price"));

                return c;

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;

    }


 public int createOrder(int userid, String email, String mobile, String address, String saleNotes) {
    int orderId = -1;
    String sql = "INSERT INTO [dbo].[Orders] "
               + "([UserID], [OrderStatus], [SaleNotes], [OrderDate], [Email], [Mobile], [Address]) "
               + "VALUES (?, ?, ?, GETDATE(), ?, ?, ?)";

    try (PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
        // Set parameters for the query
        st.setInt(1, userid); // UserID
        st.setString(2, "Pending"); // OrderStatus (default to 'Pending')
        st.setString(3, saleNotes); // SaleNotes
        st.setString(4, email); // Email
        st.setString(5, mobile); // Mobile
        st.setString(6, address); // Address

        // Execute the query
        int row = st.executeUpdate();

        // Retrieve the generated OrderID
        if (row > 0) {
            try (ResultSet key = st.getGeneratedKeys()) {
                if (key.next()) {
                    orderId = key.getInt(1); // Get the auto-generated OrderID
                }
            }
        }
    } catch (SQLException e) {
        // Log the error or rethrow it as a custom exception
        System.err.println("Error creating order: " + e.getMessage());
        e.printStackTrace();
    }

    return orderId;
}
    public List<ProductQty> getAllQty() {
        List<ProductQty> list = new ArrayList<>();
        String sql = "SELECT [ProductID]\n"
                + "      ,[Quantity]\n"
                + "  FROM [dbo].[Product]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductQty c = new ProductQty(rs.getInt("ProductID"),
                        rs.getInt("Quantity"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }

        return list;
    }

    public  void updateQuantityProduct(List<CartItem> item, List<ProductQty> products) {
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [Quantity] = [Quantity] - ?\n"
                + " WHERE [ProductID] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            for (CartItem c : item) {
                for (ProductQty p : products) {
                    if (c.getProductID() == p.getProductID()) {
                        st.setInt(1, c.getQuantity());
                        st.setInt(2, c.getProductID());
                        st.executeUpdate();
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertOrderDetail(List<CartItem> cartItems, int orderID) {
        String sql = "INSERT INTO [dbo].[OrderDetails]\n"
                + "           ([OrderID]\n"
                + "           ,[ProductID]\n"
                + "           ,[Title]\n"
                + "           ,[Quantity]\n"
                + "           ,[Thumbnail]\n"
                + "           ,[Price])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            for (CartItem c : cartItems) {
                st.setInt(1, orderID);
                st.setInt(2, c.getProductID());
                st.setString(3, c.getTitle());
                st.setInt(4, c.getQuantity());
                st.setString(5, c.getThumbnail());
                st.setDouble(6, c.getPrice());

                st.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
