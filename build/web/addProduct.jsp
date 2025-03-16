<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Product - Admin Panel</title>
        <link rel="stylesheet" type="text/css" href="assets/css/styleAddProduct.css">
    </head>
    <body>
        <div class="admin-container">
            <div class="header">
                <h2>Admin Panel</h2>
                <nav>
                    <ul>
                        <li><a href="admin">Products Management</a></li>
                        <li><a href="admin">User Management</a></li>
                    </ul>
                </nav>
            </div>

            <div class="main-content">
                <h2>Add New Product</h2>
                <div class="content-section active">
                    <form method="post" action="admin?action=addProduct">
                        <div class="form-group">
                            <label for="title">Product Title:</label>
                            <input type="text" id="title" name="title" required>
                        </div>

                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea id="description" name="description" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="thumbnail">Image URL:</label>
                            <input type="text" id="thumbnail" name="thumbnail">
                        </div>

                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="number" id="price" name="price" min="0" required>
                        </div>

                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" min="0" required>
                        </div>

                        <div class="form-group">
                            <label for="sizes">Sizes:</label>
                            <select id="sizes" name="sizes" multiple required>
                                <option value="S">S</option>
                                <option value="M">M</option>
                                <option value="L">L</option>
                                <option value="XL">XL</option>
                                <option value="XXL">XXL</option>
                            </select>
                            <small>Hold down the Ctrl (or Command) button to select multiple options.</small>
                        </div>

                        <div class="form-group">
                            <label for="brandID">Brand ID:</label>
                            <input type="number" id="brandID" name="brandID" required>
                        </div>

                        <div class="form-group">
                            <label for="categoryID">Category ID:</label>
                            <input type="number" id="categoryID" name="categoryID" required>
                        </div>

                        <div class="form-group">
                            <label for="productGender">Product Gender:</label>
                            <select id="productGender" name="productGender" required>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Unisex">Unisex</option>
                            </select>
                        </div>

                        <input type="submit" value="Add Product" class="btn btn-primary">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>