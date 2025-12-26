<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
    <h2>비품 수정 (기초 기능)</h2>

    <form action="/admin/modifyItem" method="post">
        <input type="hidden" name="item_id" value="${item.item_id}">

        품목명: <input type="text" name="item_name" value="${item.item_name}"><br>
        수량: <input type="number" name="quantity" value="${item.quantity}"><br>
        가격: <input type="number" name="item_price" value="${item.item_price}"><br>

        <button type="submit">수정 완료</button>
    </form>
</body>
</html>