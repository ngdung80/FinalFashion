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
                    <li><span class="breadcrumb__link">Login / Register</span></li>
                </ul>
            </section>

            <!--=============== LOGIN-REGISTER ===============-->
            <section class="login-register section--lg">
                <div class="login-register__container container grid">
                    <div class="login">
                        <h3 class="section__title">Login</h3>
                        <form class="form grid" action="login" method="post">
                            <% if(request.getAttribute("error") != null) { 
                String errorMsg = (String) request.getAttribute("error"); %>
                            <div>
                                <h3 style="color: red;"><%= errorMsg %></h3>
                            </div>

                            <% } %>
                            <% if(request.getAttribute("announce") != null) { 
                String successMsg = (String) request.getAttribute("announce"); %>
                            <div class="alert alert-success text-center">
                                <h3><%= successMsg %></h3>
                            </div>
                            <% } %>
                            <input
                                type="text" name="user"
                                placeholder="Your Email"
                                class="form__input"
                                value="${cookie.cookname.value}"
                                />
                            <input
                                type="password" name="pass"
                                placeholder="Your Password"
                                class="form__input"
                                value="${cookie.cookpass.value}"
                                />
                            <div class="form-check mb-3 text-left">
                                <input name="remember" value="on" ${cookie.cookremember.value == "on"?"checked":""} type="checkbox" class="form-check-input" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <div class="form__btn">
                                <button type="submit" class="btn">Login</button>
                                <button type="button"class="btn" style="margin-left: 300px;" onclick="window.location.href='Register.jsp';">Register</button>
                            </div>
                        </form>
                    </div>
                    <!--          <div class="register">
                                <h3 class="section__title">Create an Account</h3>
                                <form class="form grid">
                                  <input
                                    type="text"
                                    placeholder="Username"
                                    class="form__input"
                                  />
                                  <input
                                    type="email"
                                    placeholder="Your Email"
                                    class="form__input"
                                  />
                                  <input
                                    type="password"
                                    placeholder="Your Password"
                                    class="form__input"
                                  />
                                  <input
                                    type="password"
                                    placeholder="Confirm Password"
                                    class="form__input"
                                  />
                                  <div class="form__btn">
                                    <button class="btn">Submit & Register</button>
                                  </div>
                                </form>
                              </div>-->
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
