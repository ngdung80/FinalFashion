/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Attribute;
import Model.ProductAtHome;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Anh Tuan
 */
public class HomeProductDAO extends DBContext {

   public List<ProductAtHome> getAllProduct(Integer page, String category, String brand, String search, String sort) {
    List<ProductAtHome> list = new ArrayList<>();
    StringBuilder sql = new StringBuilder();
    sql.append("SELECT\n"
            + "    Product.ProductID,\n"
            + "    Product.Title,\n"
            + "    Product.[Description],\n"
            + "    Product.Thumbnail,\n"
            + "    ImageMore.ImageMore,\n"
            + "    Product.Price,\n"
            + "    Product.Quantity,\n"
            + "    s.SizeID,\n" // ✅ Đã sửa
            + "    s.SizeName,\n" // ✅ Đã sửa
            + "    Product.BrandID,\n"
            + "    Brand.BrandName,\n"
            + "    Product.CategoryID,\n"
            + "    Category.CategoryName,\n"
            + "    Product.ProductGender\n"
            + "FROM\n"
            + "    Brand\n"
            + "INNER JOIN Product ON Brand.BrandID = Product.BrandID\n"
            + "INNER JOIN Category ON Product.CategoryID = Category.CategoryID\n"
            + "LEFT JOIN Product_Size ps ON Product.ProductID = ps.ProductID\n" // ✅ Đã sửa
            + "LEFT JOIN Size s ON ps.SizeID = s.SizeID\n" // ✅ Đã sửa
            + "OUTER APPLY (\n"
            + "    SELECT TOP 1 [Image].ImageMore\n"
            + "    FROM [Image]\n"
            + "    WHERE [Image].ProductID = Product.ProductID\n"
            + "    ORDER BY [Image].ImageID\n"
            + ") AS ImageMore\n"
            + "WHERE Product.Quantity > 0 ");

    if (category != null && !category.isEmpty()) {
        sql.append(" AND Product.CategoryID = ? ");
    }

    if (brand != null && !brand.isEmpty()) {
        sql.append(" AND Product.BrandID = ? ");
    }

    if (search != null && !search.isEmpty()) {
        sql.append(" AND Product.Title LIKE ? ");
    }

    if (sort != null) {
        if (sort.equalsIgnoreCase("ASC")) {
            sql.append(" ORDER BY Product.Price ASC ");
        } else if (sort.equalsIgnoreCase("DESC")) {
            sql.append(" ORDER BY Product.Price DESC ");
        }
    } else {
        sql.append(" ORDER BY Product.ProductID ASC "); // ✅ Đã sửa
    }

    if (page != null) {
        sql.append(" OFFSET ? ROWS \n"
                + "FETCH NEXT ? ROWS ONLY;");
    }

    try {
        PreparedStatement st = connection.prepareStatement(sql.toString());
        int count = 1;

        if (category != null && !category.isEmpty()) {
            st.setString(count++, category);
        }

        if (brand != null && !brand.isEmpty()) {
            st.setString(count++, brand);
        }

        if (search != null && !search.isEmpty()) {
            st.setString(count++, "%" + search + "%");
        }

        if (page != null) {
            st.setInt(count++, (page - 1) * 12);
            st.setInt(count++, 12);
        }

        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            ProductAtHome c = new ProductAtHome(rs.getInt("ProductID"),
                    rs.getString("Title"),
                    rs.getString("Description"),
                    rs.getString("Thumbnail"),
                    rs.getString("ImageMore"),
                    rs.getInt("Price"),
                    rs.getInt("Quantity"),
                    rs.getInt("SizeID"), // ✅ Đã sửa
                    rs.getString("SizeName"), // ✅ Đã sửa
                    rs.getInt("BrandID"),
                    rs.getString("BrandName"),
                    rs.getInt("CategoryID"),
                    rs.getString("CategoryName"),
                    rs.getString("ProductGender"));
            list.add(c);
        }
    } catch (SQLException e) {
        System.err.println(e);
    }

