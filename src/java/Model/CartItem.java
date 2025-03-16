/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.ArrayList;

/**
 *
 * @author Anh Tuan
 */
public class CartItem {
    private int productID;
    private String title;
    private int quantity;
    private String thumbnail;
    private int price;
    private String selectedSize;

    public CartItem() {
    }

    public String getSelectedSize() {
        return selectedSize;
    }

    public void setSelectedSize(String selectedSize) {
        this.selectedSize = selectedSize;
    }

    public CartItem(int productID, String title, int quantity, String thumbnail, int price, String selectedSize) {
        this.productID = productID;
        this.title = title;
        this.quantity = quantity;
        this.thumbnail = thumbnail;
        this.price = price;
        this.selectedSize = selectedSize;
    }

    public CartItem(int productID, String title, int quantity, String thumbnail, int price) {
        this.productID = productID;
        this.title = title;
        this.thumbnail = thumbnail;
        this.price = price;
        this.quantity = quantity;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
     public int getTotalPrice() {
        return this.price * this.quantity;
    }
    
}
