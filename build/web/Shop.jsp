<%-- 
    Document   : Shop
    Created on : 25 Oct 2024, 15:56:20
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
        <style>
            .page-item.active .pagination__link {
                background-color: #088179;
                color: white;
                border: 1px solid #088179;
            }
            .product__banner {
                height: 400px;
                overflow: hidden;
            }

            .product__img {
                width: 100%;
                height: auto;
            }

        </style>
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
                    <li><span class="breadcrumb__link">Shop</span></li>
                </ul>
            </section>

            <!--=============== PRODUCTS ===============-->
            <section class="products container section--lg">
                <div class="search-sort-container" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding: 15px; border: 1px solid #88C8BC; border-radius: 10px; background-color: #f9f9f9;">
                    <form action="shop" method="GET" class="search-sort-form" style="display: flex; align-items: center;">
                        <input type="hidden" name="brand" value="${brand}">
                        <input type="hidden" name="category" value="${category}">
                        <input type="text" name="search" placeholder="Search Products..." value="${search}" style="padding: 12px; border: 1px solid #ccc; border-radius: 4px; margin-right: 10px; width: 250px; font-size: 16px;">
                        <select name="sort" style="padding: 12px; border: 1px solid #ccc; border-radius: 4px; margin-right: 10px; font-size: 16px;">
                            <option value="">Sort By</option>
                            <option value="ASC" ${sort == 'ASC' ? 'selected' : ''}>Price: Low to High</option>
                            <option value="DESC" ${sort == 'DESC' ? 'selected' : ''}>Price: High to Low</option>
                        </select>
                        <button type="submit" style="padding: 12px 16px; border: none; border-radius: 4px; background-color: #088179; color: white; cursor: pointer; font-size: 16px;">Search</button>
                    </form>  
                </div>
                <div class="products__container grid">
                    <c:forEach items="${listallproduct}" var="p">
                        <div class="product__item">
                            <div class="product__banner">
                                <a href="product?service=detail&productId=${p.productID}" class="product__images">
                                    <img
                                        src="${p.thumbnail}"
                                        alt=""
                                        class="product__img default"
                                        />
                                    <img
                                        src="${p.imageMore}"
                                        alt=""
                                        class="product__img hover"
                                        />
                                </a>
                                <div class="product__actions">
                                    <a href="product?service=detail&productId=${p.productID}" class="action__btn" aria-label="View">
                                        <i class="fi fi-rs-eye"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="product__content">
                                <span class="product__category">${p.categoryName}</span>
                                <a href="product?service=detail&productId=${p.productID}">
                                    <h3 class="product__title">${p.title}</h3>
                                </a>
                                <div class="product__rating">
                                    <i class="fi fi-rs-star"></i>
                                    <i class="fi fi-rs-star"></i>
                                    <i class="fi fi-rs-star"></i>
                                    <i class="fi fi-rs-star"></i>
                                    <i class="fi fi-rs-star"></i>
                                </div>
                                <div class="product__price flex">
                                    <span class="new__price">${p.price}VNĐ</span>
                                </div>
                                <a
                                    href="cart?productID=${p.productID}&quantity=1&where=shop"
                                    class="action__btn cart__btn"
                                    aria-label="Add To Cart"
                                    >
                                    <i class="fi fi-rs-shopping-bag-add"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <ul class="pagination">
                    <c:set var="startPage" value="${page - 2 > 0 ? page - 2 : 1}" />
                    <c:set var="endPage" value="${page + 2 <= total ? page + 2 : total}" />

                    <c:if test="${page > 1}">
                        <li>
                            <a href="shop?page=1&category=${category}&brand=${brand}&search=${search}&sort=${sort}" class="pagination__link"> Begin </a>
                        </li>
                        <li>
                            <a href="shop?page=${page - 1}&category=${category}&brand=${brand}&search=${search}&sort=${sort}" class="pagination__link" style="margin-right: 15px;"> Pre </a>
                        </li>
                    </c:if>

                    <c:forEach var="p" begin="${startPage}" end="${endPage}">
                        <li class="page-item ${p == page ? 'active' : ''}">
                            <a href="shop?page=${p}&category=${category}&brand=${brand}&search=${search}&sort=${sort}" class="pagination__link">${p}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${page < total}">
                        <li >
                            <a href="shop?page=${page + 1}&category=${category}&brand=${brand}&search=${search}&sort=${sort}" class="pagination__link"> Next </a>
                        </li>
                        <li >
                            <a href="shop?page=${total}&category=${category}&brand=${brand}&search=${search}&sort=${sort}" class="pagination__link"> End </a>
                        </li>
                    </c:if>
                </ul>
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

