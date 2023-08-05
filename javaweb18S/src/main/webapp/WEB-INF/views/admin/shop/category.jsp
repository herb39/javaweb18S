<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>9 1 3</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="${ctp}/resources/font/font.css">
  <link rel="stylesheet" href="${ctp}/resources/css/common.css">
  <script>
    'use strict';
    
    // 아티스트 등록하기
    function categoryArtistCheck() {
    	let categoryArtistCode = categoryArtistForm.categoryArtistCode.value;
    	let categoryArtistName = categoryArtistForm.categoryArtistName.value;
    	if(categoryArtistCode.trim() == "" || categoryArtistName.trim() == "") {
    		alert("아티스트 코드를 입력하세요");
    		categoryArtistForm.categoryArtistName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/shop/categoryArtistInput",
    		data : {
    			categoryArtistCode : categoryArtistCode,
    			categoryArtistName : categoryArtistName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 아티스트 코드가 등록되어 있습니다.\n확인 후 다시 입력하세요.");
    			else {
    				alert("아티스트 코드가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 소분류 입력창에서 대분류 선택시에 중분류 자동 조회하기
    /* function categoryMainChange() {
    	let categoryMainCode = categoryProductForm.categoryMainCode.value;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/shop/categoryArtistName",
    		data : {categoryMainCode : categoryMainCode},
    		success:function(vos) {
    			let str = '';
    			str += '<option value="">중분류선택</option>'
    			for(let i=0; i<vos.length; i++) {
    				str += '<option value="'+vos[i].categoryArtistCode+'">'+vos[i].categoryArtistName+'</option>';
    			}
    			$("#categoryArtistCode").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    } */
    
    // 소분류 등록하기
    function categoryProductCheck() {
    	let categoryArtistCode = categoryProductForm.categoryArtistCode.value;
    	let categoryProductCode = categoryProductForm.categoryProductCode.value;
    	let categoryProductName = categoryProductForm.categoryProductName.value;
    	if(categoryArtistCode.trim() == "" || categoryProductCode.trim() == "" || categoryProductName.trim() == "") {
    		alert("소분류명(코드)를 입력하세요");
    		categoryProductForm.categoryProductName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/shop/categoryProductInput",
    		data : {
    			categoryArtistCode : categoryArtistCode,
    			categoryProductCode : categoryProductCode,
    			categoryProductName : categoryProductName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
    				alert("상품분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 중분류 삭제하기
    function categoryArtistDelete(categoryArtistCode) {
    	let ans = confirm("아티스트 코드를 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/shop/categoryArtistDelete",
    		data : {categoryArtistCode : categoryArtistCode},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있어 삭제할 수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("아티스트 코드가 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 소분류 삭제하기
    function categoryProductDelete(categoryProductCode) {
    	let ans = confirm("상품분류코드를 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/shop/categoryProductDelete",
    		data : {categoryProductCode : categoryProductCode},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있어 삭제할 수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("상품분류코드가 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>상품 분류(아티스트/상품) 등록</h2>
  <hr/>
  <form name="categoryArtistForm">
    <h4><b>아티스트 코드 등록(숫자 2자리)</b></h4>
    아티스트 코드(01,02,03,...)
    <input type="text" name="categoryArtistCode" size="2" maxlength="2"/>&nbsp; &nbsp; / &nbsp;
    아티스트명
    <input type="text" name="categoryArtistName" size="8"/> &nbsp;
    <input type="button" value="아티스트 등록" onclick="categoryArtistCheck()" class="btn btn-dark btn-sm" />
    <table class="table table-hover m-3">
      <tr class="text-center">
        <th>아티스트 코드</th>
        <th>아티스트명</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="artistVO" items="${artistVOS}">
        <tr class="text-center">
          <td>${artistVO.categoryArtistCode}</td>
          <td>${artistVO.categoryArtistName}</td>
          <td><a type="button" onclick="categoryArtistDelete('${artistVO.categoryArtistCode}')" class="btn"><i class="fa-solid fa-trash-can" style="color: #000000;"></i></a></td>
        </tr>
      </c:forEach>
      <tr><td colspan="3" class="m-0 p-0"></td></tr>
    </table>
  </form>
  <br/>
  <form name="categoryProductForm">
    <h4><b>상품 분류 코드(숫자 3자리)</b></h4>
    아티스트 선택
    <select name="categoryArtistCode" id="categoryArtistCode">
      <option value="">아티스트명</option>
      <c:forEach var="artistVO" items="${artistVOS}">
        <option value="${artistVO.categoryArtistCode}">${artistVO.categoryArtistName}</option>
      </c:forEach>
    </select>&nbsp; &nbsp; / &nbsp;
    상품분류코드(001,002,003,...)
    <input type="text" name="categoryProductCode" size="2" maxlength="3"/>&nbsp; &nbsp; / &nbsp;
    상품분류
    <input type="text" name="categoryProductName" size="8"/> &nbsp;
    <input type="button" value="상품분류등록" onclick="categoryProductCheck()" class="btn btn-dark btn-sm" />
    <table class="table table-hover m-3">
      <tr class="text-center">
        <th>상품분류코드</th>
        <th>상품분류</th>
        <th>아티스트명</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="productVO" items="${productVOS}">
        <tr class="text-center">
          <td>${productVO.categoryProductCode}</td>
          <td>${productVO.categoryProductName}</td>
          <td>${productVO.categoryArtistName}</td>
          <td><a type="button" onclick="categoryProductDelete('${productVO.categoryProductCode}')" class="btn"><i class="fa-solid fa-trash-can" style="color: #000000;"></i></a></td>
        </tr>
      </c:forEach>
      <tr><td colspan="4" class="m-0 p-0"></td></tr>
    </table>
  </form>
</div>
<p><br/></p>
</body>
</html>