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
public class ProductAtHome extends Product {

    private String imageMore;

    public ProductAtHome() {
    }

    public ProductAtHome(int productID, String title, String description, String thumbnail, String imageMore, int price, int quantity, int sizeID, String sizeName, int brandID, String brandName, int categoryID, String categoryName, String productGender) {
        super(productID, title, description, thumbnail, price, quantity, sizeID, sizeName, brandID, brandName, categoryID, categoryName, productGender);
        this.imageMore = imageMore;
    }
    
    public ProductAtHome(int productID, String title, String description, String thumbnail, String imageMore, int price, int quantity, int brandID, String brandName, int categoryID, String categoryName, String productGender,ArrayList<Size> sizeList) {
        super(productID, title, description, thumbnail, price, quantity,  brandID, brandName, categoryID, categoryName, productGender, sizeList);
        this.imageMore = imageMore;
    }



    public String getImageMore() {
        return imageMore;
    }

    public void setImageMore(String imageMore) {
        this.imageMore = imageMore;
    }

}
