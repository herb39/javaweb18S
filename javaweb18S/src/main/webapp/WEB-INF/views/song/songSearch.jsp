<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>913 admin</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/resources/font/font.css">
  <link rel="stylesheet" href="${ctp}/resources/css/common.css">
  <script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
  <style>
  	/* * {
		font-family: 'IBMPlexSansKR-Regular';
	} */
	html {
		scroll-behavior: smooth;
	}
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
	.ud {
		width: 50px;
	}
	#topBtn {
		z-index: 99;
		font-size: 2em;
		cursor: pointer;
		position: fixed;
	    display: none;
		bottom: 50px;
		right: 50px;
	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<button id="topBtn" class="topBtn btn" title="Go to top"><i class="fa-solid fa-arrow-up" style="color: #000;"></i></button>
<p><br/></p>
<div class="container">
  <div class="text-center" style="font-size: 28px;">음원 정보 검색결과</div>
  <div class="text-center">
  	<font color="blue">${searchTitle}</font>(으)로 <font color="red">${pageVO.searchString}</font>(을)를 검색한 결과입니다.
  </div>
  <br/>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td><a href="${ctp}/song/chart" class="btn btn-dark btn-sm">돌아가기</a></td>
    </tr>
  </table>
  <table class="table table-hover text-center">
    <tr>
      <th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
      <th>썸네일</th>
      <th>곡정보</th>
      <th>아티스트</th>
      <th>앨범</th>
      <th>듣기</th>
    </tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td><input type="checkbox" name="idxChecked" id="idx${vo.idx}" value="${vo.idx}" onClick="onCheck()" /></td>
        <td><a href="${ctp}/song/songInfo?songIdx=${vo.idx}"><img src="${vo.image}" style="width: 60px;"></a></td>
        <td class="title1 left"><a href="${ctp}/song/songInfo?songIdx=${vo.idx}">${vo.title}</a></td>
        <td class="artist left"><a href="${ctp}/song/songInfo?songIdx=${vo.idx}">${vo.artist}</a></td>
        <td class="album left"><a href="${ctp}/song/songInfo?songIdx=${vo.idx}">${vo.album}</a></td>
        <td><button type="button" id="songIdx" class="btn" onClick="openPlayer(${vo.idx})"><i class="fa-solid fa-play" style="color: #000000;"></i></button></td>
      </tr>
    </c:forEach>
    <tr><td colspan="8" class="m-0 p-0"></td></tr>
  </table>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	'use strict';
	
	function openPlayer(songIdx) {
		let popupPlayer;
		
		let url = "${ctp}/song/player?songIdx="+songIdx;
		let popupWidth = 800;
		let popupHeight = 700;
		
		let popupX = (window.screen.width / 2) - (popupWidth / 2);
		let popupY= (window.screen.height / 2) - (popupHeight / 2);
		
		popupPlayer = window.open(url, 'player', 'status=no, scrollbars=no, resizable, toolbars=no, menubar=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		popupPlayer.resizeTo(popupWidth, popupHeight);
		popupPlayer.onresize = (_=>{
			popupPlayer.resizeTo(popupWidth, popupHeight);
		})
	}
	
	//맨위로
	document.addEventListener("DOMContentLoaded", function() {
	    let topBtn = document.getElementById("topBtn");
	
	    function scrollFunction() {
	      if (window.pageYOffset > 500) {
	    	  topBtn.style.display = "block";
	      } else {
	    	  topBtn.style.display = "none";
	      }
	
	    }
	
	    function topFunction() {
	      document.body.scrollTop = 0;
	      document.documentElement.scrollTop = 0;
	    }
	
	    topBtn.addEventListener("click", topFunction);
	    window.addEventListener("scroll", scrollFunction);
	});
</script>
</body>
</html>