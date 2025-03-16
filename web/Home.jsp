<%-- 
    Document   : Home
    Created on : 25 Oct 2024, 15:53:28
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
        <link rel="stylesheet" href="assets/css/styles.css" />

        <title>Ecommerce Website</title>
        <style>
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
            <!--=============== HOME ===============-->
            <section class="home section--lg">
                <div class="home__container container grid">
                    <div class="home__content">
                        <span class="home__subtitle">Hot Promotions</span>
                        <h1 class="home__title">
                            Fashion Trending <span>Great Collection</span>
                        </h1>
                        <p class="home__description">
                            Save more with coupons & up tp 20% off
                        </p>
                        <a href="Shop.jsp" class="btn">Shop Now</a>
                    </div>
                    <img src="assets/img/home-img.png" class="home__img" alt="hats" />
                </div>
            </section>

            <!--=============== CATEGORIES ===============-->
            <section class="categories container section">
                <h3 class="section__title"><span>Popular</span> Categories</h3>
                <div class="categories__container swiper">
                    <div class="swiper-wrapper">
                        <c:forEach items="${listcategory}" var="c">
                            <a href="shop?category=${c.attributeID}" class="category__item swiper-slide">
                                <img
                                    src="${c.attributeImage}"
                                    alt=""
                                    class="category__img"
                                    />
                                <h3 class="category__title">${c.attributeName}</h3>
                            </a>
                        </c:forEach>
                    </div>

                    <div class="swiper-button-prev">
                        <i class="fi fi-rs-angle-left"></i>
                    </div>
                    <div class="swiper-button-next">
                        <i class="fi fi-rs-angle-right"></i>
                    </div>
                </div>
            </section>
            <!--=============== BRANDS ===============-->
            <section class="categories container section">
                <h3 class="section__title"><span>Popular</span> Brands</h3>
                <div class="categories__container swiper">
                    <div class="swiper-wrapper">
                        <c:forEach items="${listbrand}" var="b">
                            <a href="shop?brand=${b.attributeID}" class="category__item swiper-slide">
                                <img
                                    src="${b.attributeImage}"
                                    alt=""
                                    class="category__img"
                                    />
                                <h3 class="category__title">${b.attributeName}</h3>
                            </a>
                        </c:forEach>
                    </div>

                    <div class="swiper-button-prev">
                        <i class="fi fi-rs-angle-left"></i>
                    </div>
                    <div class="swiper-button-next">
                        <i class="fi fi-rs-angle-right"></i>
                    </div>
                </div>
            </section>

            <!--=============== PRODUCTS ===============-->
            <section class="products container section">
                <div class="tab__btns">
                    <span class="tab__btn active-tab" data-target="#featured">Featured</span>
                    <span class="tab__btn" data-target="#popular">Popular</span>
                    <span class="tab__btn" data-target="#new-added">New Added</span>
                </div>

                <div class="tab__items">
                    <div class="tab__item active-tab" content id="featured">
                        <div class="products__container grid">
                            <c:forEach items="${list8feature}" var="f">
                                <div class="product__item">
                                    <div class="product__banner">
                                        <a href="product?service=detail&productId=${f.productID}" class="product__images">
                                            <img
                                                src="${f.thumbnail}"
                                                alt=""
                                                class="product__img default"
                                                />
                                            <img
                                                src="${f.imageMore}"
                                                alt=""
                                                class="product__img hover"
                                                />
                                        </a>
                                        <div class="product__actions">
                                            <a href="product?service=detail&productId=${f.productID}" class="action__btn" aria-label="View">
                                                <i class="fi fi-rs-eye"></i>
                                            </a>
                                        </div>
                                        <div class="product__badge light-pink">Hot</div>
                                    </div>
                                    <div class="product__content">
                                        <span class="product__category">${f.categoryName}</span>
                                        <a href="product?service=detail&productId=${f.productID}">
                                            <h3 class="product__title">${f.title}</h3>
                                        </a>
                                        <div class="product__rating">
                                            <i class="fi fi-rs-star"></i>
                                            <i class="fi fi-rs-star"></i>
                                            <i class="fi fi-rs-star"></i>
                                            <i class="fi fi-rs-star"></i>
                                            <i class="fi fi-rs-star"></i>
                                        </div>
                                        <div class="product__price flex">
                                            <span class="new__price">${f.price}VNĐ</span>
                                        </div>
                                        <a
                                            href="cart?productID=${f.productID}&quantity=1&where=home"
                                            class="action__btn cart__btn"
                                            aria-label="Add To Cart"
                                            >
                                            <i class="fi fi-rs-shopping-bag-add"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="tab__item" content id="popular">
                        <div class="products__container grid">
                            <c:forEach items="${list8popular}" var="p">
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
                                        <div class="product__badge light-pink">Hot</div>
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
                                            href="cart?productID=${p.productID}&quantity=1&where=home"
                                            class="action__btn cart__btn"
                                            aria-label="Add To Cart"
                                            >
                                            <i class="fi fi-rs-shopping-bag-add"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="tab__item" content id="new-added">
                        <div class="products__container grid">
                            <c:forEach items="${list8new}" var="n">
                                <div class="product__item">
                                    <div class="product__banner">
                                        <a href="product?service=detail&productId=${n.productID}" class="product__images">
                                            <img
                                                src="${n.thumbnail}"
                                                alt=""
                                                class="product__img default"
                                                />
                                            <img
                                                src="${n.imageMore}"
                                                alt=""
                                                class="product__img hover"
                                                />
                                        </a>
                                        <div class="product__actions">
                                            <a href="product?service=detail&productId=${n.productID}" class="action__btn" aria-label="View">
                                                <i class="fi fi-rs-eye"></i>
                                            </a>                                           
                                        </div>
                                        <div class="product__badge light-pink">New</div>
                                    </div>
                                    <div class="product__content">
                                        <span class="product__category">${n.categoryName}</span>
                                        <a href="product?service=detail&productId=${n.productID}">
                                            <h3 class="product__title">${n.title}</h3>
                                        </a>
                                        <div class="product__rating">
                                            <i class="fi fi-rs-star"></i>
                                            <i class="fi fi-rs-star"></i>
                                            <i class="fi fi-rs-star"></i>
                                            <i class="fi fi-rs-star"></i>
                                            <i class="fi fi-rs-star"></i>
                                        </div>
                                        <div class="product__price flex">
                                            <span class="new__price">${n.price}VNĐ</span>
                                        </div>
                                        <a
                                            href="cart?productID=${n.productID}&quantity=1&where=home"
                                            class="action__btn cart__btn"
                                            aria-label="Add To Cart"
                                            >
                                            <i class="fi fi-rs-shopping-bag-add"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </section>

            <!--=============== DEALS ===============-->

            <!--=============== NEW ARRIVALS ===============-->
            <section class="new__arrivals container section">
                <h3 class="section__title"><span>New</span> Arrivals</h3>
                <div class="new__container swiper">
                    <div class="swiper-wrapper">
                        <c:forEach items="${list8new}" var="a">
                            <div class="product__item swiper-slide">
                                <div class="product__banner">
                                    <a href="product?service=detail&productId=${a.productID}" class="product__images">
                                        <img
                                            src="${a.thumbnail}"
                                            alt=""
                                            class="product__img default"
                                            />
                                        <img
                                            src="${a.imageMore}"
                                            alt=""
                                            class="product__img hover"
                                            />
                                    </a>
                                    <div class="product__actions">
                                        <a href="product?service=detail&productId=${a.productID}" class="action__btn" aria-label="View">
                                            <i class="fi fi-rs-eye"></i>
                                        </a>
                                    </div>
                                    <div class="product__badge light-pink">New</div>
                                </div>
                                <div class="product__content">
                                    <span class="product__category">${a.categoryName}</span>
                                    <a href="product?service=detail&productId=${a.productID}">
                                        <h3 class="product__title">${a.title}</h3>
                                    </a>
                                    <div class="product__rating">
                                        <i class="fi fi-rs-star"></i>
                                        <i class="fi fi-rs-star"></i>
                                        <i class="fi fi-rs-star"></i>
                                        <i class="fi fi-rs-star"></i>
                                        <i class="fi fi-rs-star"></i>
                                    </div>
                                    <div class="product__price flex">
                                        <span class="new__price">${a.price}VNĐ</span>
                                    </div>
                                    <a
                                        href="cart?productID=${a.productID}&quantity=1&where=home"
                                        class="action__btn cart__btn"
                                        aria-label="Add To Cart"
                                        >
                                        <i class="fi fi-rs-shopping-bag-add"></i>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="swiper-button-prev">
                        <i class="fi fi-rs-angle-left"></i>
                    </div>
                    <div class="swiper-button-next">
                        <i class="fi fi-rs-angle-right"></i>
                    </div>
                </div>
            </section>

            <!--=============== NEWSLETTER ===============-->
            <section class="newsletter section home__newsletter">
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

