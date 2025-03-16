<%-- 
    Document   : Cart
    Created on : 25 Oct 2024, 15:53:34
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
                    <li><a href="home" class="breadcrumb__link">Home</a></li>
                    <li><span class="breadcrumb__link"></span>/</li>
                    <li><a href="shop" class="breadcrumb__link">Shop</a></li>
                    <li><span class="breadcrumb__link"></span>/</li>
                    <li><span class="breadcrumb__link">Cart</span></li>
                </ul>
            </section>
            <div id="popup-notification" class="popup" style="display: none; position: fixed; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 1000;">
                <div class="popup-content" style="background-color: #fff; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 300px; border-radius: 8px; text-align: center;">
                    <span class="close-button" style="color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer;">&times;</span>
                    <p id="popup-message"></p>
                </div>
            </div>
            <!--=============== CART ===============-->
            <section class="cart section--lg container">
                <div class="table__container">
                    <table class="table">
    <thead>
        <tr>
            <th>Image</th>
            <th>Name</th>
            <th>Size</th> <!-- Added Size column -->
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Delete</th>
        </tr>
    </thead>                        
    <tbody id="cart-body">
        <c:forEach items="${cartItems}" var="i"> 
            <tr data-product-id="${i.productID}">
                <td>
                    <img src="${i.thumbnail}" alt="" class="table__img" />
                </td>
                <td>
                    <h3 style="cursor: pointer;" onclick="window.location.href = 'product?service=detail&productId=${i.productID}';" class="table__title">${i.title}</h3>
                </td>
                <td>
                    <span class="table__size">${i.selectedSize}</span> <!-- Display selected size -->
                </td>
                <td>
                    <span class="table__price">${i.price} VNĐ</span>
                </td>
                <td>
                    <input type="number" value="${i.quantity}" class="quantity" min="1" />
                </td>
                <td>
                    <span class="subtotal">${i.price * i.quantity} VNĐ</span>
                </td>
                <td>
                    <a href="remove?productID=${i.productID}" class="btn btn-link">
                        <i class="fi fi-rs-trash table__trash"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
                </div>
                <div class="cart__actions">
                    <a href="home" class="btn flex btn__md">
                        <i class="fi-rs-shopping-bag"></i> Continue Shopping
                    </a>
                </div>
                <div class="divider">
                    <i class="fi fi-rs-fingerprint"></i>
                </div>

                <div class="cart__group grid">
                    <div class="cart__total">
                        <h3 class="section__title">Cart Totals</h3>
                        <table class="cart__total-table">
                            <tr>
                                <td><span class="cart__total-title">Cart Subtotal</span></td>
                                <td><span id="total-cart1" class="cart__total-price">${totalAmount} VNĐ</span></td>
                            </tr>
                            <tr>
                                <td><span class="cart__total-title">Shipping</span></td>
                                <td><span class="cart__total-price">0 VNĐ</span></td>
                            </tr>
                            <tr>
                                <td><span class="cart__total-title">Total</span></td>
                                <td><span id="total-cart2" class="cart__total-price">${totalAmount} VNĐ</span></td>
                            </tr>
                        </table>
                        <c:if test="${not empty cartItems}">
                            <a href="checkout" class="btn flex btn--md">
                                <i class="fi fi-rs-box-alt"></i> Proceed To Checkout
                            </a>
                        </c:if>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
                                            $(document).ready(function () {
                                                $(".quantity").each(function () {
                                                    $(this).data("previous-quantity", $(this).val());
                                                });

                                                $(".quantity").on("change", function () {
                                                    var quantity = $(this).val();
                                                    var row = $(this).closest("tr");
                                                    var productId = row.data("product-id");
                                                    var price = parseInt(row.find(".table__price").text().replace(' VNĐ', '').replace(',', ''));
                                                    var previousQuantity = $(this).data("previous-quantity");

                                                    $.ajax({
                                                        url: "remove",
                                                        method: "POST",
                                                        data: {
                                                            productID: productId,
                                                            quantity: quantity
                                                        },
                                                        success: function (response) {
                                                            if (response.status === "success") {
                                                                var newSubtotal = quantity * price;
                                                                row.find(".subtotal").text(newSubtotal.toFixed(0) + " VNĐ");
                                                                updateTotal();
                                                            } else {
                                                                showPopup(response.message || "Cập nhật không thành công.");
                                                                row.find(".quantity").val(previousQuantity);
                                                            }
                                                        },
                                                        error: function (error) {
                                                            showPopup("Số lượng sản phẩm không hợp lệ.");
                                                            row.find(".quantity").val(previousQuantity);
                                                        }
                                                    });
                                                });

                                                function updateTotal() {
                                                    var subtotal = 0;
                                                    $(".subtotal").each(function () {
                                                        subtotal += parseFloat($(this).text().replace(' VNĐ', '').replace(',', ''));
                                                    });
                                                    var shippingCost = 0;
                                                    var total = subtotal + shippingCost;

                                                    $("#cart-subtotal").text(subtotal.toFixed(0) + " VNĐ");
                                                    $("#total-cart1").text(total.toFixed(0) + " VNĐ");
                                                    $("#total-cart2").text(total.toFixed(0) + " VNĐ");
                                                }

                                                function showPopup(message) {
                                                    $("#popup-message").text(message);
                                                    $("#popup-notification").fadeIn();
                                                }

                                                $(".close-button").on("click", function () {
                                                    $("#popup-notification").fadeOut();
                                                });

                                                $(window).on("click", function (event) {
                                                    if ($(event.target).is("#popup-notification")) {
                                                        $("#popup-notification").fadeOut();
                                                    }
                                                });
                                            });
        </script>
    </body>
</html>

