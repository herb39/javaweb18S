<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	.w3-top {
		position: sticky;
	}
</style>
<script>
	'use strict';
	function memberDelete() {
		  let ans = confirm("탈퇴하시겠습니까?");
		  if(ans) {
			  ans = confirm("탈퇴하시면 1개월간 같은 아이디로 재가입하실수 없습니다.\n그래도 탈퇴하시겠습니까?");
			  if(ans) location.href = "${ctp}/member/memberDelete";
		  }
	}
</script>
<!-- Navbar -->
<div class="w3-top" style="background-color: #000; text-align: center;">
  <div class="w3-bar w3-card">
    <!-- <a href="http://localhost:9090/javaweb18S" class="w3-bar-item w3-button w3-padding-large w3-black col">홈으로</a> -->
    <a href="http://49.142.157.251:9090/javaweb18S" class="w3-bar-item w3-button w3-padding-large w3-black col">홈으로</a>
    <a href="${ctp}/song/chart" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-black col">인기차트</a>
    <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-black col">자유게시판</a>
    <c:if test="${sLevel <= 1}">
	  	<a href="${ctp}/member/playList" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-black col">플레이리스트</a>
	    <a href="${ctp}/shop/productList" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-black col">굿즈</a>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button w3-black col" title="More">마이페이지<i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4 w3-black">
	        <a href="${ctp}/shop/cartList" class="w3-bar-item w3-button">장바구니</a>
	        <a href="${ctp}/shop/myOrder" class="w3-bar-item w3-button">배송정보</a>
	        <a href="${ctp}/member/memberPwdUpdate?pwdFlag=member" class="w3-bar-item w3-button">비밀번호 변경</a>
	        <a href="${ctp}/member/memberPwdCheck" class="w3-bar-item w3-button">정보수정</a>
	        <a href="javascript:memberDelete()" class="w3-bar-item w3-button">회원탈퇴</a>
	      </div>
	    </div>
        <c:if test="${sLevel == 0}">
        	<a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-black col">관리자 메뉴</a>
        </c:if>
   </c:if>
  </div>
</div>

<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Guest</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Board</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Pds</a>
  <hr />
  <a href="${ctp}/study/password/sha256" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">SHA256</a>
  <a href="${ctp}/study/password/aria" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">ARIA</a>
  <a href="${ctp}/study/password/bCryptPassword" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">암호화(Security)</a>
</div>
