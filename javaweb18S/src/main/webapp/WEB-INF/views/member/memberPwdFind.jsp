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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container-login100">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
			<a href="${ctp}/member/memberLogin" id="backBtn" class="backBtn" title="Back"><i class="fa-solid fa-arrow-left" style="color: #000000;"></i></a>
			<form class="login100-form validate-form" method="post">
				<span class="login100-form-title p-b-37"> 비밀번호 찾기 </span>
				<p>아이디와 이메일 주소를 입력한 후,<br />메일로 임시 비밀번호를 발급 받으세요.</p>
				<div class="wrap-input100 validate-input m-b-20">
					<input class="input100" type="text" name="mid" id="mid" placeholder="아이디" required autofocus />
					<span class="focus-input100"></span>
				</div>
				<div class="wrap-input100 validate-input m-b-25">
					<input class="input100" type="text" name="email" id="email" placeholder="이메일" required />
					<span class="focus-input100"></span>
				</div>
				<div class="container-login100-form-btn p-b-30">
					<input type="submit" value="임시 비밀번호 발급" class="login100-form-btn subBtn" />
				</div>
			</form>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>