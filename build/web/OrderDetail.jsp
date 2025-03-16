
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <li><span class="breadcrumb__link">Order Detail</span></li>
                </ul>
            </section>

            <!--=============== CART ===============-->
            <section class="cart section--lg container">
                <div class="table__container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach items="${orderdetail}" var="l">
                                <tr>
                                    <td>
                                        <img
                                            src="${l.thumbnail}"
                                            alt=""
                                            class="table__img"
                                            />
                                    </td>
                                    <td>
                                        <h3 class="table__title">
                                            ${l.title}
                                        </h3>
                                    </td>
                                    <td>
                                        <span class="table__price"> ${l.price}</span>
                                    </td>
                                    <td>${l.quantity}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
            <!--=============== NEWSLETTER ===============-->
        </main>

        <!--=============== FOOTER ===============-->
        <%@include file="Footer.jsp" %>

        <!--=============== SWIPER JS ===============-->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

        <!--=============== MAIN JS ===============-->
        <script src="assets/js/main.js"></script>
    </body>
</html>

