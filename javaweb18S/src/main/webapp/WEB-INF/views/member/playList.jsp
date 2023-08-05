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
	<style>
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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<div class="text-center" style="font-size: 28px;">${sNickName}님의 플레이리스트</div>
	<br />
	<c:if test="${!empty playListVOS}">
		<div class="text-right">
			<button onclick="openModal()" class="btn" style="font-size:20px; margin-right:3em; color: #456789;">
				<i class="fa-solid fa-plus" style="color: #456789;"></i>
				 플레이리스트 추가
			</button>
		</div>
	</c:if>
	<c:if test="${empty playListVOS}">
		<div style="text-align: center; cursor: pointer; width: 200px; height: 200px; border: 1px solid #000;">
        	<a onclick="openModal()">
        		<div class="text-center">
            		<i class="fa-solid fa-plus" style="font-size: 50px; color: #000000; line-height: 4;"></i>
          		</div>
            	<div class="pt-2">플레이리스트 만들기</div>
          	</a>
        </div>
	</c:if>
		
	<c:set var="cnt" value="0"/>
	<div class="row mt-4">
	
	    <c:forEach var="vo" items="${playListVOS}">
	    	<div class="col-md-4">
	        	<div style="text-align: center;">
	        		<c:if test="${!empty vo.content}">
	        			<a href="${ctp}/member/playListDetail?idx=${vo.idx}">
	            			<img src="https://cdn.pixabay.com/photo/2013/07/13/12/16/note-159509_1280.png" width="200px" height="200px"/>
	            		</a>
        			</c:if>
	        		<c:if test="${empty vo.content}">
	        			<a href="${ctp}/member/playList" class="emptyPlayList">
	            			<img src="https://cdn.pixabay.com/photo/2016/12/21/17/11/signe-1923369_1280.png" width="200px" height="200px"/>
	            		</a>
        			</c:if>
        			<div class="pt-2">${vo.name}</div>
	      		</div>
	    	</div>
	    	<c:set var="cnt" value="${cnt+1}"/>
	    	<c:if test="${cnt%3 == 0}">
		        </div>
		        <div class="row mt-5">
	    	</c:if>
		</c:forEach>
	
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<div id="myModal" class="modal">
  <div class="modal-content">
  <h2 class="text-center">플레이리스트 만들기</h2>
  <br />
  <div class="mb-2"> 플레이리스트 이름을 입력해주세요.</div>
	<form name="myform" method="post">
		<input type="text" id="playListName" name="playListName" value="${sNickName}의 플레이리스트" class="form-control"/>
	</form>
  <br />
  <span>
    <button class="close btn text-right mr-3" style="font-size: 20px;" onclick="closeModal()">닫기</button>
    <button class="close btn text-right mr-3" style="font-size: 20px;" onclick="createPlayList()">저장</button>
  </span>
  </div>
</div>

<script>
	'use strict';
	
	document.addEventListener("DOMContentLoaded", function() {
	    let emptyPlayListElements = document.getElementsByClassName("emptyPlayList");
	  
	    for (let i = 0; i < emptyPlayListElements.length; i++) {
	        emptyPlayListElements[i].addEventListener("click", function() {
				alert("플레이리스트가 비었습니다.\n먼저 곡을 추가해주세요.");
		        location.href="${ctp}/song/chart";
	        });
	    }
	});
	
	// 모달 열기
	function openModal() {
	  var modal = document.getElementById("myModal");
	  modal.style.display = "block";
	}

	// 모달 닫기
	function closeModal() {
	  var modal = document.getElementById("myModal");
	  modal.style.display = "none";
	}
	
	// 플레이리스트 저장
	function createPlayList() {
	  var name = document.getElementById("playListName").value;
	  var memberIdx = "${sIdx}";
	  
	  $.ajax({
	    type: "POST",
	    url: "${ctp}/member/createPlayList",
	    data: { memberIdx: memberIdx, name: name },
	    success: function (response) {
	      if (response === "이미 동일한 이름의 플레이리스트가 존재합니다.") {
	        alert(response);
	        location.reload();
	      } else {
	        alert("새 플레이리스트가 생성되었습니다.");
	        location.reload();
	      }
	    },
	    error: function () {
	      alert("플레이리스트 생성에 실패했습니다.");
	    }
	  });

	  // 모달 닫기
	  closeModal();
	}

</script>
</body>
</html>