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
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <div class="text-center" style="font-size: 28px;">음원 정보 검색결과</div>
  <div class="text-center">
  	<font color="blue">${searchTitle}</font>(으)로 <font color="red">${pageVO.searchString}</font>(을)를 검색한 결과입니다.
  </div>
  <br/>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td><a href="${ctp}/song/songInfoUpdate" class="btn btn-dark">돌아가기</a></td>
    </tr>
  </table>
  <table class="table table-hover text-center">
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
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${vo.idx}</td>
        <td><img src="${vo.image}" style="width: 60px;"></td>
        <td class="title1 left">${vo.title}</td>
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