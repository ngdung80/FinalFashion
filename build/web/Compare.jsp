<%-- 
    Document   : Compare
    Created on : 25 Oct 2024, 15:58:15
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
                    <li><span class="breadcrumb__link">></span></li>
                    <li><span class="breadcrumb__link">Shop</span></li>
                    <li><span class="breadcrumb__link">></span></li>
                    <li><span class="breadcrumb__link">Compare</span></li>
                </ul>
            </section>

            <!--=============== COMPARE ===============-->
            <section class="compare container section--lg">
                <table class="compare__table">
                    <tr>
                        <th>Image</th>
                        <td>
                            <img
                                src="./assets/img/product-2-1.jpg"
                                alt=""
                                class="compare__img"
                                />
                        </td>
                        <td>
                            <img
                                src="./assets/img/product-4-1.jpg"
                                alt=""
                                class="compare__img"
                                />
                        </td>
                        <td>
                            <img
                                src="./assets/img/product-7-1.jpg"
                                alt=""
                                class="compare__img"
                                />
                        </td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td><h3 class="table__title">Plain Striola Shirts</h3></td>
                        <td><h3 class="table__title">Chen Cardigan</h3></td>
                        <td><h3 class="table__title">Henley Shirt</h3></td>
                    </tr>
                    <tr>
                        <th>Price</th>
                        <td><span class="table__price">$35</span></td>
                        <td><span class="table__price">$67</span></td>
                        <td><span class="table__price">$24</span></td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td>
                            <p>
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis
                                perferendis nam, fuga reiciendis libero doloremque distinctio.
                            </p>
                        </td>
                        <td>
                            <p>
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis
                                perferendis nam, fuga reiciendis libero doloremque distinctio.
                            </p>
                        </td>
                        <td>
                            <p>
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis
                                perferendis nam, fuga reiciendis libero doloremque distinctio.
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <th>Colors</th>
                        <td>
                            <ul class="color__list compare__colors">
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(37, 100%, 65%)"
                                        ></a>
                                </li>
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(353, 100%, 65%)"
                                        ></a>
                                </li>
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(49, 100%, 60%)"
                                        ></a>
                                </li>
                            </ul>
                        </td>
                        <td>
                            <ul class="color__list compare__colors">
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(37, 100%, 65%)"
                                        ></a>
                                </li>
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(353, 100%, 65%)"
                                        ></a>
                                </li>
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(49, 100%, 60%)"
                                        ></a>
                                </li>
                            </ul>
                        </td>
                        <td>
                            <ul class="color__list compare__colors">
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(37, 100%, 65%)"
                                        ></a>
                                </li>
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(353, 100%, 65%)"
                                        ></a>
                                </li>
                                <li>
                                    <a
                                        href="#"
                                        class="color__link"
                                        style="background-color: hsl(49, 100%, 60%)"
                                        ></a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th>Stock</th>
                        <td><span class="table__stock">Out of stock</span></td>
                        <td><span class="table__stock">Out of stock</span></td>
                        <td><span class="table__stock">Out of stock</span></td>
                    </tr>
                    <tr>
                        <th>Weight</th>
                        <td><span class="table__weight">150 gram</span></td>
                        <td><span class="table__weight">150 gram</span></td>
                        <td><span class="table__weight">150 gram</span></td>
                    </tr>
                    <tr>
                        <th>Dimensions</th>
                        <td><span class="table__dimension">N/A</span></td>
                        <td><span class="table__dimension">N/A</span></td>
                        <td><span class="table__dimension">N/A</span></td>
                    </tr>
                    <tr>
                        <th>Buy</th>
                        <td><a href="#" class="btn btm--sm">Add to Cart</a></td>
                        <td><a href="#" class="btn btm--sm">Add to Cart</a></td>
                        <td><a href="#" class="btn btm--sm">Add to Cart</a></td>
                    </tr>
                    <tr>
                        <th>Remove</th>
                        <td><i class="fi fi-rs-trash table__trash"></i></td>
                        <td><i class="fi fi-rs-trash table__trash"></i></td>
                        <td><i class="fi fi-rs-trash table__trash"></i></td>
                    </tr>
                </table>
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
