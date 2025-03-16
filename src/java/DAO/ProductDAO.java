/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Image;
import Model.Product;
import Model.ProductAtHome;
import Model.Size;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Statement;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author havie
 */
public class ProductDAO extends DBContext {

//    public static void main(String[] args) {
//        ProductDAO p = new ProductDAO();
//        List<Integer> i = new ArrayList<>();
//        i.add(1);
//        i.add(2);
//        i.add(3);
//        int pid = p.addProductFixed(new Product("Áo khoác dạ tweet snrbfoiwer", "Đầm vải tweed có cổ tròn và tay áo rộng, được tô điểm bằng những đường viền tương phản ở viền và túi, cùng một chiếc túi cúc đôi màu vàng.", "Images/Female/aokhoacGC1.jpg", 90000, 18, 1, 1, 1, "Male"));
//        boolean b = p.addProductSizes(pid, i);
//        System.out.println(b);
//    }

    
    // cũ Dũng
    
//    public List<Product> getAllProducts() {
//        List<Product> products = new ArrayList<>();
//        String query = "SELECT * FROM Product";
//        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
//            while (rs.next()) {
//                products.add(new Product(
//                        rs.getInt("ProductID"),
//                        rs.getString("Title"),
//                        rs.getString("Description"),
//                        rs.getString("Thumbnail"),
//                        rs.getInt("Price"),
//                        rs.getInt("Quantity"),
//                        rs.getInt("SizeID"),
//                        "", // Placeholder for sizeName
//                        rs.getInt("BrandID"),
//                        "", // Placeholder for brandName
//                        rs.getInt("CategoryID"),
//                        "", // Placeholder for categoryName
//                        rs.getString("ProductGender")
//                ));
//            }
//        } catch (SQLException e) {
//            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
//        }
//        return products;
//    }
    
    // Mới
    
