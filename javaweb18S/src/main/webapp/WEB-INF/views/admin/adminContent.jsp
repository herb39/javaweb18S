<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
  <script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
  <style>
  	td {
		vertical-align: middle!important;
        overflow: hidden;
        text-overflow: ellipsis;
	}
	.left {
		text-align: left;
	}
	.title1 {
		max-width: 230px;
			
	}
	.artist {
		max-width: 150px;
	}
	.album {
		max-width: 170px;
	}
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
	<div class="text-center" style="font-size: 28px;">관리자 메뉴</div><br />
	<div class="row">
		<div style="font-size: 20px;" class="col-11">최근 가입한 회원</div>
		<button type="button" onclick="location.href='${ctp}/member/memberList';" class="btn col-1 btn-dark">전체회원</button>
	</div>
	<br />
	  <table class="table table-hover text-center">
	    <tr class="m-1 p-1">
	      <th class="m-1 p-1">아이디</th>
	      <th class="m-1 p-1">닉네임</th>
	      <th class="m-1 p-1">성명</th>
	      <th class="m-1 p-1">가입일</th>
	    </tr>
		<c:forEach var="vo" items="${memberVOS}" varStatus="st">
	      <tr class="m-1 p-1">
	        <td class="m-1 p-1"><a href="#" onclick="memberView('${vo.mid}','${vo.nickName}','${vo.name}','${vo.tel}','${vo.email}','${vo.startDate}')" data-toggle="modal" data-target="#myModal">${vo.mid}</a></td>
	        <td class="m-1 p-1">${vo.nickName}</td>
	        <td class="m-1 p-1">${vo.name}</td>
	        <td class="m-1 p-1">${fn:substring(vo.startDate, 0, 10)}</td>
	      </tr>
	    </c:forEach>
	    <tr><td colspan="5" class="m-0 p-0"></td></tr>
	  </table>
	  <br />
	
	
	<div class="row">
		<div style="font-size: 20px;" class="col-11">최근 추가한 곡</div>
		<button type="button" onclick="location.href='${ctp}/song/songInfoUpdate';" class="btn col-1 btn-dark">전체음원</button>
	</div>
	<br />
	  <table class="table table-hover text-center">
	    <tr class="m-1 p-1">
	      <th></th>
	      <th>썸네일</th>
	      <th>곡정보</th>
	      <th>아티스트</th>
	      <th>앨범명</th>
	      <th>음원파일</th>
	      <th>발매일</th>
	      <th>장르</th>
	      <th></th>
	      <th></th>
	    </tr>
		<c:forEach var="vo" items="${songVOS}" varStatus="st">
	      <tr>
	        <td>${vo.idx}</td>
	        <td><img src="${vo.image}" style="width: 60px;"></td>
	        <td class="title1 left"><a href="${ctp}/song/songInfoUpdateForm?idx=${vo.idx}" class="btn">${vo.title}</a></td>
	        <td class="artist left">${vo.artist}</td>
	        <td class="album left">${vo.album}</td>
	        <c:if test="${!empty vo.music}">
	        	<td style="max-width: 180px;">
					${vo.music}
        		</td>
	        </c:if>
	        <c:if test="${empty vo.music}">
	        	<td>
	        		<font color="#777777">(음원 파일 정보 없음)</font>
	        	</td>
	        </c:if>
	        <td style="width: 130px; white-space: nowrap;">${vo.releaseDate}</td>
	        <td style="max-width: 130px;">${vo.genre}</td>
	        <td><a href="${ctp}/song/songInfoUpdateForm?idx=${vo.idx}" class="btn"><i class="fa-solid fa-pencil" style="color: #000000;"></i></a></td>
	        <td><a href="javascript:songDelete(${vo.idx})"><i class="fa-solid fa-trash-can" style="color: #000000;"></i></a></td>
	      </tr>
	    </c:forEach>
	    <tr><td colspan="10" class="m-0 p-0"></td></tr>
	  </table>
	
	
	
	
	
	
	
	
</div>
<p><br/></p>
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
<script>
	'use strict';
	
	//회원정보 상세보기
	function memberView(mid,nickName,name,tel,email,image,startDate) {
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
</body>
</html>