<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
로그인페이지입니다.
<form action="/login" id="loginForm">
	아이디 : <input type="text" id="empId" name="emp_id">
	비밀번호 : <input type="password" id="empPw" name="password">
	<button type="button" id="loginBtn">로그인</button>
</form>
<script type="text/javascript">
$(function(){
	var loginMsg = "${loginMsg}";
	if(loginMsg != null && loginMsg != ""){
		alert(loginMsg);
	}
	
	// 로그인 버튼 클릭
	$("#loginBtn").click(function(){
		// validation - 유효성체크
		var empId = $("#empId").val();
		var empPw = $("#empPw").val();
		
		if(empId == ""){
			alert("아이디를 입력해주세요");
			return false;
		}
		if(empPw == ""){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		// 유효성 검사 완료 후
		$("#loginForm").submit();
		
	})
	
});
</script>
</body>
</html>