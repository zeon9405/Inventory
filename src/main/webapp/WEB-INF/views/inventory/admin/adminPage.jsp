<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 대시보드 | 비품 관리 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .admin-header { background: #343a40; color: white; padding: 40px 0; margin-bottom: 40px; }
        .admin-card { 
            transition: all 0.3s; 
            border: none; 
            border-radius: 15px; 
            cursor: pointer;
            height: 100%;
        }
        .admin-card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 10px 20px rgba(0,0,0,0.1); 
        }
        .icon-circle {
            width: 60px;
            height: 60px;
            background-color: #e9ecef;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>

<header class="admin-header shadow-sm">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="fw-bold mb-1">Admin Dashboard</h1>
                <p class="text-light-50 mb-0">시스템 자산 및 대여 현황을 관리합니다.</p>
            </div>
            <a href="/" class="btn btn-outline-light btn-sm">사용자 메인으로</a>
        </div>
    </div>
</header>

<div class="container">
    <div class="row g-4">
        <div class="col-md-6">
            <div class="card admin-card text-center p-4" onclick="location.href='${pageContext.request.contextPath}/admin/list'">
                <div class="card-body">
                    <div class="icon-circle">📦</div>
                    <h3 class="card-title fw-bold">물품 현황 관리</h3>
                    <p class="card-text text-muted">비품의 등록, 수정, 삭제 및<br>현재 재고 상태를 관리합니다.</p>
                    <span class="btn btn-dark mt-3">자세히 보기</span>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card admin-card text-center p-4" onclick="location.href='${pageContext.request.contextPath}/admin/allRentalList'">
                <div class="card-body">
                    <div class="icon-circle">📜</div>
                    <h3 class="card-title fw-bold">전체 대여 목록 확인</h3>
                    <p class="card-text text-muted">모든 사원의 대여 이력과<br>반납 여부 정보를 통합 조회합니다.</p>
                    <span class="btn btn-dark mt-3">자세히 보기</span>
                </div>
            </div>
        </div>
    </div>

    <div class="mt-5 text-center text-muted">
        <small>© 2025 Office Asset Management System - Admin Mode</small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>