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
  <script>
    'use strict';
    
    // 전체 댓글(보이기/가리기)
    $(document).ready(function(){
    	$("#reply").show();
    	$("#replyViewBtn").hide();
    	
    	$("#replyHiddenBtn").click(function(){
    		$("#reply").slideUp(500);
    		$("#replyViewBtn").show();
    		$("#replyHiddenBtn").hide();
    	});
    	
    	$("#replyViewBtn").click(function(){
    		$("#reply").slideDown(500);
    		$("#replyViewBtn").hide();
    		$("#replyHiddenBtn").show();
    	});
    });
    
    // 게시글 삭제처리
    function boardDelete() {
    	let ans = confirm("현 게시글을 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/board/boardDelete?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&nickName=${vo.nickName}";
    }
    
    // 댓글달기(aJax처리)
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요!");
    		$("#content").focus();
    		return false;
    	}
    	let query = {
    			boardIdx : ${vo.idx},
    			mid      : '${sMid}',
    			nickName : '${sNickName}',
    			content  : content,
    			hostIp   : '${pageContext.request.remoteAddr}'
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/board/boardReplyInput",
    		data  : query,
    		success:function(res) {
    			if(res == "1") {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("댓글이 입력 실패~~");
    			}
    		},
    		error : function() {
    			alert("전송 오류!!!");
    		}
    	});
    }
    
    // 댓글삭제
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : 'post',
        url : '${ctp}/board/boardReplyDelete',
        data : {
        	replyIdx : idx,
        },
        success : function(res) {
          if(res != '0') {
           alert('댓글이 삭제되었습니다.');
           location.reload();
          }
          else {
           alert('댓글이 삭제되지 않았습니다.');
          }
        },
        error : function() {
          alert('전송실패~~');
        }
      });
    }
    
 	// 댓글 수정 폼 출력
    function updateReplyForm(idx, content) {
    	let insReply = '';
    	insReply += '<div style="text-align: center;">';
    	insReply += '<div>';
    	insReply += '<textarea name="content" class="mt-4" id="content'+idx+'" style="width: 800px; height: 100px;">';
    	insReply += content.replaceAll("<br/>", "\n");
    	insReply += '</textarea>';
    	insReply += '<a href="javascript:updateReply('+idx+')" title="저장" class="btn btn-dark mb-5 ml-5" id="replyBoxUpdateBtn${replyVO.idx}">저장</a>';
    	insReply += '</div>';
    	insReply += '</div>';
    	
    	$("#replyBoxOpenBtn"+idx).hide();
    	$("#replyBoxCloseBtn"+idx).show();
    	$("#replyBox"+idx).slideDown(500);
    	$("#replyBox"+idx).html(insReply);
    }
    
    // 댓글 수정
    function updateReply(idx) {
    	let content = $("#content"+idx).val();
    	let hostIp = "${pageContext.request.remoteAddr}";
    	
    	if(content == "") {
    		alert("댓글을 입력하세요!");
    		$("#content"+idx).focus();
    		return false;
    	}
    	
    	let query = {
    			idx : idx,
    			content : content,
    			hostIp  : hostIp
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/board/boardReplyUpdate",
    		data : query,
    		success:function() {
    			alert("수정완료");
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">글 내 용</h2>
  <br/>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td class="text-right">접속IP : ${vo.hostIp}</td>
    </tr>
  </table>
  <table class="table table-bordered">
    <tr>
      <th>작성자</th>
      <td>${vo.nickName}</td>
      <th>작성일</th>
      <td>${fn:substring(vo.WDate,0,fn:length(vo.WDate)-3)}</td>
    </tr>
    <tr>
      <th>제목</th>
      <td colspan="3">${vo.title}</td>
    </tr>
    <tr>
      <th>내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4" class="text-center">
        <c:if test="${flag == 'search'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardSearch?search=${search}&searchString=${searchString}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-dark"/></c:if>
        <c:if test="${flag == 'searchMember'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardSearchMember?pag=${pag}&pageSize=${pageSize}';" class="btn btn-dark"/></c:if>
        <c:if test="${flag != 'search' && flag != 'searchMember'}"><input type="button" value="목록으로" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-dark"/></c:if>
        &nbsp;
      	<c:if test="${sMid == vo.mid || sLevel == 0}">
        	<input type="button" value="수정" onclick="location.href='${ctp}/board/boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-dark"/> &nbsp;
        	<input type="button" value="삭제" onclick="boardDelete()" class="btn btn-dark"/>
      	</c:if>
      </td>
    </tr>
  </table>
  
  <c:if test="${flag != 'search' && flag != 'searchMember'}">
	  <!-- 이전글/ 다음글 처리 -->
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        <c:if test="${!empty pnVos[1]}">
	          <i class="fa-solid fa-angle-up" style="color: #000000;"></i> <a href="${ctp}/board/boardContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[1].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx < pnVos[0].idx}">
	        	<i class="fa-solid fa-angle-up" style="color: #000000;"></i> <a href="${ctp}/board/boardContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx > pnVos[0].idx}">
	        	<i class="fa-solid fa-angle-down" style="color: #000000;"></i> <a href="${ctp}/board/boardContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	      </td>
	    </tr>
	  </table>
  </c:if>
  
  <!-- 댓글(대댓글) 보이기 가리기 버튼처리 -->
  <div class="text-center mb-3">
    <input type="button" value="댓글보이기" id="replyViewBtn" class="btn btn-dark" style="display:none;" />
    <input type="button" value="댓글가리기" id="replyHiddenBtn" class="btn btn-dark"/>
    <br />
    <br />
	  <c:if test="${sLevel == null}">
	  	<a href="${ctp}/member/memberLogin" class="text-center mb-3"><b><font color="blue">로그인</font></b></a> 후 댓글 작성이 가능합니다.
	  </c:if>
  </div>
  <!-- 댓글 리스트보여주기 -->
  <div id="reply" class="container">
    <table class="table table-hover text-left">
      <tr>
        <th>작성자</th>
        <th>내용</th>
        <th>작성일</th>
        <th>접속IP</th>
      </tr>
      <c:forEach var="replyVO" items="${replyVOS}" varStatus="st">
	        <tr>
	          <td class="text-center" style="width: 200px;">${replyVO.nickName}</td>
	          <td style="max-width: 500px;">${fn:replace(replyVO.content, newLine, "<br/>")}</td>
	          <td class="text-center" style="width: 170px;">${fn:substring(replyVO.WDate,0,10)}</td>
	          <td class="text-center" style="width: 170px;">
	          	${replyVO.hostIp}
	          	<c:if test="${sMid == replyVO.mid || sLevel == 0}">
	              <a href="javascript:replyDelete(${replyVO.idx})" title="댓글삭제"><b><i class="fa-solid fa-xmark" style="color: #ff0000;"></i></b></a>
	              <c:if test="${sMid == replyVO.mid || sLevel == 0}">
		            	<c:set var="content" value="${fn:replace(replyVO.content,newLine,'<br/>')}"/>
		            	 <a href="javascript:updateReplyForm('${replyVO.idx}','${content}')" title="댓글수정" id="replyBoxUpdateBtn${replyVO.idx}"><i class="fa-solid fa-pen" style="color: #000000;"></i></a>
		            </c:if>
	            </c:if>
	          </td>
	        </tr>
	        <tr>
	          <td colspan="5" class="m-0 p-0" style="border-top:none;"><div id="replyBox${replyVO.idx}"></div></td>
	        </tr>
      </c:forEach>
    </table>
  </div>
  
  <!-- 댓글 입력창 -->
  <c:if test="${sLevel == 0 || sLevel == 1}">
	  <form name="replyForm">
	  	<table class="table tbale-center">
	  	  <tr>
	  	    <td style="width:85%" class="text-left">
	  	      글내용 :
	  	      <textarea rows="4" name="content" id="content" class="form-control"></textarea>
	  	    </td>
	  	    <td style="width:15%">
	  	    	<br/>
	  	      <p>작성자 : ${sNickName}</p>
	  	      <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-dark btn-sm"/></p>
	  	    </td>
	  	  </tr>
	  	</table>
	  </form>
  </c:if>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>