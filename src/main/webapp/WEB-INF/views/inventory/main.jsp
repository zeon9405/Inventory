<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
메인페이지입니다.
<br>
<c:if test="${sessionScope.user eq null}">
	<a href="/loginPage">로그인</a>
</c:if>
<c:if test="${sessionScope.user ne null}">
	<c:out value="${sessionScope.user}"/>
	<a href="/logoutPage">로그아웃</a>
</c:if>
<br>
<a href="/itemList">물품대여리스트</a>
<br>
<a href="/myRental">내 대여 목록</a>
</body>
</html>