<%-- 
    Document   : Wishlist
    Created on : 25 Oct 2024, 15:57:35
    Author     : Anh Tuan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <!--=============== FLATICON ===============-->
        <link
            rel="stylesheet"
            href="https://cdn-uicons.flaticon.com/2.0.0/uicons-regular-straight/css/uicons-regular-straight.css"
            />

        <!--=============== SWIPER CSS ===============-->
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"
            />

        <!--=============== CSS ===============-->
        <link rel="stylesheet" href="./assets/css/styles.css" />

        <title>Ecommerce Website</title>
    </head>
    <body>
        <!--=============== HEADER ===============-->
        <%@include file="Header.jsp" %>

        <!--=============== MAIN ===============-->
        <main class="main">
            <!--=============== BREADCRUMB ===============-->
            <section class="breadcrumb">
                <ul class="breadcrumb__list flex container">
                    <li><a href="index.html" class="breadcrumb__link">Home</a></li>
                    <li><span class="breadcrumb__link"></span>></li>
                    <li><span class="breadcrumb__link">Shop</span></li>
                    <li><span class="breadcrumb__link"></span>></li>
                    <li><span class="breadcrumb__link">Wishlist</span></li>
                </ul>
            </section>

            <!--=============== WISHLIST ===============-->
            <section class="wishlist section--lg container">
                <div class="table__container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Stock Status</th>
                                <th>Action</th>
                                <th>Rename</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <img
                                        src="./assets//img/product-1-2.jpg"
                                        alt=""
                                        class="table__img"
                                        />
                                </td>
                                <td>
                                    <h3 class="table__title">
                                        J.Crew Mercantile Women's Short-Sleeve
                                    </h3>
                                    <p class="table__description">
                                        Lorem ipsum dolor sit amet consectetur.
                                    </p>
                                </td>
                                <td>
                                    <span class="table__price">$110</span>
                                </td>
                                <td><span class="table__stock">In Stock</span></td>
                                <td><a href="#" class="btn btn--sm">Add to Cart</a></td>
                                <td><i class="fi fi-rs-trash table__trash"></i></td>
                            </tr>
                            <tr>
                                <td>
                                    <img
                                        src="./assets//img/product-7-1.jpg"
                                        alt=""
                                        class="table__img"
                                        />
                                </td>
                                <td>
                                    <h3 class="table__title">Amazon Essentials Women's Tank</h3>
                                    <p class="table__description">
                                        Lorem ipsum dolor sit amet consectetur.
                                    </p>
                                </td>
                                <td>
                                    <span class="table__price">$110</span>
                                </td>
                                <td><span class="table__stock">In Stock</span></td>
                                <td><a href="#" class="btn btn--sm">Add to Cart</a></td>
                                <td><i class="fi fi-rs-trash table__trash"></i></td>
                            </tr>
                            <tr>
                                <td>
                                    <img
                                        src="./assets//img/product-2-1.jpg"
                                        alt=""
                                        class="table__img"
                                        />
                                </td>
                                <td>
                                    <h3 class="table__title">
                                        Amazon Brand - Daily Ritual Women's Jersey
                                    </h3>
                                    <p class="table__description">
                                        Lorem ipsum dolor sit amet consectetur.
                                    </p>
                                </td>
                                <td>
                                    <span class="table__price">$110</span>
                                </td>
                                <td><span class="table__stock">In Stock</span></td>
                                <td><a href="#" class="btn btn--sm">Add to Cart</a></td>
                                <td><i class="fi fi-rs-trash table__trash"></i></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!--=============== NEWSLETTER ===============-->
            <section class="newsletter section">
                <div class="newsletter__container container grid">
                    <h3 class="newsletter__title flex">
                        <img
                            src="./assets/img/icon-email.svg"
                            alt=""
                            class="newsletter__icon"
                            />
                        Sign in to Newsletter
                    </h3>
                    <p class="newsletter__description">
                        ...and receive $25 coupon for first shopping.
                    </p>
                    <form action="" class="newsletter__form">
                        <input
                            type="text"
                            placeholder="Enter Your Email"
                            class="newsletter__input"
                            />
                        <button type="submit" class="newsletter__btn">Subscribe</button>
                    </form>
                </div>
            </section>
        </main>

        <!--=============== FOOTER ===============-->
        <%@include file="Footer.jsp" %>
        <!--=============== SWIPER JS ===============-->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <!--=============== MAIN JS ===============-->
        <script src="assets/js/main.js"></script>
    </body>
</html>

