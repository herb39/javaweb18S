<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>913 admin</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/resources/font/font.css">
  <link rel="stylesheet" href="${ctp}/resources/css/common.css">
  <style>
  	/* * {
		font-family: 'IBMPlexSansKR-Regular';
	} */
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
    function songInfoInsert() {
    	let title = myform.title.value;
    	let image = myform.image.value;
    	let artist = myform.artist.value;
    	let album = myform.album.value;
    	let fName = myform.fName.value;
    	let releaseDate = myform.releaseDate.value;
    	let genre = myform.genre.value;
    	let lyrics = myform.lyrics.value;
    	
    	if(title.trim() == "") {
    		alert("곡 제목을 입력하세요.");
    		myform.title.focus();
    	}
    	else if(image.trim() == "") {
    		alert("이미지 주소를 입력하세요.");
    		myform.image.focus();
    	}
    	else if(artist.trim() == "") {
    		alert("아티스트명을 입력하세요.");
    		myform.artist.focus();
    	}
    	else if(album.trim() == "") {
    		alert("앨범명을 입력하세요.");
    		myform.album.focus();
    	}
    	else if(genre.trim() == "") {
    		alert("장르를 입력하세요.");
    		myform.genre.focus();
    	}
    	else if(lyrics.trim() == "") {
    		alert("가사를 입력하세요.");
    		myform.lyrics.focus();
    	}
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <div class="text-center" style="font-size: 28px;">음원정보수정</div><hr />
  
  <form name="myform" method="post" enctype="multipart/form-data">
  	<div class="text-right">
        <input type="button" value="저장" onclick="songInfoInsert()" class="btn btn-dark mb-3 mr-3"/>
        <a href="${ctp}/song/songInfoUpdate" class="btn btn-dark mb-3 mr-3">취소</a>
    </div>
    <table class="table table-bordered">
      <tr>
        <th>곡 제목</th>
        <td><input type="text" name="title" id="title" value="${songVO.title}" placeholder="곡 제목을 입력하세요." required class="form-control"></td>
      </tr>
      <tr>
        <th>이미지 주소</th>
        <td><input type="text" name="image" id="image" value="${songVO.image}" placeholder="이미지 주소를 입력하세요." required class="form-control"></td>
      </tr>
      <tr>
        <th>아티스트</th>
        <td><input type="text" name="artist" id="artist" value="${songVO.artist}" placeholder="아티스트명을 입력하세요." required class="form-control"/></td>
      </tr>
      <tr>
        <th>앨범</th>
        <td><input type="text" name="album" id="album" value="${songVO.album}" placeholder="앨범명을 입력하세요." required class="form-control"/></td>
      </tr>
      <tr>
        <th>음원파일</th>
        <td>
        	<c:if test="${!empty songVO.music}">등록된 음원 파일명 : ${songVO.music}</c:if>
        	<c:if test="${empty songVO.music}">등록된 음원 파일이 없습니다.</c:if>
        	<input type="file" name="fName" id="fName" class="form-control-file border" accept=".mp3" />
        </td>
      </tr>
      <tr>
        <th>발매일</th>
        <td><input type="date" name="releaseDate" value="${songVO.releaseDate}" class="form-control"/></td>
      </tr>
      <tr>
        <th>장르</th>
        <td><input type="text" name="genre" id="genre" value="${songVO.genre}" placeholder="장르를 입력하세요." required class="form-control"/></td>
      </tr>
      <tr>
        <th>가사</th>
        <td><textarea rows="20" name="lyrics" id="lyrics" class="form-control" required>${songVO.lyrics}</textarea></td>
      </tr>
    </table>
    <input type="hidden" name="music" />
    <div class="text-center">
        <input type="button" value="저장" onclick="songInfoInsert()" class="btn btn-dark mr-3"/>
        <a href="${ctp}/song/songInfoUpdate" class="btn btn-dark">취소</a>
    </div>
  </form>
</div>
<p><br/></p>
</body>
</html>