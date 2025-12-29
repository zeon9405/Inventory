<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사무실 비품 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 50px; }
        .table-container { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .btn-back { margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold text-dark m-0">📦 사무실 비품 재고 목록</h2>
        <a href="/" class="btn btn-outline-secondary">
            <i class="bi bi-house"></i> 메인페이지로 돌아가기
        </a>
    </div>

    <div class="table-container">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th scope="col" class="text-center">비품번호</th>
                    <th scope="col">품목명</th>
                    <th scope="col" class="text-center">수량</th>
                    <th scope="col" class="text-center">등록일</th>
                    <th scope="col" class="text-center">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${itemList}">
                    <tr>
                        <td class="text-center text-muted">${item.item_id}</td>
                        <td class="fw-bold">${item.item_name}</td>
                        <td class="text-center">
                            <span class="badge ${item.quantity > 0 ? 'bg-info' : 'bg-secondary'}">
                                ${item.quantity} 개
                            </span>
                        </td>
                        <td class="text-center text-muted">${item.reg_date}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${item.quantity > 0}">
                                    <button onclick="location.href='./rentItem?item_id=${item.item_id}'" 
                                            class="btn btn-primary btn-sm shadow-sm">
                                        대여하기
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger">품절(대여불가)</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>