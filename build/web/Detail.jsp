<%-- 
    Document   : Detail
    Created on : 25 Oct 2024, 15:53:39
    Author     : Anh Tuan
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <style>
            .size__link {
    display: block;
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    text-align: center;
    text-decoration: none;
    color: #333;
    transition: background-color 0.3s, border-color 0.3s;
}

.size__link.size-active {
    background-color: #24876b;
    
    color: #fff;
}
/* Style for the dropdown container */
.details__size {
    margin-top: 20px;
}

.details__size-title {
    font-size: 1.1rem;
    font-weight: 600;
    color: #333;
    margin-bottom: 10px;
    display: block;
}

/* Style for the select dropdown */
#size {
    width: 150px; /* Shorter width */
    padding: 10px 15px;
    border: 2px solid #24876b;
    border-radius: 8px;
    background-color: #fff;
    font-size: 1rem;
    color: #333;
    appearance: none; /* Remove default arrow */
    cursor: pointer;
    transition: border-color 0.3s, box-shadow 0.3s;
}

#size:hover {
    border-color: #1a6b54;
}

#size:focus {
    outline: none;
    border-color: #24876b;
    box-shadow: 0 0 8px rgba(36, 135, 107, 0.3);
}

/* Custom dropdown arrow */
.select-wrapper {
    position: relative;
    width: 150px; /* Match the width of the dropdown */
}

.select-wrapper::after {
    content: "▼";
    position: absolute;
    top: 50%;
    right: 15px;
    transform: translateY(-50%);
    font-size: 0.8rem;
    color: #24876b;
    pointer-events: none;
}

/* Style for the dropdown options */
#size option {
    padding: 10px;
    background-color: #fff;
    color: #333;
    font-size: 1rem;
}

#size option:hover {
    background-color: #24876b;
    color: #fff;
}
        </style>

        
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
            .product__banner {
                height: 400px;
                overflow: hidden;
            }

            .product__img {
                width: 100%;
                height: auto;
            }
            .details__img {
                width: 100%; /* Để ảnh chính chiếm toàn bộ chiều rộng của phần chứa */
                max-width: 600px; /* Giới hạn chiều rộng tối đa */
                min-width: 300px; /* Giới hạn chiều rộng tối thiểu */
                height: auto; /* Giữ tỷ lệ của ảnh */
                object-fit: contain; /* Giúp ảnh không bị cắt xén nếu không đúng tỷ lệ */
            }

            .details__small-img {
                width: 100px; /* Chiều rộng ảnh nhỏ */
                height: 100px; /* Chiều cao ảnh nhỏ */
                max-width: 150px; /* Chiều rộng tối đa cho ảnh nhỏ */
                max-height: 150px; /* Chiều cao tối đa cho ảnh nhỏ */
                object-fit: cover; /* Đảm bảo ảnh nhỏ phủ đầy ô nhưng có thể bị cắt nếu không khớp tỷ lệ */
                margin-right: 10px; /* Khoảng cách giữa các ảnh nhỏ */
            }

            .details__small-images {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(100px, 1fr)); /* Tự động điều chỉnh cột cho ảnh nhỏ */
                gap: 10px; /* Khoảng cách giữa các ảnh nhỏ */
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
                    <li><span class="breadcrumb__link">Fashion</span></li>
                    <li><span class="breadcrumb__link"></span>/</li>
                    <li><span class="breadcrumb__link">${detail.title}</span></li>
                </ul>
            </section>

            <!--=============== DETAILS ===============-->
            <section class="details section--lg">
                <div class="details__container container grid">
                    <div class="details__group">
                        <img
                            src="${detail.thumbnail}"
                            alt=""
                            class="details__img"
                            />
                        <div class="details__small-images grid">
                            <c:forEach items="${image}" var="s">
                                <img
                                    src="${s.imageMore}"
                                    alt=""
                                    class="details__small-img"
                                    />
                            </c:forEach>
                        </div>
                    </div>
                    <div class="details__group">
                        <h3 class="details__title">${detail.title}</h3>
                        <p class="details__brand">Brand: <span>${detail.brandName}</span></p>
                        <div class="details__price flex">
                            <span class="new__price">VND ${detail.price}</span>
                            <!--                            <span class="old__price">$200.00</span>
                                                        <span class="save__price">25% Off</span>-->
                        </div>
                        <p class="short__description">
                            ${detail.description}
                        </p>
                        <ul class="products__list">
                            <li class="list__item flex">
                                <i class="fi-rs-crown"></i> 1 Year Al Jazeera Brand Warranty
                            </li>
                            <li class="list__item flex">
                                <i class="fi-rs-refresh"></i> 30 Days Return Policy
                            </li>
                            <li class="list__item flex">
                                <i class="fi-rs-credit-card"></i> Cash on Delivery available
                            </li>
                        </ul>
                        <div class="details__color flex">
                            <span class="details__color-title">Quantity</span>
                            <ul class="color__list">
                                <li>
                                    ${detail.quantity}
                                </li>

                            </ul>
                        </div>
<div class="details__size flex">
    <span class="details__size-title">Size</span>
    <ul class="size__list">
        <c:forEach var="size" items="${sizes}">
            <li>
                <a href="#" class="size__link" data-size-id="${size.sizeID}" onclick="selectSize(this)">
                    ${size.sizeName}
                </a>
            </li>
        </c:forEach>
    </ul>
    <!-- Hidden input to store the selected sizeID -->
    <input type="hidden" id="selectedSize" name="selectedSize" value="">
</div>

<form action="cart" method="GET">
    <input type="hidden" name="productID" value="${detail.productID}">
    <input type="hidden" name="where" value="detail">
    
    <label for="size">Choose Size:</label>
    <div class="details__size">
        <span class="details__size-title">Size</span>
        <div class="select-wrapper">
            <select name="selectedSize" id="size">
                <option value="">Select Size</option>
                <!-- Loop through the sizes list and generate options -->
                <c:forEach var="size" items="${sizes}">
                    <option value="${size.sizeID}">${size.sizeName}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <input type="number" name="quantity" value="1" min="1" max="${detail.quantity}">
    <button type="submit">Add to Cart</button>
</form>


</div>
                    </div>
                </div>
            </section>

            <!--=============== DETAILS TAB ===============-->



            <!--=============== PRODUCTS ===============-->
            <section class="products container section--lg">
                <h3 class="section__title"><span>Related</span> Products</h3>
                <div class="products__container grid">
                    <c:forEach items="${listRelated}" var="p">
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
                                <span class="product__category">Clothing</span>
                                <a href="details.html">
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
                                    <span class="new__price">$${p.price}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>


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
        <script>
function selectSize(sizeLink) {
    // Remove 'size-active' class from all size links
    document.querySelectorAll('.size__link').forEach(link => link.classList.remove('size-active'));

    // Add 'size-active' class to the selected link
    sizeLink.classList.add('size-active');

    // Get sizeID from the clicked link
    const sizeID = sizeLink.getAttribute("data-size-id");

    // Store the sizeID in the hidden input field
    document.getElementById("selectedSize").value = sizeID;
}

document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");
    if (form) {
        form.addEventListener("submit", (event) => {
            const selectedSize = document.getElementById("selectedSize").value;
            if (!selectedSize) {
                alert("Please select a size before adding to cart.");
                event.preventDefault();
            }
        });
    }
});

</script>
    </body>
</html>

