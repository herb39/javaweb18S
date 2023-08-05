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
	<%-- <link rel="stylesheet" href="${ctp}/resources/css/memberLogin.css"> --%>
	<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
	<style>
		html {
			scroll-behavior: smooth;
		}
		td {
			vertical-align: middle!important;
			white-space: nowrap;
	        overflow: hidden;
	        text-overflow: ellipsis;
		}
		.left {
			text-align: left;
		}
		.title1 {
			max-width: 280px;
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
  			bottom: 50px;
  			right: 50px;
		}
		.modal {
		  display: none;
		  position: fixed;
		  z-index: 1;
		  left: 0;
		  top: 0;
		  width: 100%;
		  height: 100%;
		  background-color: rgba(0, 0, 0, 0.4);
		}
		.modal-content {
		  background-color: #fff;
		  margin: 15% auto;
		  padding: 20px;
		  border: 1px solid #888;
		  width: 80%;
		  max-width: 600px;
		}
		.close {
		  float: right;
		  font-size: 28px;
		  font-weight: bold;
		  cursor: pointer;
		}
		.close:hover,
		.close:focus {
		  color: #000;
		  text-decoration: none;
		  cursor: pointer;
		}
	</style>
	<script>
	    'use strict';
	    
	 	// 검색
	    function songSearch() {
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
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<p><br/></p>
	<button id="topBtn" class="topBtn btn" title="Go to top"><i class="fa-solid fa-arrow-up" style="color: #000;"></i></button>
	<div class="container">
		<div class="text-center" style="font-size: 28px;">실시간 순위</div><br />
		
		<!-- 검색기 처리 -->
		  <div class="container text-center">
		    <form name="searchForm" method="get" action="${ctp}/song/songSearch">
		      <b>검색 </b>
		      <select name="search">
		        <option value="title" selected>곡제목</option>
		        <option value="artist">아티스트</option>
		        <option value="album">앨범</option>
		        <option value="genre">장르</option>
		        <option value="lyrics">가사</option>
		      </select>
		      <input type="text" name="searchString" id="searchString"/>
		      <input type="button" value="검색" onclick="songSearch()" class="btn btn-dark btn-sm"/>
		    </form>
		  </div>
		  <br />
	  
	<form name="myform" method="post" action="${ctp}/member/playList">
		<button type="button" class="btn" onclick="openModal()">플리에 추가</button>
		<br />
	  	<table class="table table-hover text-center">
	    <tr>
	      <th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
	      <th>순위</th>
	      <th></th>
	      <th>곡정보</th>
	      <th>아티스트</th>
	      <th>앨범</th>
	      <th>듣기</th>
	      <th>담기</th>
	    </tr>
	    <!-- ChartVOS -->
	    <c:forEach var="vo" items="${vos}" varStatus="st">
		<input type="hidden" name="checkSong" value="0" id="checkSong${vo.idx}"/>
		<%-- <input type="hidden" name="${vo.songIdx}" value="${vo.songIdx}" id="songIdx"/> --%>
	      <tr>
			<td><input type="checkbox" name="idxChecked" id="idx${vo.idx}" value="${vo.idx}" onClick="onCheck()" /></td>
	        <td>${vo.ranking}</td>
	        <td><a href="${ctp}/song/songInfo?songIdx=${vo.songIdx}"><img src="${vo.image}" style="width: 60px;"></a></td>
	        <td class="title1 left"><a href="${ctp}/song/songInfo?songIdx=${vo.songIdx}">${vo.title}</a></td>
	        <td class="artist left"><a href="${ctp}/song/songInfo?songIdx=${vo.songIdx}">${vo.artist}</a></td>
	        <td class="album left"><a href="${ctp}/song/songInfo?songIdx=${vo.songIdx}">${vo.album}</a></td>
	        <td><button type="button" id="songIdx" class="btn" onClick="openPlayer(${vo.songIdx})"><i class="fa-solid fa-play" style="color: #000000;"></i></button></td>
	        <td><a href="${ctp}/song/songInfo?songIdx=${vo.songIdx}"><i class="fa-solid fa-plus" style="color: #000000;"></i></a></td>
	      </tr>
	    </c:forEach>
	    <tr><td colspan="6" class="m-0 p-0"></td></tr>
	  </table>
	  	<c:set var="minIdx" value="${vos[0].idx}"/>
	    <c:set var="maxIdx" value="${vos[maxSize].idx}"/>
	  </form>
	</div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

		<div id="selectPlayListModal" class="modal">
			<div class="modal-content">
				<h2 class="text-center">플레이리스트에 추가</h2>
				<br />
				<div class="mb-2">곡을 추가할 플레이리스트를 선택하세요.</div>
				<form name="myform" method="post">
					<select size="1" class="form-control" id="selectOption">
						<option value="" disabled selected>플레이리스트 선택</option>
						<c:forEach var="playListVO" items="${playListVOS}">
							<option value="${playListVO.name}">${playListVO.name}</option>
						</c:forEach>
					</select>
				</form>
				<br />
				<span>
					<button class="close btn text-right mr-3" style="font-size: 20px;" onclick="closeModal()">닫기</button>
					<button class="close btn text-right mr-3" style="font-size: 20px;" onclick="playListSongAdd()">저장</button>
				</span>
			</div>
		</div>

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
		
		function allCheck() {
	        const checkboxes = document.querySelectorAll('input[name="idxChecked"]');
	        const allCheckBtn = document.getElementById('allcheck');
	
	        if (allCheckBtn.checked) {
	            checkboxes.forEach(checkbox => checkbox.checked = true);
	        } else {
	            checkboxes.forEach(checkbox => checkbox.checked = false);
	        }
	    }
		
		function onCheck(){
	      let minIdx = 1;
	      let maxIdx = 100;
	      
	      let emptyCnt=0;
	      for(let i=minIdx;i<=maxIdx;i++){
	        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
	          emptyCnt++;
	          break;
	        }
	      }
	      if(emptyCnt!=0){
	        document.getElementById("allcheck").checked=false;
	      } 
	      else {
	        document.getElementById("allcheck").checked=true;
	      }
	    }
		
		// 모달 열기
		function openModal() {
		  var modal = document.getElementById("selectPlayListModal");
		  modal.style.display = "block";
		}

		// 모달 닫기
		function closeModal() {
		  var modal = document.getElementById("selectPlayListModal");
		  modal.style.display = "none";
		}

	</script>

</body>
</html>