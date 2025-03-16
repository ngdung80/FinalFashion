<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Detail</title>
</head>
<body>
    <h1>User Detail</h1>
    <form action="listUser" method="get">
    <c:choose>
        <c:when test="${user != null}">
            <p><strong>ID:</strong> ${user.userID}</p>
            <p><strong>Name:</strong> ${user.userName}</p>
            <p><strong>Gender:</strong> ${user.gender}</p>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Role:</strong> ${user.roleName}</p>
        </c:when>
        <c:otherwise>
            <p>User not found.</p>
        </c:otherwise>
    </c:choose>
    </form>
</body>
</html>
