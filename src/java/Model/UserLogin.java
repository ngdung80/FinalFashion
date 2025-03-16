
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;


/**
 *
 * @author huytu
 */
public class UserLogin {
    private int UserID;
    private String  Username, Password, email;
    private int Role;

    public UserLogin() {
    }

    public UserLogin(int UserID, String Username, String Password, String email, int Role) {
        this.UserID = UserID;
        this.Username = Username;
        this.Password = Password;
        this.Role = Role;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getUsername() {
        return Username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public int getRole() {
        return Role;
    }

    public void setRole(int Role) {
        this.Role = Role;
    }

    @Override
    public String toString() {
        return "User{" + "UserID=" + UserID + ", Username=" + Username + ", Password=" + Password + ", email=" + email + ", Role=" + Role + '}';
    }
    
    
    
}
