<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
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
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <input type="button" value="돌아가기" onclick="location.href='${ctp}/song/chart';" class="btn btn-dark"/>
  <div class="text-center" style="font-size: 40px;">${songVO.title}</div><br />
  <br/>
  	<div class="text-center">
  		<img src="${songVO.image}">
  	</div><br />
  	<div class="text-right">
  		<button type="button" id="songIdx" class="btn btn-dark" onClick="openPlayer(${songVO.idx})">PLAY</button>
  	</div><br />
	  <table class="table table-bordered">
	    <tr>
	      <th>아티스트</th>
	      <td>${songVO.artist}</td>
	      <th>장르</th>
	      <td>${songVO.genre}</td>
	    </tr>
	    <tr>
	      <th>발매일</th>
	      <td colspan="3">${songVO.releaseDate}</td>
	    </tr>
	    <tr>
	      <th>가사</th>
	      <td colspan="3">${fn:replace(songVO.lyrics, newLine, "<br/>")}</td>
	    </tr>
	    <tr>
	      <%-- <td colspan="4" class="text-center">
	        <c:if test="${flag == 'searchMember'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardSearchMember?pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/></c:if>
	        <c:if test="${flag != 'search' && flag != 'searchMember'}"><input type="button" value="목록으로" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-info"/></c:if>
	      </td> --%>
	    </tr>
	  </table>
  <input type="button" value="돌아가기" onclick="location.href='${ctp}/song/chart';" class="btn btn-dark"/>
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
</script>
</body>
</html>