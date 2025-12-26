<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
    <tr>
        <th>번호</th>
        <th>대여자(ID)</th>
        <th>품목명</th>
        <th>대여일</th>
        <th>반납예정일</th>
        <th>반납상태</th>
    </tr>
    <c:forEach var="r" items="${allRentals}">
        <tr ${empty r.ret_act_date && r.ret_exp_date < today ? 'style="background-color:#ffe6e6;"' : ''}>
            <td>${r.rental_id}</td>
            <td>${r.emp_name}(${r.emp_id})</td>
            <td>${r.item_name}</td>
            <td><fmt:formatDate value="${r.rent_date}" pattern="yyyy-MM-dd"/></td>
            <td><fmt:formatDate value="${r.ret_exp_date}" pattern="yyyy-MM-dd"/></td>
            <td>
                <c:choose>
                    <c:when test="${not empty r.ret_act_date}">
                        <span style="color:gray;">반납완료(<fmt:formatDate value="${r.ret_act_date}" pattern="MM-dd"/>)</span>
                    </c:when>
                    <c:when test="${r.ret_exp_date < today}">
                        <span style="color:red; font-weight:bold;">연체 중</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color:blue;">대여 중</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>
<br>
<a href="${pageContext.request.contextPath}/admin/adminPage">
    <button type="button">돌아가기</button>
</a>
</body>
</html>