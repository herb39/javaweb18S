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
  <style>
  	* {
		font-family: 'IBMPlexSansKR-Regular';
	}
  </style>
</head>
<body style="background-color:#222222; font-size: 1em;">
<p><br/></p>
<div class="text-center card-hover" id="accordion">
  <h5><a href="${ctp}/admin/adminContent" target="adminContent"><font color="#dddddd">관리자메뉴</font></a></h5>
  <hr/>
  <p><a href="${ctp}/board/boardList" target="adminContent"><font color="#dddddd">게시판리스트</font></a></p>
  <hr/>
  <p><a href="${ctp}/member/memberList" target="adminContent"><font color="#dddddd">회원리스트</font></a></p>
  <hr/>
  <div class="card">
    <div class="card-header bg-dark m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapseOne">
        <font color="#dddddd">음원정보관리</font>
      </a>
    </div>
    <div id="collapseOne" class="collapse" data-parent="#accordion">
      <div class="card-body m-2 p-1">
        <a href="${ctp}/song/songInfoInsert" target="adminContent">음원정보등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/song/songInfoUpdate" target="adminContent">음원정보수정</a>
      </div>
    </div>
  </div>
  <hr/>
  <div class="card">
    <div class="card-header bg-dark m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapseTwo">
        <font color="#dddddd">상품관리</font>
      </a>
    </div>
    <div id="collapseTwo" class="collapse" data-parent="#accordion">
      <div class="card-body m-2 p-1">
        <a href="${ctp}/shop/category" target="adminContent">상품분류등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/shop/product" target="adminContent">상품등록관리</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/shop/shopList" target="adminContent">상품등록조회</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/shop/option" target="adminContent">옵션등록관리</a>
      </div>
    </div>
  </div>
  <hr/>
  <p><a href="${ctp}/" target="_top"><font color="#dddddd">나가기</font></a></p>
  <hr/>
</div>
<p><br/></p>
</body>
</html>