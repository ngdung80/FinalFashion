<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- ICONS & STYLES -->
        <link rel="stylesheet" href="https://cdn-uicons.flaticon.com/2.0.0/uicons-regular-straight/css/uicons-regular-straight.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
        <link rel="stylesheet" href="./assets/css/styles.css" />

        <title>Ecommerce Website - Login/Register</title>

        <style>
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 20px 100px;
                background-color: #ffffff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .header .logo {
                font-size: 28px;
                font-weight: bold;
                color: #333;
            }
            .header .nav-links a {
                margin: 0 20px;
                color: #333;
                text-decoration: none;
                font-size: 18px;
            }
            .header .search-box {
                position: relative;
                display: flex;
                align-items: center;
                width: 300px;
            }
            .header .search-box input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
            }
            .header .cart-icon {
                margin-left: 30px;
                font-size: 22px;
                position: relative;
            }
            .header .cart-icon::after {
                content: "3"; /* S? l??ng s?n ph?m */
                position: absolute;
                top: -8px;
                right: -10px;
                background: red;
                color: white;
                padding: 4px;
                border-radius: 50%;
                font-size: 12px;
            }

            /* Footer Styling for Desktop */
            .footer {
                background-color: #333;
                color: white;
                padding: 40px 100px;
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                font-size: 16px;
            }
            .footer .footer-col {
                max-width: 250px;
            }
            .footer .footer-col h4 {
                font-weight: bold;
                margin-bottom: 20px;
                font-size: 18px;
            }
            .footer .footer-col ul {
                list-style-type: none;
                padding: 0;
            }
            .footer .footer-col ul li {
                margin-bottom: 12px;
            }
            .footer .footer-col ul li a {
                color: #bbb;
                text-decoration: none;
            }
            .footer .footer-col ul li a:hover {
                color: #fff;
            }
            .footer .social-icons a {
                color: #bbb;
                margin-right: 15px;
                font-size: 22px;
                text-decoration: none;
            }
            .footer .social-icons a:hover {
                color: #fff;
            }
        </style>
    </head>
    <body>

        <!-- HEADER -->
        <header class="header">
            <div class="logo">Evara</div>
            <nav class="nav-links">
                <a href="#">Home</a>
                <a href="#">Shop</a>
                <a href="#">My Account</a>
                <a href="#">Login</a>
            </nav>
            <div class="search-box">
                <input type="text" placeholder="Search For Items...">
                <i class="fas fa-search" style="position: absolute; right: 10px; color: #888;"></i>
            </div>
            <div class="cart-icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
        </header>

        <!-- MAIN CONTENT -->
        <main class="container my-5">


            <!-- LOGIN-REGISTER SECTION -->
            <section class="login-register">
                <div id="logreg-forms">
                    <form class="form-signin" action="login" method="post">
                        <h1>Sign In</h1>


                        <% if(request.getAttribute("error") != null) { 
                String errorMsg = (String) request.getAttribute("error"); %>
                <div class="alert alert-danger text-center">
                            <h3><%= errorMsg %></h3>
                        </div>
                        <% } %>


                        <% if(request.getAttribute("announce") != null) { 
                String successMsg = (String) request.getAttribute("announce"); %>
                        <div class="alert alert-success text-center">
                            <h3><%= successMsg %></h3>
                        </div>
                        <% } %>

                        <input name="user" type="text" class="form-control" placeholder="Username" required autofocus>
                        <input name="pass" type="password" class="form-control" placeholder="Password" required>
                        <div class="form-check mb-3 text-left">
                            <input name="remember" value="1" type="checkbox" class="form-check-input" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <button class="btn btn-primary btn-block" type="submit" st><i class="fas fa-sign-in-alt"></i> Sign in</button>
                    </form>

                    <form action="signup" method="get">
                        <input class="btn btn-register btn-block mt-3" type="submit" value="Register">
                    </form>
                        
                </div>
            </section>

        </main>

        <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <!-- ICONS & STYLES -->
            <link rel="stylesheet" href="https://cdn-uicons.flaticon.com/2.0.0/uicons-regular-straight/css/uicons-regular-straight.css" />
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
            <title>Ecommerce Website - Footer</title>

            <style>
                /* Footer Styling */
                .footer {
                    background-color: #f3f4f6;
                    color: #333;
                    padding: 40px 100px;
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    font-size: 16px;
                }

                .footer .footer-col {
                    max-width: 250px;
                }

                .footer .footer-col h4 {
                    font-weight: bold;
                    margin-bottom: 20px;
                    font-size: 18px;
                }

                .footer .footer-col p {
                    color: #333;
                    line-height: 1.5;
                }

                .footer .footer-col ul {
                    list-style-type: none;
                    padding: 0;
                }

                .footer .footer-col ul li {
                    margin-bottom: 12px;
                }

                .footer .footer-col ul li a {
                    color: #555;
                    text-decoration: none;
                }

                .footer .footer-col ul li a:hover {
                    color: #333;
                }

                .footer .social-icons a {
                    color: #555;
                    margin-right: 15px;
                    font-size: 22px;
                    text-decoration: none;
                }

                .footer .social-icons a:hover {
                    color: #333;
                }

                .footer .footer-col img {
                    width: 50px;
                    margin-right: 10px;
                    display: inline-block;
                }
            </style>
        </head>
        <body>

            <!-- FOOTER -->
            <footer class="footer">
                <div class="footer-col">
                    <h4>Contact</h4>
                    <p><strong>Address:</strong> 13 Tlemcen Road, Street 32, Beb-Wahren</p>
                    <p><strong>Phone:</strong> +01 2222 365 / (+91) 01 2345 6789</p>
                    <p><strong>Hours:</strong> 10:00 - 18:00, Mon - Sat</p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-pinterest"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>Address</h4>
                    <ul>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Delivery Information</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms & Conditions</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">Support Center</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>My Account</h4>
                    <ul>
                        <li><a href="#">Sign In</a></li>
                        <li><a href="#">View Cart</a></li>
                        <li><a href="#">My Wishlist</a></li>
                        <li><a href="#">Track My Order</a></li>
                        <li><a href="#">Help</a></li>
                        <li><a href="#">Order</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Secured Payed Gateways</h4>
                    <img src="visa.png" alt="Visa">
                    <img src="mastercard.png" alt="MasterCard">
                    <img src="maestro.png" alt="Maestro">
                    <img src="amex.png" alt="American Express">
                </div>
            </footer>

        </body>
    </html>

    <!-- JS SCRIPTS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
