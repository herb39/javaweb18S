<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>9 1 3</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/resources/font/font.css">
  <link rel="stylesheet" href="${ctp}/resources/css/common.css">
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
    function fCheck() {
    	let title = myform.title.value;
    	let content = myform.content.value;
    	
    	if(title.trim() == "") {
    		alert("게시글 제목을 입력하세요");
    		myform.title.focus();
    	}
    	/* 
    	else if(content.trim() == "") {
    		alert("게시글 내용을 입력하세요");
    		myform.content.focus();
    	}
    	 */
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="text-center" style="font-size: 28px;">게시글 작성</div><br />
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th>작성자</th>
        <td>${sNickName}</td>
      </tr>
      <tr>
        <th>제목</th>
        <td><input type="text" name="title" id="title" placeholder="글제목을 입력하세요" autofocus required class="form-control"></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="text" name="email" id="email" placeholder="이메일을 입력하세요" class="form-control"/></td>
      </tr>
      <tr>
        <th>내용</th>
        <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required></textarea></td>
        <script>
        CKEDITOR.replace("content",{
        	height:480,
        	filebrowserUploadUrl:"${ctp}/board/imageUpload",	/* 파일(이미지) 업로드시 매핑경로 */
        	uploadUrl : "${ctp}/board/imageUpload"		/* 여러개의 그림파일을 드래그&드롭해서 올리기 */
        });
        </script>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="저장" onclick="fCheck()" class="btn btn-dark"/> &nbsp;
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList';" class="btn btn-dark"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="nickName" value="${sNickName}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>