    public List<Product> getAllProducts() {
    List<Product> productList = new ArrayList<>();
    String sql = "SELECT p.ProductID, p.Title, p.Description, p.Thumbnail, p.Price, p.Quantity, " +
                 "p.BrandID, p.CategoryID, p.ProductGender, s.SizeID, s.SizeName " +
                 "FROM Product p " +
                 "LEFT JOIN Product_Size ps ON p.ProductID = ps.ProductID " +
                 "LEFT JOIN Size s ON ps.SizeID = s.SizeID";

    try (
         PreparedStatement stmt = connection.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        Map<Integer, Product> productMap = new HashMap<>();

        while (rs.next()) {
            int productID = rs.getInt("ProductID");
            String title = rs.getString("Title");
            String description = rs.getString("Description");
            String thumbnail = rs.getString("Thumbnail");
            int price = rs.getInt("Price");
            int quantity = rs.getInt("Quantity");
            int brandID = rs.getInt("BrandID");
            int categoryID = rs.getInt("CategoryID");
            String productGender = rs.getString("ProductGender");

            // Kiểm tra nếu sản phẩm chưa có trong danh sách thì thêm vào
            Product product = productMap.get(productID);
            if (product == null) {
                product = new Product(productID, title, description, thumbnail, price, quantity, brandID, "", categoryID, "", productGender, new ArrayList<>());
                productMap.put(productID, product);
            }

            // Lấy thông tin size
            int sizeID = rs.getInt("SizeID");
            String sizeName = rs.getString("SizeName");

            // Nếu có size, thêm vào danh sách size của sản phẩm
            if (sizeID > 0) {
                product.getSizeList().add(new Size(sizeID, sizeName));
            }
        }

        // Thêm sản phẩm vào danh sách cuối cùng
        productList.addAll(productMap.values());

        System.out.println("Lấy danh sách sản phẩm thành công: " + productList.size());

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return productList;
}

    
    

   public boolean deleteProduct(int id) {
    // Câu lệnh SQL để xóa dữ liệu
    String deleteProductSizeQuery = "DELETE FROM Product_Size WHERE ProductID = ?";
    String deleteImageQuery = "DELETE FROM Image WHERE ProductID = ?";
    String deleteProductQuery = "DELETE FROM Product WHERE ProductID = ?";

    // Khai báo PreparedStatement
    PreparedStatement stmtProductSize = null;
    PreparedStatement stmtImage = null;
    PreparedStatement stmtProduct = null;

    try {
        // Tắt chế độ tự động commit để bắt đầu giao dịch
        connection.setAutoCommit(false);

        // Chuẩn bị các câu lệnh SQL
        stmtProductSize = connection.prepareStatement(deleteProductSizeQuery);
        stmtImage = connection.prepareStatement(deleteImageQuery);
        stmtProduct = connection.prepareStatement(deleteProductQuery);

        // 1️⃣ Xóa dữ liệu trong bảng Product_Size trước (bảng trung gian)
        stmtProductSize.setInt(1, id);
        stmtProductSize.executeUpdate();

        // 2️⃣ Xóa dữ liệu trong bảng Image (ảnh sản phẩm)
        stmtImage.setInt(1, id);
        stmtImage.executeUpdate();

        // 3️⃣ Xóa dữ liệu trong bảng Product (sản phẩm chính)
        stmtProduct.setInt(1, id);
        int rowsAffected = stmtProduct.executeUpdate();

        // Nếu xóa thành công, commit giao dịch
        connection.commit();
        
        // Trả về true nếu có ít nhất 1 sản phẩm bị xóa
        return rowsAffected > 0;

    } catch (SQLException e) {
        // Nếu có lỗi, ghi log lỗi và rollback giao dịch
        Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Lỗi khi xóa sản phẩm có ID: " + id, e);
        try {
            if (connection != null) {
                connection.rollback(); // Quay lại trạng thái trước khi xóa
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Lỗi khi rollback giao dịch", ex);
        }
    } finally {
        // Bật lại chế độ tự động commit
        try {
            if (connection != null) {
                connection.setAutoCommit(true);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Lỗi khi bật lại chế độ auto-commit", ex);
        }
        // Đóng các PreparedStatement để tránh rò rỉ tài nguyên
        try {
            if (stmtProductSize != null) stmtProductSize.close();
            if (stmtImage != null) stmtImage.close();
            if (stmtProduct != null) stmtProduct.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Lỗi khi đóng PreparedStatement", ex);
        }
    }
    return false; // Trả về false nếu xóa thất bại
}


    // Cũ 
    
    public int addProductFixed(Product product) {
        String query = "INSERT INTO Product (Title, Description, Thumbnail, Price, Quantity, SizeID, BrandID, CategoryID, ProductGender) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            // Set parameters for the query
            stmt.setString(1, product.getTitle());
            stmt.setString(2, product.getDescription());
            stmt.setString(3, product.getThumbnail());
            stmt.setInt(4, product.getPrice());
            stmt.setInt(5, product.getQuantity());
            stmt.setInt(6, product.getSizeID());
            stmt.setInt(7, product.getBrandID());
            stmt.setInt(8, product.getCategoryID());
            stmt.setString(9, product.getProductGender());

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // Check if the insertion was successful
            if (rowsAffected > 0) {
                // Retrieve the auto-generated ProductID
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated ProductID
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        // Return -1 if the insertion fails
        return -1;
    }
    
    
    // addProductFixed và không add size 
    public int addProductFixed2(Product product) {
    String query = "INSERT INTO Product (Title, Description, Thumbnail, Price, Quantity, BrandID, CategoryID, ProductGender) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    try (PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
        stmt.setString(1, product.getTitle());
        stmt.setString(2, product.getDescription());
        stmt.setString(3, product.getThumbnail());
        stmt.setInt(4, product.getPrice());
        stmt.setInt(5, product.getQuantity());
        stmt.setInt(6, product.getBrandID());
        stmt.setInt(7, product.getCategoryID());
        stmt.setString(8, product.getProductGender());

        int affectedRows = stmt.executeUpdate();
        if (affectedRows > 0) {
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1); // Lấy ra cái ProductID vừa tạo được tự động tăng
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return -1; // Trả về -1 nếu thất bại
}
    
    public boolean addProductSizes(int productID, List<Integer> sizeIDs) {
    String query = "INSERT INTO Product_Size (ProductID, SizeID) VALUES (?, ?)";
    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        for (int sizeID : sizeIDs) {
            stmt.setInt(1, productID);
            stmt.setInt(2, sizeID);
            stmt.addBatch();
        }
        int[] result = stmt.executeBatch(); // Thực hiện batch insert
        return Arrays.stream(result).allMatch(r -> r > 0);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}


    
    
// cũ    

//    public boolean addProductSizes(int productID, List<Integer> sizeIDs) {
//        String query = "INSERT INTO ProductSize (ProductID, SizeID) VALUES (?, ?)";
//
//        try (PreparedStatement stmt = connection.prepareStatement(query)) {
//            // Insert each sizeID for the given productID
//            for (int sizeID : sizeIDs) {
//                stmt.setInt(1, productID);
//                stmt.setInt(2, sizeID);
//                stmt.addBatch(); // Add to batch for bulk execution
//            }
//
//            // Execute the batch insert
//            int[] results = stmt.executeBatch();
//
//            // Check if all inserts were successful
//            for (int result : results) {
//                if (result == PreparedStatement.EXECUTE_FAILED) {
//                    return false; // If any insert fails, return false
//                }
//            }
//            return true; // All inserts succeeded
//        } catch (SQLException e) {
//            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
//            return false;
//        }
//    }

    public boolean updateProduct(Product product) {
    // 1️ Cập nhật bảng Product trước
    String updateProductQuery = "UPDATE Product SET Title = ?, Description = ?, Thumbnail = ?, Price = ?, Quantity = ?, BrandID = ?, CategoryID = ?, ProductGender = ? WHERE ProductID = ?";
    
    // 2️ Xóa size cũ trong bảng Product_Size
    String deleteSizeQuery = "DELETE FROM Product_Size WHERE ProductID = ?";
    
    // 3️ Thêm size mới vào bảng Product_Size
    String insertSizeQuery = "INSERT INTO Product_Size (ProductID, SizeID) VALUES (?, ?)";

    try {
        // Tắt auto-commit để đảm bảo nếu có lỗi xảy ra, mọi thao tác sẽ bị rollback
        connection.setAutoCommit(false);

        //  Cập nhật thông tin sản phẩm trong bảng Product
        try (PreparedStatement stmt = connection.prepareStatement(updateProductQuery)) {
            stmt.setString(1, product.getTitle());
            stmt.setString(2, product.getDescription());
            stmt.setString(3, product.getThumbnail());
            stmt.setInt(4, product.getPrice());
            stmt.setInt(5, product.getQuantity());
            stmt.setInt(6, product.getBrandID());
            stmt.setInt(7, product.getCategoryID());
            stmt.setString(8, product.getProductGender());
            stmt.setInt(9, product.getProductID());

            stmt.executeUpdate();
        }

        // 🔹 Xóa tất cả size cũ của sản phẩm trong bảng Product_Size
        try (PreparedStatement stmt = connection.prepareStatement(deleteSizeQuery)) {
            stmt.setInt(1, product.getProductID());
            stmt.executeUpdate();
        }

        // 🔹 Thêm size mới vào bảng Product_Size
        try (PreparedStatement stmt = connection.prepareStatement(insertSizeQuery)) {
            for (Size size : product.getSizeList()) {
                stmt.setInt(1, product.getProductID());
                stmt.setInt(2, size.getSizeID());
                stmt.addBatch(); // Thêm vào batch để thực thi nhanh hơn
            }
            stmt.executeBatch(); // Thực thi tất cả các lệnh INSERT cùng lúc
        }

        // Commit nếu không có lỗi
        connection.commit();
        return true;

    } catch (SQLException e) {
        Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Lỗi khi cập nhật sản phẩm có ID: " + product.getProductID(), e);
        
        // Nếu có lỗi, rollback tất cả thay đổi
        try {
            if (connection != null) {
                connection.rollback();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Lỗi khi rollback giao dịch", ex);
        }
    } finally {
        // Bật lại chế độ auto-commit
        try {
            if (connection != null) {
                connection.setAutoCommit(true);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Lỗi khi bật lại auto-commit", ex);
        }
    }
    return false;
}


    public ProductAtHome getProductById(int productId) {
    ProductAtHome p = null;

    // Lấy thông tin sản phẩm (KHÔNG có SizeID)
    String sqlProduct = "SELECT \n"
            + "    Product.ProductID, \n"
            + "    Product.Title, \n"
            + "    Product.[Description], \n"
            + "    Product.Thumbnail, \n"
            + "    ImageMore.ImageMore, \n"
            + "    Product.Price, \n"
            + "    Product.Quantity, \n"
            + "    Product.BrandID, \n"
            + "    Brand.BrandName,\n"
            + "    Product.CategoryID, \n"
            + "    Category.CategoryName, \n"
            + "    Product.ProductGender\n"
            + "FROM \n"
            + "    Brand \n"
            + "INNER JOIN Product ON Brand.BrandID = Product.BrandID \n"
            + "INNER JOIN Category ON Product.CategoryID = Category.CategoryID \n"
            + "OUTER APPLY (  \n"
            + "    SELECT TOP 1 [Image].ImageMore \n"
            + "    FROM [Image] \n"
            + "    WHERE [Image].ProductID = Product.ProductID \n"
            + "    ORDER BY [Image].ImageID  \n"
            + ") AS ImageMore\n"
            + "WHERE Product.ProductID = ? AND Product.Quantity > 0;";

    // Lấy danh sách Size của sản phẩm
    String sqlSize = "SELECT Size.SizeID, Size.SizeName FROM Product_Size "
            + "INNER JOIN Size ON Product_Size.SizeID = Size.SizeID "
            + "WHERE Product_Size.ProductID = ?";

    try {
        PreparedStatement ps = connection.prepareStatement(sqlProduct);
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            p = new ProductAtHome(rs.getInt("ProductID"),
                    rs.getString("Title"),
                    rs.getString("Description"),
                    rs.getString("Thumbnail"),
                    rs.getString("ImageMore"),
                    rs.getInt("Price"),
                    rs.getInt("Quantity"),
                    0,  // Để tạm SizeID, sẽ cập nhật sau
                    "", // Để tạm SizeName, sẽ cập nhật sau
                    rs.getInt("BrandID"),
                    rs.getString("BrandName"),
                    rs.getInt("CategoryID"),
                    rs.getString("CategoryName"),
                    rs.getString("ProductGender"));
        }

        // Nếu sản phẩm tồn tại, lấy danh sách Size của nó
        if (p != null) {
            PreparedStatement psSize = connection.prepareStatement(sqlSize);
            psSize.setInt(1, productId);
            ResultSet rsSize = psSize.executeQuery();

            List<Size> sizes = new ArrayList<>();
            while (rsSize.next()) {
                sizes.add(new Size(rsSize.getInt("SizeID"), rsSize.getString("SizeName")));
            }

            // Cập nhật danh sách size vào đối tượng ProductAtHome
            p.setSizeList((ArrayList<Size>) sizes);
        }

    } catch (SQLException e) {
        System.err.println(e);
    }

    return p;
}


    public ProductAtHome getProductByIdfixed(int productId) {
        ProductAtHome product = null;
        String sql = "SELECT \n"
                + "    Product.ProductID, \n"
                + "    Product.Title, \n"
                + "    Product.[Description], \n"
                + "    Product.Thumbnail, \n"
                + "    ImageMore.ImageMore, \n"
                + "    Product.Price, \n"
                + "    Product.Quantity, \n"
                + "    Product.BrandID, \n"
                + "    Brand.BrandName,\n"
                + "    Product.CategoryID, \n"
                + "    Category.CategoryName, \n"
                + "    Product.ProductGender\n"
                + "FROM \n"
                + "    Brand \n"
                + "INNER JOIN Product ON Brand.BrandID = Product.BrandID \n"
                + "INNER JOIN Category ON Product.CategoryID = Category.CategoryID \n"
                + "OUTER APPLY (  \n"
                + "    SELECT TOP 1 [Image].ImageMore \n"
                + "    FROM [Image] \n"
                + "    WHERE [Image].ProductID = Product.ProductID \n"
                + "    ORDER BY [Image].ImageID  \n"
                + ") AS ImageMore\n"
                + "WHERE \n"
                + "    Product.ProductID = ? AND Product.Quantity > 0;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Fetch product details
                int productID = rs.getInt("ProductID");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String thumbnail = rs.getString("Thumbnail");
                String imageMore = rs.getString("ImageMore");
                int price = rs.getInt("Price");
                int quantity = rs.getInt("Quantity");
                int brandID = rs.getInt("BrandID");
                String brandName = rs.getString("BrandName");
                int categoryID = rs.getInt("CategoryID");
                String categoryName = rs.getString("CategoryName");
                String productGender = rs.getString("ProductGender");

                // Fetch sizes for the product
                ArrayList<Size> sizeList = getSizeByProductId(productID);

                // Create the Product object
                product = new ProductAtHome(productID, title, description, thumbnail, imageMore, price, quantity,
                        brandID, brandName, categoryID, categoryName, productGender, sizeList);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }

        return product;
    }

    public ArrayList<Size> getSizeByProductId(int productId) {
    ArrayList<Size> sizeList = new ArrayList<>();
    String sql = "SELECT s.SizeID, s.SizeName \n"
               + "FROM Size s \n"
               + "INNER JOIN Product_Size ps ON s.SizeID = ps.SizeID \n" // Đổi ProductSize -> Product_Size
               + "WHERE ps.ProductID = ?;";

    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int sizeID = rs.getInt("SizeID");
            String sizeName = rs.getString("SizeName");
            Size size = new Size(sizeID, sizeName);
            sizeList.add(size);
        }
    } catch (SQLException e) {
        System.err.println(e);
    }

    return sizeList;
}


   public List<ProductAtHome> getRelatedProduct(int currentProductId) {
    List<ProductAtHome> relatedProducts = new ArrayList<>();

    // Truy vấn sửa lại để lấy size từ bảng Product_Size
    String sql = "SELECT TOP 4 "
            + "    p.ProductID, "
            + "    p.Title, "
            + "    p.[Description], "
            + "    p.Thumbnail, "
            + "    ImageMore.ImageMore, "
            + "    p.Price, "
            + "    p.Quantity, "
            + "    ps.SizeID, "
            + "    s.SizeName, "
            + "    p.BrandID, "
            + "    b.BrandName, "
            + "    p.CategoryID, "
            + "    c.CategoryName, "
            + "    p.ProductGender "
            + "FROM Product p "
            + "INNER JOIN Brand b ON p.BrandID = b.BrandID "
            + "INNER JOIN Category c ON p.CategoryID = c.CategoryID "
            + "INNER JOIN Product_Size ps ON p.ProductID = ps.ProductID " // JOIN mới với bảng trung gian
            + "INNER JOIN Size s ON ps.SizeID = s.SizeID " // Lấy SizeName từ Size
            + "OUTER APPLY ( "
            + "    SELECT TOP 1 i.ImageMore "
            + "    FROM [Image] i "
            + "    WHERE i.ProductID = p.ProductID "
            + "    ORDER BY i.ImageID "
            + ") AS ImageMore "
            + "WHERE p.CategoryID = (SELECT CategoryID FROM Product WHERE ProductID = ?) "
            + "AND p.ProductID != ? AND p.Quantity > 0 ";

    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, currentProductId);  // ID sản phẩm hiện tại để lấy CategoryID
        ps.setInt(2, currentProductId);  // Loại bỏ sản phẩm hiện tại khỏi kết quả

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            ProductAtHome relatedProduct = new ProductAtHome(
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
            relatedProducts.add(relatedProduct);
        }
    } catch (SQLException e) {
        System.err.println(e);
    }

    return relatedProducts;
}


    public List<Image> getImageMore(int productID) {
        List<Image> list = new ArrayList<>();
        String sql = "SELECT [ImageID]\n"
                + "      ,[ProductID]\n"
                + "      ,[ImageMore]\n"
                + "  FROM [PRJ].[dbo].[Image]\n"
                + "  WHERE [ProductID] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productID);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Image c = new Image(rs.getInt("ImageID"),
                        rs.getInt("ProductID"),
                        rs.getString("ImageMore"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }

        return list;
    }

}
