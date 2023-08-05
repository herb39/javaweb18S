<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/resources/font/font.css">
	<link rel="stylesheet" href="${ctp}/resources/css/common.css">
	<link rel="stylesheet" href="${ctp}/resources/css/memberLogin.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="container-login100">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
			<form class="login100-form validate-form" name="joinForm" id="joinForm" method="post" enctype="multipart/form-data">
				<span class="login100-form-title p-b-37">
					회 원 정 보 수 정
				</span>
				<div class="form-group">
					<label for="mid">아이디<font color="red">*</font> &nbsp; &nbsp;</label>
					<div class="wrap-input100 validate-input m-b-20">
						<input class="input100" type="text" name="mid" id="mid" value="${sMid}" placeholder="아이디" required readonly />
						<span class="focus-input100"></span>
					</div>
				</div>
				<label for="pwd">비밀번호<font color="red">*</font></label>
				<div class="wrap-input100 validate-input m-b-25">
					<input class="input100" type="password" name="pwd" id="pwd" placeholder="비밀번호" required />
					<span class="focus-input100"></span>
				</div>
				<label for="name">성명<font color="red">*</font></label>
				<div class="wrap-input100 validate-input m-b-25">
					<input class="input100" type="text" name="name" id="name" value="${vo.name}" placeholder="성명" required />
					<span class="focus-input100"></span>
				</div>
				<label for="nickName">닉네임<font color="red">*</font> &nbsp; &nbsp;</label>
				<div class="wrap-input100 validate-input m-b-25">
					<input class="input100" type="text" name="nickName" id="nickName" value="${sNickName}" placeholder="닉네임" readonly required />
					<span class="focus-input100"></span>
				</div>
				<label for="tel">전화번호<font color="red">*</font></label>
				<div class="wrap-input100 validate-input m-b-25">
					<input class="input100" type="text" name="tel" id="tel" value="${vo.tel}" placeholder="전화번호 (숫자만 입력)" required />
					<span class="focus-input100"></span>
				</div>
				<label for="email">이메일<font color="red">*</font></label>
				<div class="wrap-input100 validate-input m-b-25">
					<input class="input100" type="text" name="email" id="email" value="${vo.email}" placeholder="이메일" required />
					<span class="focus-input100"></span>
				</div>
				<div class="container-login100-form-btn p-b-30">
					<button class="login100-form-btn" onclick="fCheck()">
						저 장
					</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
		'use strict';
			
		// 아이디 / 닉네임 중복 확인 버튼 눌렀는지 확인 변수
		let idCheckSw = 0;
		let nickNameCheckSw = 0;
		
		function fCheck() {
			// 유효성 검사
			// 아이디 비밀번호 닉네임 성명 이메일 전화번호
			
			let regMid = /^[a-zA-Z0-9_]{4,20}$/;
			let regPwd = /(?=.*[0-9a-zA-Z]).{4,20}$/;
			let regNickName = /^[a-zA-Z가-힣]{2,20}$/;
			let regName = /^[가-힣]{2,}$/;
			let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/
			let regTel = /^010\d{8}$/;

	
			let mid = joinForm.mid.value.trim();
			let pwd = joinForm.pwd.value;
			let nickName = joinForm.nickName.value;
			let name = joinForm.name.value;
			let email = joinForm.email.value.trim();
			let tel = joinForm.tel.value.trim();
			
			let submitFlag = 0; // 모든 체크 정상 종료 -> submitFlag : 1로 변경 
			
			// 앞의 정규식으로 정의된 부분에 대한 유효성 체크
			if (!regMid.test(mid)) {
				alert("아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_)만 사용 가능합니다.");
				joinForm.mid.focus();
				event.preventDefault(); // 기본 동작 중지
				return false;
			} else if (!regPwd.test(pwd)) {
				alert("비밀번호는 1개 이상의 문자와 특수문자 조합의 4~20자리로 작성해주세요.");	
				joinForm.pwd.focus();
				event.preventDefault();
				return false;
			} else if (!regName.test(name)) {
				alert("성명은 한글만 사용 가능합니다.");
				joinForm.name.focus();
				event.preventDefault();
				return false;
			} else if (!regNickName.test(nickName)) {
				alert("닉네임은 한글과 영어 대/소문자만 사용 가능합니다.");
				joinForm.nickName.focus();
				event.preventDefault();
				return false;
			} else if (!regTel.test(tel)) {
				alert("전화번호 형식을 확인하세요.(01000000000)");
				joinForm.tel.focus();
				event.preventDefault();
				return false;
			} else if (!regEmail.test(email)) {
				alert("이메일 형식에 맞게 작성해주세요.");
				joinForm.email.focus();
				event.preventDefault();
				return false;
			} else {
				submitFlag = 1;
			}
			
			// 전송 전 모든체크 끝나면 submitFlag : 1 -> 서버 전송
			if (submitFlag == 1) {
				joinForm.submit();
				
			} else {
				alert("정보 수정에 실패했습니다. 형식을 다시 확인하세요.");
			}
		}
		
		// 아이디 중복 체크
		function idCheck() {
			let mid = joinForm.mid.value;
	
			if (mid.trim() == "" || mid.length < 4 || mid.length > 20) {
				alert("아이디는 4~20자만 가능합니다.");
				joinForm.mid.focus();
				return false;
			}
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/member/memberIdCheck",
				data	: {mid : mid},
				success	: function (res) {
					if (res == "1") {
						alert("이미 사용중인 아이디입니다. 다시 입력해주세요.");
						$("#mid").focus();
					} else {
						alert("사용 가능한 아이디입니다.");
						idCheckSw = 1;
						$("#pwd").focus();
					}
				}
			});
		}
		
		// 닉네임 중복 체크
		function nickNameCheck() {
			let nickName = joinForm.nickName.value;
			
			if (nickName.trim() == "" || nickName.length < 2 || nickName.length > 20) {
				alert("닉네임은 2~20자만 가능합니다.");
				joinForm.nickName.focus();
				return false;
			}
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/member/memberNickNameCheck",
				data	: {nickName : nickName},
				success	: function (res) {
					if (res == "1") {
						alert("이미 사용중인 닉네임입니다. 다시 입력해주세요.");
						$("#nickName").focus();
					} else {
						alert("사용 가능한 닉네임입니다.");
						nickNameCheckSw = 1;
						$("#tel").focus();
					}
				}
			});
		}
	</script>
</body>
</html>