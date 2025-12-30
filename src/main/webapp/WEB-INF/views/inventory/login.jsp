<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 | 비품 관리 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <style>
        body {
            background-color: #f0f2f5;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
    </style>
</head>
<body>

<div class="card login-card">
    <div class="login-header">
        <h3 class="fw-bold text-primary">비품 관리 시스템</h3>
        <p class="text-muted">서비스 이용을 위해 로그인해주세요.</p>
    </div>

    <form action="/login" id="loginForm">
        <div class="mb-3">
            <label for="empId" class="form-label text-secondary small fw-bold">아이디</label>
            <input type="text" class="form-control form-control-lg" id="empId" name="emp_id" placeholder="아이디를 입력하세요">
        </div>
        <div class="mb-4">
            <label for="empPw" class="form-label text-secondary small fw-bold">비밀번호</label>
            <input type="password" class="form-control form-control-lg" id="empPw" name="password" placeholder="비밀번호를 입력하세요">
        </div>
        <div class="d-grid gap-2">
            <button type="button" id="loginBtn" class="btn btn-primary btn-lg fw-bold">로그인</button>
            <a href="/" class="btn btn-link btn-sm text-decoration-none text-muted">메인으로 돌아가기</a>
        </div>
    </form>
</div>

<script type="text/javascript">
$(function(){
    var loginMsg = "${loginMsg}";
    if(loginMsg != null && loginMsg != ""){
        alert(loginMsg);
    }
    
    // 로그인 버튼 클릭
    $("#loginBtn").click(function(){
        var empId = $("#empId").val();
        var empPw = $("#empPw").val();
        
        if(empId == ""){
            alert("아이디를 입력해주세요");
            $("#empId").focus();
            return false;
        }
        if(empPw == ""){
            alert("비밀번호를 입력해주세요");
            $("#empPw").focus();
            return false;
        }
        
        $("#loginForm").submit();
    });

    // 엔터키 지원 (사용자 편의성)
    $("#empPw").keypress(function(e) {
        if(e.which == 13) {
            $("#loginBtn").click();
        }
    });
});
</script>

</body>
</html>