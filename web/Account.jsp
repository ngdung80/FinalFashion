<%-- 
    Document   : Account
    Created on : 25 Oct 2024, 15:53:45
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
                    <li><a href="home" class="breadcrumb__link">Home</a></li>
                    <li><span class="breadcrumb__link">></span></li>
                    <li><span class="breadcrumb__link">Account</span></li>
                </ul>
            </section>

            <!--=============== ACCOUNTS ===============-->
            <section class="accounts section--lg">
                <div class="accounts__container container grid">
                    <div class="account__tabs">
                        <!--                        <p class="account__tab active-tab" data-target="#dashboard">
                                                    <i class="fi fi-rs-settings-sliders"></i> Dashboard
                                                </p>-->
                        <!--                        <p class="account__tab" data-target="#orders">
                                                    <i class="fi fi-rs-shopping-bag"></i> Orders
                                                </p>-->
                        <p class="account__tab active-tab" data-target="#update-profile">
                            <i class="fi fi-rs-user"></i> Update Profile
                        </p>
                        <!--                        <p class="account__tab" data-target="#address">
                                                    <i class="fi fi-rs-marker"></i> My Address
                                                </p>
                                                <p class="account__tab" data-target="#change-password">
                                                    <i class="fi fi-rs-settings-sliders"></i> Change Password
                                                </p>-->
                        <p class="account__tab"><a href="logout"><i class="fi fi-rs-exit"></i> Logout</a></p>>
                    </div>
                    <div class="tabs__content">
                        <!--                        <div class="tab__content active-tab" content id="dashboard">
                                                    <h3 class="tab__header">Hello Rosie</h3>
                                                    <div class="tab__body">
                                                        <p class="tab__description">
                                                            From your account dashboard. you can easily check & view your
                                                            recent order, manage your shipping and billing addresses and
                                                            edit your password and account details
                        
                        
                                                        </p>
                                                    </div>
                                                </div>-->
                        <!--                        <div class="tab__content" content id="orders">
                                                    <h3 class="tab__header">Your Orders</h3>
                                                    <div class="tab__body">
                                                        <table class="placed__order-table">
                                                            <thead>
                                                                <tr>
                                                                    <th>Orders</th>
                                                                    <th>Date</th>
                                                                    <th>Status</th>
                                                                    <th>Totals</th>
                                                                    <th>Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td>#1357</td>
                                                                    <td>March 19, 2022</td>
                                                                    <td>Processing</td>
                                                                    <td>$125.00</td>
                                                                    <td><a href="#" class="view__order">View</a></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>#2468</td>
                                                                    <td>June 29, 2022</td>
                                                                    <td>Completed</td>
                                                                    <td>$364.00</td>
                                                                    <td><a href="#" class="view__order">View</a></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>#2366</td>
                                                                    <td>August 02, 2022</td>
                                                                    <td>Completed</td>
                                                                    <td>$280.00</td>
                                                                    <td><a href="#" class="view__order">View</a></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>-->
                        <div class="tab__content active-tab" content id="update-profile">
                            <h3 class="tab__header">Update Profile</h3>
                            <div class="tab__body">
                                <div style="color: red" id="messageContainer">${message}</div>

                                <script>
                                    setTimeout(() => {
                                        const messageContainer = document.getElementById('messageContainer');
                                        if (messageContainer) {
                                            messageContainer.style.display = 'none';
                                        }
                                    }, 4000); // 4000ms = 4s
                                </script>

                                <form class="form grid" action="account2" method="get" onsubmit="return validatePasswordMatch()">
                                    <input type="hidden" name="service" value="updateAccount">

                                    <label for="userID">User ID</label>
                                    <input
                                        type="text"
                                        id="userID"
                                        readonly
                                        placeholder="${currentUser.getUserID()}"
                                        class="form__input"
                                        />

                                    <label for="username">Username</label>
                                    <input
                                        type="text"
                                        id="username"
                                        readonly
                                        placeholder="${currentUser.getUsername()}"
                                        class="form__input"
                                        />

                                    <label for="email">Email</label>
                                    <input
                                        type="text"
                                        id="email"
                                        readonly
                                        placeholder="hàm UserDAO.login() chưa lấy được email nên không hiển thị được"
                                        class="form__input"
                                        />

                                    <label for="role">Role</label>
                                    <c:choose>
                                        <c:when test="${currentUser.getRole() == 1}">
                                            <input
                                                type="text"
                                                id="role"
                                                readonly
                                                placeholder="Admin"
                                                class="form__input"
                                                />
                                        </c:when>
                                        <c:when test="${currentUser.getRole() == 2}">
                                            <input
                                                type="text"
                                                id="role"
                                                readonly
                                                placeholder="Marketing"
                                                class="form__input"
                                                />
                                        </c:when>
                                        <c:when test="${currentUser.getRole() == 3}">
                                            <input
                                                type="text"
                                                id="role"
                                                readonly
                                                placeholder="Sale"
                                                class="form__input"
                                                />
                                        </c:when>
                                        <c:otherwise>
                                            <input
                                                type="text"
                                                id="role"
                                                readonly
                                                placeholder="Customer"
                                                class="form__input"
                                                />
                                        </c:otherwise>
                                    </c:choose>



                                    <label for="currentPassword">Current Password</label>
                                    <input
                                        type="password"
                                        name="currentPassword"
                                        id="currentPassword"
                                        class="form__input"
                                        />

                                    <label for="newPassword">New Password</label>
                                    <input
                                        type="password"
                                        name="newPassword"
                                        id="newPassword"
                                        class="form__input"
                                        />

                                    <label for="confirmPassword">Confirm Password</label>
                                    <input
                                        type="password"
                                        name="confirmPassword"
                                        id="confirmPassword"
                                        class="form__input"
                                        />
                                    <small id="passwordMismatchAlert" style="color: red; display: none;">New Password and Confirm Password does not match!</small>


                                    <div class="form__btn">
                                        <button class="btn btn--md">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <script>
                            document.getElementById('confirmPassword').addEventListener('input', function () {
                                const newPassword = document.getElementById('newPassword').value;
                                const confirmPassword = document.getElementById('confirmPassword').value;
                                const mismatchAlert = document.getElementById('passwordMismatchAlert');

                                if (newPassword && confirmPassword && newPassword !== confirmPassword) {
                                    mismatchAlert.style.display = 'inline';
                                } else {
                                    mismatchAlert.style.display = 'none';
                                }
                            });

                            function validatePasswordMatch() {
                                const newPassword = document.getElementById('newPassword').value;
                                const confirmPassword = document.getElementById('confirmPassword').value;

                                if (newPassword !== confirmPassword) {
                                    document.getElementById('passwordMismatchAlert').style.display = 'inline';
                                    return false; // Chặn submit nếu mật khẩu không khớp
                                }
                                return true; // Cho phép submit nếu mật khẩu khớp
                            }
                        </script>
                        <!--
                                                <div class="tab__content" content id="address">
                                                    <h3 class="tab__header">Shipping Address</h3>
                                                    <div class="tab__body">
                                                        <address class="address">
                                                            3522 Interstate <br />
                                                            75 Business Spur, <br />
                                                            Sault Ste. <br />
                                                            Marie, Mi 49783
                                                        </address>
                                                        <p class="city">New York</p>
                                                        <a href="#" class="edit">Edit</a>
                                                    </div>
                                                </div>
                                                <div class="tab__content" content id="change-password">
                                                    <h3 class="tab__header">Change Password</h3>
                                                    <div class="tab__body">
                                                        <form class="form grid">
                                                            <input
                                                                type="password"
                                                                placeholder="Current Password"
                                                                class="form__input"
                                                                />
                                                            <input
                                                                type="password"
                                                                placeholder="New Password"
                                                                class="form__input"
                                                                />
                                                            <input
                                                                type="password"
                                                                placeholder="Confirm Password"
                                                                class="form__input"
                                                                />
                                                            <div class="form__btn">
                                                                <button class="btn btn--md">Save</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>-->
                    </div>
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
