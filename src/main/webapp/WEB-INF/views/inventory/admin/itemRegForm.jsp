<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/admin/insertNewItem" method="post">
    물품명: <input type="text" name="item_name"><br>
    카테고리: <input type="number" name="cat_id"><br>
    가격: <input type="number" name="item_price"><br>
    수량: <input type="number" name="quantity"><br>
    <button type="submit">등록하기</button>
    <a href="${pageContext.request.contextPath}/admin/adminPage">돌아가기</a>
</form>
</body>
</html>