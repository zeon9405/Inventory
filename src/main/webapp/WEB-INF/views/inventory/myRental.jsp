<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 대여 현황</title>
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
	background-color: #e2f0d9;
}

h2 {
	text-align: center;
	margin-top: 30px;
}

.nav {
	text-align: center;
	margin-bottom: 20px;
}

.btn-back {
	padding: 5px 15px;
	background-color: #666;
	color: white;
	text-decoration: none;
	border-radius: 3px;
}
</style>
</head>
<body>
	<h2>나의 비품 대여 현황</h2>

	<div class="nav">
		<a href="/" class="btn-back">메인페이지</a>
	</div>

	<table>
		<tr>
			<th>대여번호</th>
			<th>품목명</th>
			<th>대여일</th>
			<th>반납예정일</th>
			<th>상태</th>
			<th>관리</th>
		</tr>
		<c:forEach var="rental" items="${myRentals}">
			<tr>
				<td>${rental.rental_id}</td>
				<td>${rental.item_name}</td>
				<td><fmt:formatDate value="${rental.rent_date}"
						pattern="yyyy-MM-dd" /></td>
				<td><fmt:formatDate value="${rental.ret_exp_date}"
						pattern="yyyy-MM-dd" /></td>
				<td><c:choose>
						<c:when test="${empty rental.ret_act_date}">
							<span style="color: blue; font-weight: bold;">대여 중</span>
						</c:when>
						<c:otherwise>
							<span style="color: gray;">반납 완료</span>
						</c:otherwise>
					</c:choose></td>
				<td><c:if test="${empty rental.ret_act_date}">
						<%-- 아직 반납 안 한 경우에만 버튼 노출 --%>
						<a
							href="<c:url value='/returnItem?rental_id=${rental.rental_id}&item_id=${rental.item_id}'/>">
							<button type="button">반납하기</button>
						</a>
					</c:if> <c:if test="${not empty rental.ret_act_date}">
						<%-- 반납 완료된 경우 완료 날짜 표시 --%>
						<small><fmt:formatDate value="${rental.ret_act_date}"
								pattern="MM-dd" /> 반납함</small>
					</c:if></td>
			</tr>
		</c:forEach>
		<c:if test="${empty myRentals}">
			<tr>
				<td colspan="6">현재 대여 중인 물품이 없습니다.</td>
			</tr>
		</c:if>
	</table>
</body>
</html>