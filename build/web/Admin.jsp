<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Fashion Store</title>
        <link rel="stylesheet" type="text/css" href="assets/css/styleAdmin.css">
        <style>
            a {
                text-decoration: none;
                color: inherit;
            }

            a:visited {
                color: white;
            }

            .content-section {
                display: none; 
            }

            .content-section.active {
                display: block; 
            }
        </style>
    </head>
    <body>
        <div class="admin-container">
            <aside class="sidebar">
                <h2>Admin Dashboard</h2>
                <nav>
                    <ul>
                        <li><a href="home">Home</a></li>
                        <li><a href="admin?section=product">Product Management</a></li>
                        <li><a href="admin?section=user">User Management</a></li>
                    </ul>
                </nav>
            </aside>

            <main class="main-content">
                <c:if test="${not empty successMessage}">
                    <div class="notification" id="successNotification">
                        <p>${successMessage}</p>
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>

                <!-- User Management Section -->
                <c:if test="${section == 'user'}">
                    <section id="users" class="content-section active">
                        <h2 style="margin-left: 250px">User Management</h2>
                        <form style="margin-left: 250px; margin-bottom: 50px" method="get" action="admin">
                            <input type="hidden" name="section" value="user">
                            <input type="text" name="keyword">
                            <input type="submit" value="Search" />
                        </form>

                        <table border="1" cellpadding="10" cellspacing="0" style="margin-left: 250px;">
                            <thead>
                                <tr>
                                    <th>User ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.name}</td>
                                        <td>${user.email}</td>
                                        <td>${user.roleName}</td>
                                        <td>
                                            <a href="admin?section=user&action=editUser&id=${user.id}" class="btn btn-primary">Edit</a>
                                            <a href="admin?section=user&action=deleteUser&id=${user.id}" class="btn btn-danger" 
                                               onclick="return confirm('Are you sure you want to delete this user?')">
                                                Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </section>
                </c:if>

                <!-- Product Management Section -->
                <c:if test="${section == 'product'}">
                    <section id="products" class="content-section active">
                        <h2 style="margin-left: 250px">Product Management</h2>
                        <form style="margin-left: 250px" method="get" action="admin?section=product">
                            <input type="text" name="keyword">
                            <input type="submit" value="Search" />
                        </form>
                        <div class="add-product" >
                            <a href="addProduct.jsp">Add New Product</a>
                        </div>
                        <div class="product-container">
                            <c:forEach var="product" items="${products}">
                                <div class="product-item">
                                    <img src="${product.thumbnail}" alt="${product.title}">
                                    <div class="product-name">${product.title}</div>
                                    <div class="product-price">${product.price}</div>
                                    <div class="product-actions">
                                        <a href="admin?action=editProduct&id=${product.productID}" class="edit">Edit</a>
                                        <a href="admin?action=deleteProduct&id=${product.productID}" class="delete" onclick="return confirmDeletion('${product.title}')">Delete</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>
                </c:if>
            </main>
        </div>

        <script>
            window.onload = function () {
                setTimeout(function () {
                    const notification = document.getElementById('successNotification');
                    if (notification) {
                        notification.classList.add('fade-out');
                        setTimeout(function () {
                            notification.style.display = 'none';
                        }, 500);
                    }
                }, 3000); // 3 seconds
            };

            function confirmDeletion(productName) {
                return confirm("Are you sure you want to delete " + productName + "?");
            }
        </script>
    </body>
</html>
