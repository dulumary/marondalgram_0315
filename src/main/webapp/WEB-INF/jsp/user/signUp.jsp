<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	
  	<link rel="stylesheet" href="/static/css/style.css">
<title>마론달그램 - 회원가입</title>
</head>
<body>

<div id="wrap">
		
		<section class="content d-flex justify-content-center my-5">
			<div>
				<div class="login-box d-flex justify-content-center align-items-start bg-white  border rounded">
					<div class="w-100 p-5">
						<h2 class="text-center">Marondalgram</h2>
						<br>
						<div class="text-center">
							<b class="text-secondary">친구들의 사진과 동영상을 보려면<br> 가입하세요.</b>
						</div>
						
						<div class="d-flex  mt-3">
							<input type="text" id="loginIdInput" class="form-control" placeholder="아이디">
							<button type="button" class="btn btn-info btn-sm ml-2" id="isDuplicateBtn">중복확인</button>
						</div>
						<div id="duplicateText" class="d-none"><small class="text-danger">중복된 ID 입니다</small></div>
						<div id="possibleText" class="d-none"><small class="text-success">사용가능한 ID 입니다</small></div>
						<input type="password" id="passwordInput" class="form-control mt-3" placeholder="패스워드">
						<input type="password" id="passwordConfirmInput" class="form-control mt-3" placeholder="패스워드 확인">
						
						<input type="text" id="nameInput" class="form-control mt-3" placeholder="이름">
						<input type="text" id="emailInput" class="form-control mt-3" placeholder="이메일">
						
						<button type="button" id="signUpBtn" class="btn btn-info btn-block mt-3">회원가입</button>
				
					</div>
					
				</div>
				<div class="mt-4 p-3 d-flex justify-content-center align-items-start bg-white  border rounded">
					계정이 있으신가요? <a href="/user/signin_view">로그인</a>
				</div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
		<script type="text/javascript">
		$(document).ready(function() {
			// 중복체크 확인 여부
			var isChecked = false;
			// 중복여부 
			var isDuplicate = true;
			
			$("#loginIdInput").on("input", function() {
				isChecked = false;
				isDuplicate = true;
				
				$("#duplicateText").addClass("d-none");
				$("#possibleText").addClass("d-none");
			});
			
			
			$("#signUpBtn").on("click", function(e) {
				
				e.preventDefault();
				
				var loginId = $("#loginIdInput").val();
				var password = $("#passwordInput").val();
				var passwordConfirm = $("#passwordConfirmInput").val();
				var name = $("#nameInput").val().trim();
				var email = $("#emailInput").val().trim();
				
				if(loginId == "") {
					alert("아이디를 입력하세요");
					return ;
				}
				
				if(!isChecked) {
					alert("중복체크를 하지 않았습니다");
					return ;
				}
				
				if(isDuplicate) {
					alert("중복된 아이디 입니다");
					return ;
				}
				
				if(password == "") {
					alert("비밀번호를 입력하세요");
					return ;
				}
				
				if(password != passwordConfirm) {
					alert("비밀번호를 확인하세요");
					return ;
				}
				
				if(name == "") {
					alert("이름을 입력하세요");
					return ;
				}
				
				if(email == "") {
					alert("이메일을 입력하세요");
					return ;
				}
			
				
				$.ajax({
					type:"post",
					url:"/user/sign_up",
					data:{"loginId":loginId, "password":password, "name":name, "email":email},
					success:function(data) {
						if(data.result == "success") {
							location.href="/user/signin_view";
							
						} else {
							alert("회원 가입 실패");
						}
					}, 
					error:function(e) {
						alert("회원 가입 에러");
					}
				});
			});
			
			$("#isDuplicateBtn").on("click", function() {
				var loginId = $("#loginIdInput").val();
				
				if(loginId == "") {
					alert("아이디를 입력하세요");
					return ;
				}
				
				$.ajax({
					type:"get",
					url:"/user/duplicate_id",
					data:{"loginId":loginId},
					success:function(data) {
						isChecked = true;
						
						$("#duplicateText").addClass("d-none");
						$("#possibleText").addClass("d-none");
						
						if(data.is_duplicate) {
							$("#duplicateText").removeClass("d-none");
						} else {
							$("#possibleText").removeClass("d-none");
						}
						
						isDuplicate = data.is_duplicate;
						
					}, 
					error:function() {
						alert("중복확인 에러");
					}
					
				});
				
			
			});
		});
		
	</script>

</body>
</html>