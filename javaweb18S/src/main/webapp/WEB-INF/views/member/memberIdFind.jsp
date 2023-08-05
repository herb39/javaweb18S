<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>9 1 3</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="${ctp}/resources/font/font.css">
	<link rel="stylesheet" href="${ctp}/resources/css/common.css">
	<link rel="stylesheet" href="${ctp}/resources/css/memberLogin.css">
	<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
	<style>
		.input100 {
		    height: 50px;
		}
		.container-login100 {
			min-height: 85vh;
		}
		#backBtn {
			font-size: 2em;
			cursor: pointer;
			position: absolute;
		    margin-top: -70px;
		    margin-left: -35px;
		}
		.subBtn {
			border: none;
		}
	</style>
	<script>
		'use strict';
		
		let str = '';
		function fCheck() {
			let name = $("#name").val();
			let email = $("#email").val();
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/member/memberIdFind",
				data	: {
					name : name,
					email : email
				},
				success	: function(res) {
	               if(res == 0) {
	                  alert("존재하지 않는 회원입니다.");
	               }
	               else {
	                  str = '<table class="table table-borderless">';
	                  str += '<tr>';
	                  str += '<td class="td" style="text-align: center;">';
	                  str += '<label for="name" class="mr-4" style="font-weight:bold">아이디 검색 결과</label>';
	                  str += '<font color="red" size="5em"><b>'+res+'</b></font>';
	                  str += '</td>';
	                  str += '</tr>';
	                  str += '</table>';
	                  $("#demo").html(str);
	               }
	            },
				error	: function() {
					alert("전송 오류");
				}
			});
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container-login100">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
			<a href="${ctp}/member/memberLogin" id="backBtn" class="backBtn" title="Back"><i class="fa-solid fa-arrow-left" style="color: #000000;"></i></a>
			<form class="login100-form validate-form" method="post">
				<span class="login100-form-title p-b-37"> 아이디 찾기 </span>
				<p>성명과 이메일 주소를 이용해 아이디를 찾을 수 있습니다.</p>
				<div class="wrap-input100 validate-input m-b-20">
					<input class="input100" type="text" name="name" id="name" placeholder="성명" required autofocus />
					<span class="focus-input100"></span>
				</div>
				<div class="wrap-input100 validate-input m-b-25">
					<input class="input100" type="text" name="email" id="email" placeholder="이메일" required />
					<span class="focus-input100"></span>
				</div>
				<div class="container-login100-form-btn p-b-30">
					<input type="button" value="아이디 찾기" onclick="fCheck()" class="login100-form-btn subBtn" />
				</div>
			</form>
			<div id="demo"></div>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>