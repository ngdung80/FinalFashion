<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <div class="register">
                        <h3 class="section__title">Create an Account</h3>
                        <form class="form grid" id="submitForm" action="signup" method="post">
                            <input type="hidden" name="_csrf" value="7635eb83-1f95-4b32-8788-abec2724a9a4"> 
                            <input
                                type="text" name="user"
                                placeholder="User Name"
                                value="${user}"
                                class="form__input" required=""
                                />
                            <input
                                type="email" name="email"
                                placeholder="Your Email" 
                                value="${email}"
                                class="form__input" required=""
                                />
                            <input
                                type="password"
                                placeholder="Your Password" name="pass"
                                value="${pass}"
                                class="form__input" required=""
                                />
                            <input
                                type="password"
                                placeholder="Confirm Password" name="repass"
                                value="${repass}"
                                class="form__input" required=""
                                />
                            <lSabel style="color: red">${requestScope.error}</lSabel>
                                <%
                if(request.getAttribute("in")!=null){
                String er = (String)request.getAttribute("in");
            
                                %>
                            <div class="error-message">
                                <h3 style="color: red;"><%= er %></h3>
                            </div>
                            <%
                                }
                            %>
                            <%
                            if(request.getAttribute("duplicate")!=null){
                            String er = (String)request.getAttribute("duplicate");
            
                            %>
                            <div class="error-message">
                                <h3 style="color: red;"><%= er %></h3>
                            </div>
                            <%
                                }
                            %>
                            <div class="form__btn">
                                <button class="btn" type="submit">Submit & Register</button>
                                <button type="button"class="btn" style="margin-left: 300px;" onclick="window.location.href = 'Login.jsp';">Login</button>
                            </div>
                        </form>
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
