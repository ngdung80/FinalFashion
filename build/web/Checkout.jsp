<%-- 
    Document   : Checkout
    Created on : 25 Oct 2024, 15:57:50
    Author     : Anh Tuan
--%>
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
                    <li><span class="breadcrumb__link">></span></li>
                    <li><span class="breadcrumb__link">Shop</span></li>
                    <li><span class="breadcrumb__link">></span></li>
                    <li><span class="breadcrumb__link">Checkout</span></li>
                </ul>
            </section>

            <!--=============== CHECKOUT ===============-->
            <section class="checkout section--lg">
                <div class="checkout__container container grid">
                    <div class="checkout__group">
                        <h3 class="section__title">Billing Details</h3>
                        <form id="info-form" class="form grid" action="checkout" method="POST">
                            <input type="text" name="salenote"placeholder="Name" value="${sessionScope.user.getUsername()}" class="form__input" />
                            <input type="email" name="email" placeholder="Email" value="${sessionScope.user.getEmail()}" class="form__input" />
                            <input type="tel" min="1" max="10" name="mobile" placeholder="Mobile" class="form__input" /> 
                            <input type="text" placeholder="Address" name="address" class="form__input" />                           
                        </form>
                    </div>
                    <div class="checkout__group">
                        <h3 class="section__title">Cart Totals</h3>
                        <table class="order__table">
                            <thead>
                                <tr>
                                    <th colspan="2">Products</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${cartItems}" var="i"> 
                                    <tr>
                                        <td>
                                            <img
                                                src="${i.thumbnail}"
                                                alt=""
                                                class="order__img"
                                                />
                                        </td>
                                        <td>
                                            <h3 class="table__title">${i.title}</h3>
                                            <p class="table__quantity">x${i.quantity}</p>
                                        </td>
                                        <td><span class="table__price">${i.price * i.quantity} VNĐ</span></td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td><span class="order__subtitle">Subtotal</span></td>
                                    <td colspan="2"><span class="table__price">${totalAmount} VNĐ</span></td>
                                </tr>
                                <tr>
                                    <td><span class="order__subtitle">Shipping</span></td>
                                    <td colspan="2">
                                        <span class="table__price">Free Shipping</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="order__subtitle">Total</span></td>
                                    <td colspan="2">
                                        <span class="order__grand-total">${totalAmount} VNĐ</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="payment__methods">
                            <h3 class="checkout__title payment__title">Payment</h3>
                            <div class="payment__option flex">
                                <input
                                    type="radio"
                                    name="radio"
                                    id="l1"
                                    checked
                                    class="payment__input"
                                    />
                                <label for="l1" class="payment__label"
                                       >Direct Bank Transfer</label
                                >
                            </div>
                            <div class="payment__option flex">
                                <input
                                    type="radio"
                                    name="radio"
                                    id="l2"
                                    class="payment__input"
                                    />
                                <label for="l2" class="payment__label">Check Payment</label>
                            </div>
                            <div class="payment__option flex">
                                <input
                                    type="radio"
                                    name="radio"
                                    id="l3"
                                    class="payment__input"
                                    />
                                <label for="l3" class="payment__label">Paypal</label>
                            </div>
                        </div>
                        <button class="btn btn--md" onclick="document.getElementById('info-form').submit();">Place Order</button>
                    </div>
                </div>
            </section>

            <!--=============== NEWSLETTER ===============-->
            <section class="newsletter section">
                <div class="newsletter__container container grid">                  
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

