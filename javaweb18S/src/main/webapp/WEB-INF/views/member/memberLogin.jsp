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
	<style>
		.input100 {
		    height: 50px;
		}
		.container-login100 {
			min-height: 85vh;
		}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container-login100">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
			<form class="login100-form validate-form" method="post">
				<span class="login100-form-title p-b-37">
					로 그 인
				</span>
				<div class="wrap-input100 validate-input m-b-20">
					<input class="input100" type="text" name="mid" id="mid" value="${mid}" placeholder="아이디" required autofocus />
					<span class="focus-input100"></span>
				</div>
				<div class="wrap-input100 validate-input m-b-25">
					<input class="input100" type="password" name="pwd" id="pwd" placeholder="비밀번호" required />
					<span class="focus-input100"></span>
				</div>
				<div class="container-login100-form-btn p-b-30">
					<button class="login100-form-btn">
						로 그 인
					</button>
				</div>
				<div class="text-center" style="font-size: 12px;">
			    	<span><input type="checkbox" name="idSave" checked /> 아이디 저장</span><br /><br />
			    	<span>
			    		<a href="${ctp}/member/memberIdFind">아이디 찾기</a>&nbsp;&nbsp; / &nbsp;
			    		<a href="${ctp}/member/memberPwdFind">비밀번호 찾기</a> 		
			    	</span>
			    </div>
			    <br />
				<div class="text-center">
					<a href="${ctp}/member/memberJoin" class="txt2 hov1">
						회 원 가 입
					</a>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>