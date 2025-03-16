<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <!--=============== FLATICON ===============-->
        <link rel="stylesheet" href="https://cdn-uicons.flaticon.com/2.0.0/uicons-regular-straight/css/uicons-regular-straight.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!--=============== SWIPER CSS ===============-->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.css">

        <!--=============== CSS ===============-->
        <link rel="stylesheet" href="./assets/css/styles.css" />

        <style>

        </style>

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
                    <li><span class="breadcrumb__link">Orders</span></li>
                </ul>
            </section>

            <!--=============== CART ===============-->
            <section class="cart section--lg container">
                <div class="table__container">
                    <table id="orderTable">
                        <thead>
                            <tr>
                                <th>Order Id</th>
                                <th>Receiver Address</th>
                                <th>Order Date</th>
                                <th>Order Detail</th>
                                <th>Action</th>
                            </tr>
                        </thead>
<tbody>
    <c:if test="${empty orders}">
        <tr>
            <td colspan="6" style="text-align: center;">No orders found.</td>
        </tr>
    </c:if>
    <c:forEach items="${orders}" var="order">
        <tr>
            <td><span class="">${order.orderId}</span></td>
            <td><span class="">${order.orderStatus}</span></td>
            <td><span class="">${order.saleNote}</span></td>
            <td><span class="">${order.email}</span></td>
            <td>
                <a href="orderdtforuser?orderId=${order.orderId}" style="display: inline-block; color: #088179;">
                    <span ><i style="margin-left: 30px;" class="fas fa-eye"></i></span>
                </a>
            </td>

        </tr>
    </c:forEach>
</tbody>
                    </table>
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
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
        <script src="js/scripts.js"></script>
        <script>
                                                window.addEventListener('DOMContentLoaded', event => {
                                                    const orderTable = document.getElementById('orderTable');
                                                    if (orderTable) {
                                                        const savedPage = localStorage.getItem("currentPage");
                                                        const dataTable = new simpleDatatables.DataTable(orderTable, {
                                                            searchable: true,
                                                            perPage: 10,
                                                            perPageSelect: false,
                                                            columns: [
                                                                {select: 0, sortable: true, searchable: true},
                                                                {select: 1, sortable: true, searchable: true},
                                                                {select: 2, sortable: true, searchable: true},
                                                                {select: 3, sortable: true, searchable: false},
                                                                {select: 4, sortable: false, searchable: false},
                                                                {select: 5, sortable: false, searchable: false},
                                                            ],
                                                            labels: {
                                                                noRows: "No results found.",
                                                                info: "",
                                                            }
                                                        });

                                                        if (savedPage) {
                                                            dataTable.page(parseInt(savedPage, 10));
                                                        }

                                                        dataTable.on("datatable.page", function (page) {
                                                            localStorage.setItem("currentPage", page);
                                                        });
                                                    }
                                                });

                                                function confirmCancel() {
                                                    return confirm("Are you sure you want to cancel this order?");
                                                }
        </script>
        <!--=============== MAIN JS ===============-->
        <script src="assets/js/main.js"></script>
    </body>
</html>
