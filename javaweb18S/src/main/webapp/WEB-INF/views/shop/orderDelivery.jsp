<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>9 1 3</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  	@font-face {
	    font-family: 'IBMPlexSansKR-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	* {
		font-family: 'IBMPlexSansKR-Regular';
	}
	body::before {
		content: "";
	    display: block;
	    position: fixed;
	    z-index: -1;
	    width: 100%;
	    height: 100%;
	    top: 0;
	    left: 0;
		background: -webkit-linear-gradient(left,rgba(0,168,255,0.2),rgba(185,0,255,0.15));
	}
  </style>
</head>
<body>
<div class="container">
  <h2 class="text-center">배송조회</h2>
  <hr/>
  <p>구매물품 : ${vo.name}</p>
  <p>연락처 : ${vo.tel}</p>
  <p>주소 : ${vo.address}</p>
  <p>배송메세지 : ${vo.message}</p>
  <p>결재수단 : ${payMethod} / ${fn:substring(vo.payment,1,fn:length(vo.payment))}</p>
  <p>주문번호 : ${vo.orderIdx}</p>
  <hr/>
  <p class="text-center"><input type="button" value="닫기" onclick="window.close()" class="btn btn-light btn-sm"/></p>
</div>
</body>
</html>