    return list;
}


    public List<ProductAtHome> getNew8Product() {
    List<ProductAtHome> list = new ArrayList<>();
    String sql = "SELECT TOP 8 "
            + "    Product.ProductID, "
            + "    Product.Title, "
            + "    Product.[Description], "
            + "    Product.Thumbnail, "
            + "    ImageMore.ImageMore, "
            + "    Product.Price, "
            + "    Product.Quantity, "
            + "    COALESCE(Size.SizeID, 0) AS SizeID, "
            + "    COALESCE(Size.SizeName, 'N/A') AS SizeName, "
            + "    Product.BrandID, "
            + "    Brand.BrandName, "
            + "    Product.CategoryID, "
            + "    Category.CategoryName, "
            + "    Product.ProductGender "
            + "FROM Product "
            + "INNER JOIN Brand ON Brand.BrandID = Product.BrandID "
            + "INNER JOIN Category ON Product.CategoryID = Category.CategoryID "
            + "LEFT JOIN Product_Size ps ON Product.ProductID = ps.ProductID "
            + "LEFT JOIN Size ON ps.SizeID = Size.SizeID "
            + "OUTER APPLY ( "
            + "    SELECT TOP 1 [Image].ImageMore "
            + "    FROM [Image] "
            + "    WHERE [Image].ProductID = Product.ProductID "
            + "    ORDER BY [Image].ImageID "
            + ") AS ImageMore "
            + "WHERE Product.Quantity > 0 "
            + "ORDER BY Product.ProductID DESC;";

    try {
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            ProductAtHome product = new ProductAtHome(
                    rs.getInt("ProductID"),
                    rs.getString("Title"),
                    rs.getString("Description"),
                    rs.getString("Thumbnail"),
                    rs.getString("ImageMore"),
                    rs.getInt("Price"),
                    rs.getInt("Quantity"),
                    rs.getInt("SizeID"),  // Không còn lỗi NULL
                    rs.getString("SizeName"),
                    rs.getInt("BrandID"),
                    rs.getString("BrandName"),
                    rs.getInt("CategoryID"),
                    rs.getString("CategoryName"),
                    rs.getString("ProductGender")
            );
            list.add(product);
        }
    } catch (SQLException e) {
        System.err.println(e);
    }

    return list;
}


    public List<ProductAtHome> getPopular8Product() {
    List<ProductAtHome> list = new ArrayList<>();
    String sql = "SELECT TOP 8 "
            + "    Product.ProductID, "
            + "    Product.Title, "
            + "    Product.Description, "
            + "    Product.Thumbnail, "
            + "    ImageMore.ImageMore, "
            + "    Product.Price, "
            + "    Product.Quantity, "
            + "    COALESCE(Size.SizeID, 0) AS SizeID, "
            + "    COALESCE(Size.SizeName, 'N/A') AS SizeName, "
            + "    Product.BrandID, "
            + "    Brand.BrandName, "
            + "    Product.CategoryID, "
            + "    Category.CategoryName, "
            + "    Product.ProductGender, "
            + "    ISNULL(SUM(OrderDetails.Quantity), 0) AS TotalSold "
            + "FROM Product "
            + "INNER JOIN Category ON Product.CategoryID = Category.CategoryID "
            + "INNER JOIN Brand ON Product.BrandID = Brand.BrandID "
            + "LEFT JOIN OrderDetails ON Product.ProductID = OrderDetails.ProductID "
            + "LEFT JOIN Product_Size ps ON Product.ProductID = ps.ProductID "
            + "LEFT JOIN Size ON ps.SizeID = Size.SizeID "
            + "OUTER APPLY ( "
            + "    SELECT TOP 1 [Image].ImageMore "
            + "    FROM [Image] "
            + "    WHERE [Image].ProductID = Product.ProductID "
            + "    ORDER BY [Image].ImageID "
            + ") AS ImageMore "
            + "WHERE Product.Quantity > 0 "
            + "GROUP BY "
            + "    Product.ProductID, "
            + "    Product.Title, "
            + "    Product.Description, "
            + "    Product.Thumbnail, "
            + "    Product.Price, "
            + "    Product.Quantity, "
            + "    Size.SizeID, "
            + "    Size.SizeName, "
            + "    Product.BrandID, "
            + "    Brand.BrandName, "
            + "    Product.CategoryID, "
            + "    Category.CategoryName, "
            + "    Product.ProductGender, "
            + "    ImageMore.ImageMore "
            + "ORDER BY TotalSold DESC;";

    try {
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            ProductAtHome c = new ProductAtHome(
                    rs.getInt("ProductID"),
                    rs.getString("Title"),
                    rs.getString("Description"),
                    rs.getString("Thumbnail"),
                    rs.getString("ImageMore"),
                    rs.getInt("Price"),
                    rs.getInt("Quantity"),
                    rs.getInt("SizeID"),
                    rs.getString("SizeName"),
                    rs.getInt("BrandID"),
                    rs.getString("BrandName"),
                    rs.getInt("CategoryID"),
                    rs.getString("CategoryName"),
                    rs.getString("ProductGender")
            );
            list.add(c);
        }
    } catch (SQLException e) {
        System.err.println(e);
    }

    return list;
}


    public List<Attribute> getAllBrand() {
        List<Attribute> list = new ArrayList<>();
        String sql = "SELECT [BrandID],\n"
                + "       [BrandName],\n"
                + "       [BrandImage]\n"
                + "FROM [dbo].[Brand];";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Attribute c = new Attribute(rs.getInt("BrandID"),
                        rs.getString("BrandName"),
                        rs.getString("BrandImage"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }

        return list;
    }

    public List<Attribute> getAllCategory() {
        List<Attribute> list = new ArrayList<>();
        String sql = "SELECT [CategoryID],\n"
                + "      [CategoryName],\n"
                + "      [CategoryImage]\n"
                + "  FROM [dbo].[Category]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Attribute c = new Attribute(rs.getInt("CategoryID"),
                        rs.getString("CategoryName"),
                        rs.getString("CategoryImage"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }

        return list;
    }

//    
    
    public List<ProductAtHome> getFeature8Product() {
    List<ProductAtHome> list = new ArrayList<>();
    String sql = "SELECT TOP 8\n"
            + "    p.ProductID, \n"
            + "    p.Title, \n"
            + "    p.[Description], \n"
            + "    p.Thumbnail, \n"
            + "    COALESCE(im.ImageMore, '') AS ImageMore, \n"
            + "    p.Price, \n"
            + "    p.Quantity, \n"
            + "    COALESCE(s.SizeID, 0) AS SizeID, \n"
            + "    COALESCE(s.SizeName, 'N/A') AS SizeName, \n"
            + "    p.BrandID, \n"
            + "    b.BrandName, \n"
            + "    p.CategoryID, \n"
            + "    c.CategoryName, \n"
            + "    p.ProductGender\n"
            + "FROM Product p\n"
            + "INNER JOIN Brand b ON p.BrandID = b.BrandID \n"
            + "INNER JOIN Category c ON p.CategoryID = c.CategoryID \n"
            + "LEFT JOIN Product_Size ps ON p.ProductID = ps.ProductID\n"
            + "LEFT JOIN Size s ON ps.SizeID = s.SizeID\n"
            + "OUTER APPLY (  \n"
            + "    SELECT TOP 1 i.ImageMore \n"
            + "    FROM [Image] i \n"
            + "    WHERE i.ProductID = p.ProductID \n"
            + "    ORDER BY i.ImageID  \n"
            + ") AS im\n"
            + "WHERE p.Quantity > 0\n"
            + "ORDER BY p.Price DESC;";

    try {
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            ProductAtHome c = new ProductAtHome(
                    rs.getInt("ProductID"),
                    rs.getString("Title"),
                    rs.getString("Description"),
                    rs.getString("Thumbnail"),
                    rs.getString("ImageMore"),
                    rs.getInt("Price"),
                    rs.getInt("Quantity"),
                    rs.getInt("SizeID"),  // Không còn lỗi NULL
                    rs.getString("SizeName"),
                    rs.getInt("BrandID"),
                    rs.getString("BrandName"),
                    rs.getInt("CategoryID"),
                    rs.getString("CategoryName"),
                    rs.getString("ProductGender")
            );
            list.add(c);
        }
    } catch (SQLException e) {
        e.printStackTrace();  // Debug tốt hơn
    }

    return list;
}


}
