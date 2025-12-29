<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비품 관리 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .hero-section { padding: 60px 0; background: #ffffff; border-bottom: 1px solid #dee2e6; margin-bottom: 30px; }
        .menu-card { transition: transform 0.2s; cursor: pointer; height: 100%; }
        .menu-card:hover { transform: translateY(-5px); box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/">비품 관리 시스템</a>
        <div class="ms-auto">
            <c:if test="${sessionScope.user eq null}">
                <a href="/loginPage" class="btn btn-outline-light btn-sm">로그인</a>
            </c:if>
            <c:if test="${sessionScope.user ne null}">
                <span class="text-light me-3">환영합니다, <strong>${sessionScope.user}</strong>님!</span>
                <a href="/logoutPage" class="btn btn-danger btn-sm">로그아웃</a>
            </c:if>
        </div>
    </div>
</nav>

<div class="hero-section text-center">
    <div class="container">
        <h1 class="display-4 fw-bold">사내 비품 관리 시스템</h1>
        <p class="lead text-muted">필요한 물품을 조회하고 간편하게 대여하세요.</p>
        <c:if test="${sessionScope.user == 'admin'}">
            <a href="${pageContext.request.contextPath}/admin/adminPage" class="btn btn-warning mt-2">관리자 모드 접속</a>
        </c:if>
    </div>
</div>

<div class="container">
    <div class="row g-4 justify-content-center">
        <div class="col-md-5">
            <div class="card menu-card text-center p-4" onclick="location.href='/itemList'">
                <div class="card-body">
                    <h3 class="card-title mb-3">📦 물품 대여 리스트</h3>
                    <p class="card-text text-muted">현재 대여 가능한 비품 목록을 확인하고 신청합니다.</p>
                    <span class="btn btn-primary">이동하기</span>
                </div>
            </div>
        </div>

        <div class="col-md-5">
            <div class="card menu-card text-center p-4" onclick="location.href='/myRental'">
                <div class="card-body">
                    <h3 class="card-title mb-3">📝 내 대여 목록</h3>
                    <p class="card-text text-muted">내가 현재 대여 중인 물품과 반납 예정일을 확인합니다.</p>
                    <span class="btn btn-success">이동하기</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>