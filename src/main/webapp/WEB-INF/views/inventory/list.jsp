<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사무실 비품 목록</title>
<style>
table {
	border-collapse: collapse;
	width: 80%;
	margin: 20px auto;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

h2 {
	text-align: center;
}
</style>
</head>
<body>
	<h2>사무실 비품 재고 목록</h2>
	<table>
        <tr>
            <th>비품번호</th>
            <th>품목명</th>
            <th>수량</th>
            <th>등록일</th>
            <th>관리</th> </tr>
        <c:forEach var="item" items="${itemList}">
            <tr>
                <td>${item.item_id}</td>
                <td>${item.item_name}</td>
                <td>${item.quantity}</td>
                <td>${item.reg_date}</td>
                <td>
                    <c:if test="${item.quantity > 0}">
                       <button onclick="location.href='./rentItem?item_id=${item.item_id}'">대여하기</button>
                    </c:if>
                    <c:if test="${item.quantity <= 0}">
                        <span style="color: red;">품절</span>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>