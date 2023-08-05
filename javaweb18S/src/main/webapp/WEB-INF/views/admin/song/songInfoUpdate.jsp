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
		#topBtn {
			z-index: 99;
			font-size: 2em;
			cursor: pointer;
  			position: fixed;
		    display: none;
  			bottom: 0px;
  			right: 46.6%;
		}
		.ud {
			width: 50px;
		}
	</style>
	<script>
	    'use strict';
	    
	    // 검색
	    function songInfoSearch() {
	    	let searchString = $("#searchString").val();
	    	
	    	if(searchString.trim() == "") {
	    		alert("검색어를 입력하세요!");
	    		searchForm.searchString.focus();
	    	}
	    	else {
	    		searchForm.submit();
	    	}
	    }
	    
	    // 맨위로
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
	    
	    // 음원 정보 삭제
	    function songDelete(idx) {
	    	let ans = confirm("음원 정보를 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	$.ajax({
	            type : 'post',
	            url : '${ctp}/song/songDelete',
	            data : {
	            	idx : idx,
	            },
	            success : function(res) {
	              if(res != '0') {
	               alert('음원 정보가 삭제되었습니다.');
	               location.reload();
	              }
	              else {
	               alert('음원 정보 삭제 실패');
	              }
	            },
	            error : function() {
	              alert('전송 실패');
	              location.reload();
	            }
	          });
	    }
	</script>
</head>
<body>
	<p><br/></p>
	<div class="container">
	<button id="topBtn" class="btn topBtn" title="Go to top"><i class="fa-solid fa-arrow-up" style="color: #000;"></i></button>
		<div class="text-center" style="font-size: 28px;">음원정보수정</div><br />
		
		<!-- 검색기 처리 -->
		  <div class="container text-center">
		    <form name="searchForm" method="get" action="${ctp}/song/songInfoSearch">
		      <b>검색 </b>
		      <select name="search">
		        <option value="title" selected>곡제목</option>
		        <option value="artist">아티스트</option>
		        <option value="album">앨범</option>
		        <option value="genre">장르</option>
		        <option value="lyrics">가사</option>
		      </select>
		      <input type="text" name="searchString" id="searchString"/>
		      <input type="button" value="검색" onclick="songInfoSearch()" class="btn btn-dark btn-sm"/>
		    </form>
		  </div>
		  <br />
	  
		  	<table class="table table-hover">
		    <tr>
		      <th>번호</th>
		      <th>썸네일</th>
		      <th>곡정보</th>
		      <th>아티스트</th>
		      <th>앨범명</th>
		      <th>음원파일</th>
		      <th>발매일</th>
		      <th>장르</th>
		      <th class="ud">수정</th>
		      <th class="ud">삭제</th>
		    </tr>
		    <!-- songVOS -->
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
</body>
</html>