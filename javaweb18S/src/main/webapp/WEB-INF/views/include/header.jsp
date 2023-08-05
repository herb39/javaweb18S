<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	@font-face {
	    font-family: 'FOUREYES';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/FOUREYES.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	a:hover {
		text-decoration: none;
		color: inherit;
	}
	.title913 {
		width: 100%;
		height: 80px;
		font-size: 50px;
		text-align: center;
		line-height: 40px;
	}
	#title913 {
		font-family: 'FOUREYES';
	}
	.ljtr {
		margin-right: 10px;
		padding-right: 5px;
	}
</style>
<!-- Automatic Slideshow Images -->
<div class="container" style="text-align: end; margin-top: 10px;">
	<c:if test="${empty sLevel}">
			<a href="${ctp}/member/memberLogin" class="ljtr">로그인</a>
			<a href="${ctp}/member/memberJoin" class="ljtr">회원가입</a>
	</c:if>
	<c:if test="${!empty sLevel}">
			<a href="${ctp}/member/memberLogout" class="ljtr">로그아웃</a>
	</c:if>
</div>
<div class="title913"><a href="${ctp}/"><b id="title913">9 1 3</b></a></div>
