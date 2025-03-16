package DAO;

import Model.User;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDBContext extends DBContext {

    public User getUserById(int userID) {
        User user = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT u.userID, u.userName, u.gender, u.email, r.roleName "
                       + "FROM [User] u "
                       + "JOIN Role r ON u.roleID = r.roleID "
                       + "WHERE u.userID = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userID); // Gán giá trị userID cho câu truy vấn

            rs = stm.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("userID"));
                user.setName(rs.getString("userName"));
                user.setGender(rs.getString("gender"));
                user.setEmail(rs.getString("email"));
                
                user.setRoleId(rs.getInt("roleId"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stm != null) stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return user;
    }
}
