<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <link rel="stylesheet" href="${ctp}/resources/font/font.css">
  <link rel="stylesheet" href="${ctp}/resources/css/common.css">
  <style>
    th {
      text-align: center;
    }
  </style>
  <script>
    'use strict';
    
    function midSearch() {
      let mid = myform.mid.value;
      if(mid.trim() == "") {
    	  alert("아이디를 입력하세요!");
    	  myform.mid.focus();
      }
      else {
    	  myform.submit();
      }
    }
    
    // 회원정보 상세보기
    function memberView(mid,nickName,name,tel,email,image,startDate) {
    	/* let startDate = startDate.substr(0, 10); */
    	
    	$("#myModal").on("show.bs.modal", function(e){
    		$(".modal-body #mid").html(mid);
    		$(".modal-body #name").html(name);
    		$(".modal-body #nickName").html(nickName);
    		$(".modal-body #tel").html(tel);
    		$(".modal-body #email").html(email);
    		$(".modal-body #startDate").html(startDate);
    	});
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <div class="text-center" style="font-size: 28px;">
    <c:if test="${empty mid}">전체 회원 리스트</c:if>
    <c:if test="${!empty mid}">아이디에 <font color='blue'><b>${mid}</b></font>가 포함된 회원 리스트</c:if>
  </div>
  <br/>
  <form name="myform">
  	<table class="table table-borderless m-0 p-0">
  	  <tr>
  	    <td style="width:60%"><button type="button" onclick="location.href='${ctp}/member/memberList';" class="btn btn-dark">전체회원</button></td>
  	    <td style="width:40%">
  	      <div class="input-group">
		  	    <input type="text" name="mid" class="form-control mr-1" />&nbsp;
		  	    <div class="input-group-append">
		  	    	<input type="button" value="아이디검색" onclick="midSearch();" class="btn btn-dark form-control" />
		  	    </div>
	  	    </div>
  	  	</td>
  	  </tr>
  	</table>
  </form>
  <table class="table table-hover text-center">
    <tr>
      <!-- <th>번호</th> -->
      <th>아이디</th>
      <th>닉네임</th>
      <th>성명</th>
      <th>가입일</th>
    </tr>
    <%-- <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/> --%>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <%-- <td>${curScrStartNo + 1}</td> --%>
        <td><a href="#" onclick="memberView('${vo.mid}','${vo.nickName}','${vo.name}','${vo.tel}','${vo.email}','${vo.startDate}')" data-toggle="modal" data-target="#myModal">${vo.mid}</a></td>
        <td>${vo.nickName}</td>
        <td>${vo.name}</td>
        <td>${fn:substring(vo.startDate, 0, 10)}</td>
      </tr>
      <%-- <c:set var="curScrStartNo" value="${curScrStartNo + 1}"/> --%>
    </c:forEach>
    <tr><td colspan="5" class="m-0 p-0"></td></tr>
  </table>
</div>
<br/>
<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=1">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVO.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${i}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${i}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVO.pag < pageVO.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${pageVO.totPage}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
<!-- 블록 페이지 끝 -->

<!-- The Modal('회원 아이디' 클릭시 회원의 상세정보를 모달창에 출력한다. -->
<div class="modal fade" id="myModal" style="width:690px;">
  <div class="modal-dialog">
    <div class="modal-content" style="width:600px;">
    
      <!-- Modal Header -->
      <div class="modal-header" style="width:600px;">
        <div class="text-center" style="font-size: 20px;">
        	회원 상세정보
        </div>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body" style="width:600px;height:400px;overflow:auto;">
        <table class="table table-bordered" style="font-size:10pt">
          <tr>
          	<th>아이디</th><td id="mid"></td>
          </tr>
          <tr>
          	<th>성명</th><td id="name"></td>
          </tr>
          <tr>
          	<th>닉네임</th><td id="nickName"></td>
          </tr>
          <tr>
          	<th>전화번호</th><td id="tel"></td>
	      </tr>
          <tr>
          	<th>이메일</th><td id="email"></td>
	      </tr>
        </table>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer" style="width:600px;">
        <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<p><br/></p>
</body>
</html>