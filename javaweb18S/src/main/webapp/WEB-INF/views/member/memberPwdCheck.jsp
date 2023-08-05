<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberPwdCheck.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/resources/font/font.css">
	<link rel="stylesheet" href="${ctp}/resources/css/common.css">
	<link rel="stylesheet" href="${ctp}/resources/css/memberLogin.css">
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="text-center" style="font-size: 28px;">비밀번호 확인</div>
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th>비밀번호</th>
        <td><input type="password" name="pwd" id="pwd" class="form-control" required autofocus /></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="확인" class="btn btn-dark" />
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/';" class="btn btn-dark" />
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="${sMid}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>