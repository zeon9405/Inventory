<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비품 관리 | 관리자 모드</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 40px; }
        .table-card { background: white; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); padding: 20px; }
        .deleted-row { background-color: #f1f3f5 !important; color: #adb5bd; }
        .status-badge { font-size: 0.8rem; }
    </style>
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark m-0">🛠️ 비품 재고 관리</h2>
            <p class="text-muted small mb-0">전체 비품의 등록, 수정 및 삭제 현황을 관리합니다.</p>
        </div>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/admin/adminPage" class="btn btn-outline-secondary">관리자 홈으로</a>
            <a href="${pageContext.request.contextPath}/admin/itemRegForm" class="btn btn-primary">
                + 새 물품 등록
            </a>
        </div>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th class="text-center">번호</th>
                        <th>품목명</th>
                        <th class="text-center">수량</th>
                        <th class="text-center">상태</th>
                        <th class="text-center">등록일</th>
                        <th class="text-center">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${itemList}">
                        <tr class="${item.status == 'deleted' ? 'deleted-row' : ''}">
                            <td class="text-center small">${item.item_id}</td>
                            <td class="fw-bold">${item.item_name}</td>
                            <td class="text-center">${item.quantity}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${item.status == 'deleted'}">
                                        <span class="badge bg-danger status-badge">DELETED</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success status-badge">${item.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center text-muted small">${item.reg_date}</td>
                            <td class="text-center">
                                <c:if test="${item.status != 'deleted'}">
                                    <div class="btn-group btn-group-sm">
                                        <a href="${pageContext.request.contextPath}/admin/editForm?item_id=${item.item_id}" 
                                           class="btn btn-outline-primary">수정</a>
                                        <a href="${pageContext.request.contextPath}/admin/deleteItem?item_id=${item.item_id}" 
                                           class="btn btn-outline-danger"
                                           onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                                    </div>
                                </c:if>
                                <c:if test="${item.status == 'deleted'}">
                                    <span class="text-muted">-</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>