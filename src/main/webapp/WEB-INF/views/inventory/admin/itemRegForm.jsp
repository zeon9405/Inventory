<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신규 비품 등록 | 관리자</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .form-container { max-width: 600px; margin-top: 50px; }
        .card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); }
        .card-header { background-color: #0d6efd; color: white; border-radius: 15px 15px 0 0 !important; padding: 20px; }
    </style>
</head>
<body>

<div class="container form-container">
    <div class="card">
        <div class="card-header text-center">
            <h4 class="mb-0 fw-bold">📦 신규 비품 등록</h4>
        </div>
        <div class="card-body p-4">
            <form action="/admin/insertNewItem" method="post">
                <div class="mb-3">
                    <label for="item_name" class="form-label fw-bold text-secondary">물품명</label>
                    <input type="text" class="form-control" id="item_name" name="item_name" placeholder="예: 맥북 프로 16인치" required>
                </div>

                <div class="mb-3">
                    <label for="cat_id" class="form-label fw-bold text-secondary">카테고리</label>
                    <select class="form-select" id="cat_id" name="cat_id" required>
                        <option value="" selected disabled>-- 카테고리를 선택하세요 --</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat.cat_id}">${cat.cat_name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="item_price" class="form-label fw-bold text-secondary">가격</label>
                        <div class="input-group">
                            <span class="input-group-text">₩</span>
                            <input type="number" class="form-control" id="item_price" name="item_price" placeholder="0">
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="quantity" class="form-label fw-bold text-secondary">수량</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="quantity" name="quantity" placeholder="0" required>
                            <span class="input-group-text">개</span>
                        </div>
                    </div>
                </div>

                <hr class="my-4">

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg fw-bold">등록하기</button>
                    <a href="${pageContext.request.contextPath}/admin/list" class="btn btn-outline-secondary">취소 및 돌아가기</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>