
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
                    <li><span class="breadcrumb__link">Orders</span></li>
                </ul>
            </section>

            <div>
                <c:if test="${not empty mess}">
                    <div class="alert alert-success" role="alert">
                        ${mess}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>
            </div>



            <!--=============== CART ===============-->
            <section class="cart section--lg container">
                <div class="table__container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Order Id</th>
                                <th>Order Status</th>
                                <th>Order Sale Note</th>
                                <th>Order Date</th>
                                <th>Order Detail</th>
                                <th>Action</th>

                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach items="${listOrder}" var="listOrder">
                                <tr>
                                    <td>
                                        <span class="">${listOrder.orderId}</span>
                                    </td>
                                    <td> <span class="">${listOrder.orderStatus}</span></td>
                                    <td><span class="">${listOrder.orderSaleNote}</span></td>
                                    <td><span class="">${listOrder.orderDate}</span></td>
                                    <td>
                                        <a href="orderDetail?orderId=${listOrder.orderId}">
                                            <span class=""><i class="fas fa-eye"></i></span>
                                        </a>


                                    </td>
                                    <td>
                                        <c:if test="${listOrder.orderStatus != 'Completed' && listOrder.orderStatus != 'Cancel'}">
                                            <form action="manager-order" method="post" onsubmit="return confirmCancel()" class="inline-form">
                                                <input type="hidden" name="action" value="updateOrderStatus">
                                                <input type="hidden" name="orderId" value="${listOrder.orderId}">

                                                <div class="form-group d-flex align-items-center">
                                                    <select name="newStatus" class="form-control select-status" required>
                                                        <option value="">Select Status</option>
                                                        <option value="Pending">Pending</option>
                                                        <option value="Processing">Processing</option>
                                                        <option value="Shipped">Shipped</option>
                                                        <option value="Delivered">Delivered</option>
                                                        <option value="Cancel">Cancel</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-primary update-btn">Update</button>
                                                </div>
                                            </form>
                                        </c:if>
                                    </td>

                            <style>
                                /* Inline form customization */
                                .inline-form .form-group {
                                    display: flex;
                                    align-items: center;
                                }

                                .select-status {
                                    width: 150px;
                                    margin-right: 8px;
                                    border-radius: 4px;
                                    font-size: 14px;
                                }

                                /* Button styling */
                                .update-btn {
                                    padding: 5px 12px;
                                    font-size: 14px;
                                    border-radius: 4px;
                                }

                                .form-group {
                                    gap: 8px;
                                }

                            </style>

                            <script>
                                function confirmCancel() {
                                    return confirm("Are you sure you want to cancel this order?");
                                }
                            </script>

                            </tr>
                        </c:forEach>


                        </tbody>
                    </table>
                    <div class="pagination">
                        <button id="prevPage" class="pagination__button" disabled>Previous</button>
                        <span id="pageInfo" class="pagination__info"></span>
                        <button id="nextPage" class="pagination__button">Next</button>
                    </div>
                    <script>
                        const rowsPerPage = 6; // Số hàng hiển thị trên mỗi trang
                        const tableRows = document.querySelectorAll(".table tbody tr"); // Lấy tất cả các hàng trong bảng
                        const totalPages = Math.ceil(tableRows.length / rowsPerPage); // Tính số trang
                        let currentPage = 1; // Trang hiện tại

                        // Hàm hiển thị hàng cho trang hiện tại
                        function displayRows(page) {
                            const start = (page - 1) * rowsPerPage; // Tính chỉ số hàng bắt đầu
                            const end = start + rowsPerPage; // Tính chỉ số hàng kết thúc

                            tableRows.forEach((row, index) => {
                                row.style.display = index >= start && index < end ? "" : "none"; // Hiển thị hoặc ẩn hàng
                            });

                            // Cập nhật thông tin số trang
                            document.getElementById("pageInfo").innerText = `${page} / ${totalPages}`; // Hiển thị số trang

                                    // Cập nhật trạng thái của nút Previous và Next
                                    document.getElementById("prevPage").disabled = page === 1; // Vô hiệu hóa nút Previous nếu là trang đầu
                                    document.getElementById("nextPage").disabled = page === totalPages; // Vô hiệu hóa nút Next nếu là trang cuối
                                }

                                // Hàm thiết lập phân trang
                                function setupPagination() {
                                    document.getElementById("prevPage").addEventListener("click", () => {
                                        if (currentPage > 1) {
                                            currentPage--;
                                            displayRows(currentPage);
                                        }
                                    });

                                    document.getElementById("nextPage").addEventListener("click", () => {
                                        if (currentPage < totalPages) {
                                            currentPage++;
                                            displayRows(currentPage);
                                        }
                                    });

                                    displayRows(currentPage);
                                }

                                window.onload = setupPagination;
                    </script>





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

