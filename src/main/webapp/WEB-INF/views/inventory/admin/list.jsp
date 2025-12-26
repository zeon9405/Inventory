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

.deleted-row {
	background-color: #f9f9f9;
	color: #aaa;
}

.status-deleted {
	color: red;
	font-weight: bold;
}
</style>
</head>
<body>
	<h2>사무실 비품 재고 목록 (관리자용)</h2>
	<div class="nav">
		<a href="/">메인페이지</a> | <a
			href="${pageContext.request.contextPath}/admin/itemRegForm">새물품등록하기</a>
	</div>

	<table>
		<tr>
			<th>비품번호</th>
			<th>품목명</th>
			<th>수량</th>
			<th>상태</th>
			<th>등록일</th>
			<th>관리</th>
		</tr>
		<c:forEach var="item" items="${itemList}">
			<tr class="${item.status == 'deleted' ? 'deleted-row' : ''}">
				<td>${item.item_id}</td>
				<td>${item.item_name}</td>
				<td>${item.quantity}</td>
				<td><c:choose>
						<c:when test="${item.status == 'deleted'}">
							<span class="status-deleted">삭제됨</span>
						</c:when>
						<c:otherwise>
                            ${item.status}
                        </c:otherwise>
					</c:choose></td>
				<td>${item.reg_date}</td>
				<td><c:if test="${item.status != 'deleted'}">
						<a
							href="${pageContext.request.contextPath}/admin/editForm?item_id=${item.item_id}">[수정]</a>
						<a
							href="${pageContext.request.contextPath}/admin/deleteItem?item_id=${item.item_id}"
							onclick="return confirm('정말 삭제하시겠습니까?');">[삭제]</a>
					</c:if> <c:if test="${item.status == 'deleted'}">
						<span>-</span>
					</c:if></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>