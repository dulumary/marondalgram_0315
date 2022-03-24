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
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
	<title>마론달그램</title>
</head>
<body>

	<div id="wrap" >
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="d-flex justify-content-center">
			<div class="col-6">
				
				<!--  입력 상자  -->
				<div class="border rounded mt-3  bg-white">
					<div>
						<textarea class="form-control w-100 border-0 non-resize" rows=3 id="contentInput"></textarea>
					</div>
					<div class="d-flex justify-content-between m-2">
						<a href="#" id="imageIcon"><i class="bi bi-image big-icon text-dark"></i> </a>
						
						<input type="file" id="fileInput" class="d-none">
						
						<button class="btn btn-sm btn-info" id="uploadBtn">업로드</button>
					</div>
				</div>
				
			
				<c:forEach var="post" items="${postList }" >
				<!--  피드  -->
				<div class="card border rounded mt-3">
					<!-- 타이틀 -->
					<div class="d-flex justify-content-between p-2 border-bottom">
						<div>
							${post.userName }
						</div>
						<div class="more-icon" >
							<a class="text-dark" href="#"> 
								<i class="bi bi-three-dots-vertical"></i> 
							</a>
						</div>
					
						
					</div>
					<!--이미지 -->
					<div>
						<img src="${post.imagePath }" class="w-100 imageClick">
					</div>
					
					<!-- 좋아요 -->
					<div class="m-2">
						
						<i class="bi bi-heart heart-icon text-dark"></i>
						
						<span class="middle-size ml-1"> 좋아요 11개 </span>
					</div>
					
					<!--  content -->
					<div class="middle-size m-2">
						<b>${post.userName }</b> ${post.content }
					</div>
					
					<!--  댓글 -->
					
					<div class="mt-2">
						<div class=" border-bottom m-2">
							<!-- 댓글 타이틀 -->
							<div  class="middle-size">
								댓글
							</div>
						</div>
						
						<!--  댓글  -->
						<div class="middle-size m-2">
							
							<div class="mt-1">
								<b>바다</b> 우왁 거기가 어딘가여?
							</div>
							<div class="mt-1">
								<b>신보람</b> 혼자 가니 좋냐?
							</div>
							<div class="mt-1">
								<b>남라</b> 냠냠
							</div>
						</div>
						<!--  댓글  -->
						
						<!-- 댓글 입력 -->
						<div class="d-flex mt-2 border-top">
							<input type="text" class="form-control border-0">
							<button class="btn btn-info ml-2 commentBtn" >게시</button>
						</div>
						<!-- 댓글 입력 -->
					</div>
					<!--  댓글 -->
				</div>
				</c:forEach>		
			</div>	
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>

	<script>
		$(document).ready(function() {
			
			
			
			$("#uploadBtn").on("click", function() {
				
				let content = $("#contentInput").val().trim();
				
				if(content == "") {
					alert("내용을 입력하세요");
					return ;
				}
				
				// 파일 유효성 검사
				// $("#fileInput")[0].files[0]
				if($("#fileInput")[0].files.length == 0) {
					alert("파일을 선택해주세요");
					return;
				}
				
				let formData = new FormData();
				formData.append("content", content);
				formData.append("file", $("#fileInput")[0].files[0] );
				
				$.ajax({
					type:"post",
					url:"/post/create",
					data:formData,
					enctype:"multipart/form-data",
					processData:false,
					contentType:false,
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("글쓰기 실패");
						}
					}, 
					error:function() {
						alert("글쓰기 에러");
					}
				});
			});
			
			$("#imageIcon").on("click", function() {
				// fileInput 클릭된 효과
				$("#fileInput").click();
			});
			
			$(".commentBtn").on("click", function() {
				alert("댓글 입력 버튼");
				
				// input 값 가져오기 
				
			});
				
		});
	
	</script>

</body>
</html>