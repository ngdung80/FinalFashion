/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Model.UserLogin;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO extends DBContext {

    public static void main(String[] args) {

        UserDAO dao = new UserDAO();
        String emaill = "admin@gmail.com";
        String pass = "123";
        UserLogin a = dao.login(emaill, pass);

        System.out.println(a);

    }

    public UserLogin login(String email, String pass) {
        String sql = "SELECT * FROM [User] WHERE [Email] = ? AND [Password] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, pass);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new UserLogin(
                        rs.getInt("UserID"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("RoleID")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in login: " + e.getMessage());
        }
        return null;
    }

    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE [User] SET [Password] = ? WHERE [UserID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setInt(2, userId);
            int rowsUpdated = st.executeUpdate();

            // Kiểm tra xem có bản ghi nào được cập nhật không
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("Error in changePassword: " + e.getMessage());
        }
        return false;
    }

    //insert a new UserLogin
    public boolean insertUser(String name, String pass, String email, String gender, int roleId) {
        String sql = "INSERT INTO [User] ([UserName], [Password], [Email], [Gender], [RoleID]) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, pass);
            pre.setString(3, email);
            pre.setString(4, gender);
            pre.setInt(5, roleId);
            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error in insertUser: " + e.getMessage());
        }
        return false;
    }

    //Check duplicate Users
    public UserLogin checkUsers(String user) {
        String sql = "SELECT * FROM [User] WHERE [UserName] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new UserLogin(rs.getInt("UserID"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("RoleID"));
            }
        } catch (SQLException e) {
            System.out.println("Error in checkUserExists: " + e.getMessage());
        }
        return null;
    }

    //get Users by 
    public int getIDByName(String name) {
        String sql = "select UserID from User where Username like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt("UserID");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    //get all Users in DB
    public List<UserLogin> getAllUsersByRole(int roleId) {
        String sql = "SELECT * FROM [User] WHERE RoleID = ?";
        List<UserLogin> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, roleId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                UserLogin u = new UserLogin(rs.getInt("UserID"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("RoleID"));
                list.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllUsersByRole: " + e.getMessage());
        }
        return list;
    }

    //get Users by id
    public UserLogin getUserByID(int id) {
        String sql = " select * from [User]where [UserID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new UserLogin(rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("RoleID"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //update role for user
    public void updateRole(int role, int id) {
        String sql = "UPDATE [User] SET [RoleID] = ? WHERE UserID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, role);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in updateRole: " + e.getMessage());
        }
    }

    //change password user
    public void change(String pass, String user) {
        String sql = "UPDATE [User] SET [Password] = ? WHERE [UserName] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pass);
            st.setString(2, user);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in changePassword: " + e.getMessage());
        }
    }

    //get total Users
    public int getTotalUsers() {
        String sql = "select COUNT(*) from User where Role=0";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int number = rs.getInt(1);
                return number;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    //get next 18 Users
    public List<UserLogin> getUsersOffFetch(int index) {
        List<UserLogin> list = new ArrayList<>();
        String sql = "select * from User where Role=0 order by UserID offset ? rows fetch next 18 rows only";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 18);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                UserLogin u = new UserLogin(rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("Role"));
                list.add(u);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //get name Users by id
    public UserLogin getNameUserByID(int id) {
        String sql = "  select Username from User\n"
                + "  where [UserID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new UserLogin(rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getInt("Role"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM [User] u JOIN [Role] r ON u.RoleID = r.RoleID";
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("UserID"),
                        rs.getString("UserName"),
                        rs.getString("Gender"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        "", // Placeholder for avatar
                        rs.getInt("RoleID"),
                        rs.getString("RoleName")
                ));
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return users;
    }

    public boolean deleteUser(int id) {
        String query = "DELETE FROM [User] WHERE UserID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean updateUser(User user) {
        String query = "UPDATE [User] SET UserName = ?, Gender = ?, Email = ?, Password = ?, RoleID = ? WHERE UserID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getGender());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPassword());
            stmt.setInt(5, user.getRoleId());
            stmt.setInt(6, user.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return false;
    }
}
