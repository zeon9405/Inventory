<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 대여 현황 | 비품 관리 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 50px; margin-bottom: 50px; }
        .rental-card { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .table thead { background-color: #f1f3f5; }
        .status-badge { font-size: 0.85rem; padding: 0.5em 0.8em; }
    </style>
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold text-dark m-0">📋 나의 비품 대여 현황</h2>
        <a href="/" class="btn btn-outline-secondary shadow-sm">
            메인페이지로 돌아가기
        </a>
    </div>

    <div class="rental-card">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr class="text-secondary">
                        <th class="text-center">번호</th>
                        <th>품목명</th>
                        <th class="text-center">대여일</th>
                        <th class="text-center">반납예정일</th>
                        <th class="text-center">상태</th>
                        <th class="text-center">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="rental" items="${myRentals}">
                        <tr>
                            <td class="text-center text-muted small">${rental.rental_id}</td>
                            <td class="fw-bold">${rental.item_name}</td>
                            <td class="text-center"><fmt:formatDate value="${rental.rent_date}" pattern="yyyy-MM-dd" /></td>
                            <td class="text-center"><fmt:formatDate value="${rental.ret_exp_date}" pattern="yyyy-MM-dd" /></td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${empty rental.ret_act_date && rental.status == 'deleted'}">
                                        <span class="badge rounded-pill bg-danger status-badge">삭제된 비품</span>
                                    </c:when>
                                    <c:when test="${empty rental.ret_act_date}">
                                        <span class="badge rounded-pill bg-primary status-badge">대여 중</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge rounded-pill bg-light text-dark border status-badge">반납 완료</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:if test="${empty rental.ret_act_date}">
                                    <c:choose>
                                        <c:when test="${rental.status == 'deleted'}">
                                            <a href="<c:url value='/returnDeletedItem?rental_id=${rental.rental_id}'/>"
                                               class="btn btn-outline-danger btn-sm"
                                               onclick="return confirm('이미 삭제 처리된 비품입니다. 대여 목록에서 지우시겠습니까?');">
                                                목록 삭제
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<c:url value='/returnItem?rental_id=${rental.rental_id}&item_id=${rental.item_id}'/>"
                                               class="btn btn-success btn-sm px-3">
                                                반납하기
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${not empty rental.ret_act_date}">
                                    <span class="text-muted small">
                                        <fmt:formatDate value="${rental.ret_act_date}" pattern="MM-dd" /> 반납완료
                                    </span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty myRentals}">
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                현재 대여 중인 물품이 없습니다.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>