/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import Model.OrderDetail;
import Model.ProductQty;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author trung
 */
public class OrderDAO extends DBContext {

    public List<Order> getOrderByUserId(int userId) {
        List<Order> orderList = new ArrayList<>();
        String query = "SELECT [OrderID]\n"
                + "      ,[UserID]\n"
                + "      ,[UserName]\n"
                + "      ,[Email]\n"
                + "      ,[Mobile]\n"
                + "      ,[Address]\n"
                + "      ,[OrderStatus]\n"
                + "      ,[OrderDate]\n"
                + "  FROM [dbo].[Orders]\n"
                + "  WHERE [UserID] = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Order order = new Order(resultSet.getInt("OrderID"),
                        resultSet.getInt("UserID"),
                        resultSet.getString("UserName"),
                        resultSet.getString("Email"),
                        resultSet.getString("Mobile"),
                        resultSet.getString("Address"),
                        resultSet.getString("OrderStatus"),
                        resultSet.getDate("OrderDate"));

                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    public List<OrderDetail> getOrerDetailByOrderId(int orderId) {
        List<OrderDetail> orderDetailList = new ArrayList<>();
        String query = "SELECT [OrderID]\n"
                + "      ,[ProductID]\n"
                + "      ,[Title]\n"
                + "      ,[Quantity]\n"
                + "      ,[Thumbnail]\n"
                + "      ,[Price]\n"
                + "  FROM [dbo].[OrderDetails]\n"
                + "  WHERE [OrderID] = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderDetail order = new OrderDetail(resultSet.getInt("OrderID"),
                        resultSet.getInt("ProductID"),
                        resultSet.getString("Title"),
                        resultSet.getInt("Quantity"),
                        resultSet.getString("Thumbnail"),
                        resultSet.getInt("Price"));
                orderDetailList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý ngoại lệ (có thể ném lại hoặc ghi vào log)
        }

        return orderDetailList;
    }

    private Order getOrderById(int orderId) {
        Order order = null; // Khởi tạo đối tượng Order để lưu kết quả
        String query = "SELECT [OrderID]\n"
                + "      ,[UserID]\n"
                + "      ,[UserName]\n"
                + "      ,[Email]\n"
                + "      ,[Mobile]\n"
                + "      ,[Address]\n"
                + "      ,[OrderStatus]\n"
                + "      ,[OrderDate]\n"
                + "  FROM [dbo].[Orders]\n"
                + "  WHERE [OrderID] = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                order = new Order(resultSet.getInt("OrderID"),
                        resultSet.getInt("UserID"),
                        resultSet.getString("UserName"),
                        resultSet.getString("Email"),
                        resultSet.getString("Mobile"),
                        resultSet.getString("Address"),
                        resultSet.getString("OrderStatus"),
                        resultSet.getDate("OrderDate"));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    public boolean changeStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET orderStatus = ? WHERE orderId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Order> getAllOrder() {
        List<Order> orderList = new ArrayList<>();
        String query = "SELECT [OrderID]\n"
                + "      ,[UserID]\n"
                + "      ,[UserName]\n"
                + "      ,[Email]\n"
                + "      ,[Mobile]\n"
                + "      ,[Address]\n"
                + "      ,[OrderStatus]\n"
                + "      ,[OrderDate]\n"
                + "  FROM [dbo].[Orders]";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Order order = new Order(resultSet.getInt("OrderID"),
                        resultSet.getInt("UserID"),
                        resultSet.getString("UserName"),
                        resultSet.getString("Email"),
                        resultSet.getString("Mobile"),
                        resultSet.getString("Address"),
                        resultSet.getString("OrderStatus"),
                        resultSet.getDate("OrderDate"));
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
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

    public void updateQuantityProduct(List<OrderDetail> detail, List<ProductQty> products) {
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [Quantity] = [Quantity] + ?\n"
                + " WHERE [ProductID] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            for (OrderDetail c : detail) {
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

}
