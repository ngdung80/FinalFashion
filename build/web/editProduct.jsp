<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product - Admin Panel</title>
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
            <h2>Edit Product</h2>
            <div class="content-section active">
                <form method="post" action="admin?action=editProduct">
                    <input type="hidden" name="id" value="${product.productID}">
                    
                    <div class="form-group">
                        <label for="title">Product Title:</label>
                        <input type="text" id="title" name="name" value="${product.title}" required>
                    </div>

                    <div class="form-group">
                        <label for="description">Description:</label>
                        <textarea id="description" name="description" required>${product.description}</textarea>
                    </div>

                    <div class="form-group">
                        <label for="thumbnail">Image URL:</label>
                        <input type="text" id="thumbnail" name="thumbnail" value="${product.thumbnail}">
                    </div>

                    <div class="form-group">
                        <label for="price">Price:</label>
                        <input type="number" id="price" name="price" value="${product.price}" min="0" required>
                    </div>

                    <div class="form-group">
                        <label for="quantity">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" value="${product.quantity}" min="0" required>
                    </div>

                    <div class="form-group">
                        <label for="sizeID">Size ID:</label>
                        <input type="number" id="sizeID" name="sizeID" value="${product.sizeID}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="brandID">Brand ID:</label>
                        <input type="number" id="brandID" name="brandID" value="${product.brandID}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="categoryID">Category ID:</label>
                        <input type="number" id="categoryID" name="categoryID" value="${product.categoryID}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="productGender">Product Gender:</label>
                        <select id="productGender" name="productGender">
                            <option value="Male" ${product.productGender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${product.productGender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Unisex" ${product.productGender == 'Unisex' ? 'selected' : ''}>Unisex</option>
                        </select>
                    </div>

                    <input type="submit" value="Save Changes" class="btn btn-primary">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
