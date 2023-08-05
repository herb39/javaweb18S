<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>9 1 3</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link rel="stylesheet" href="${ctp}/resources/font/font.css">
  <link rel="stylesheet" href="${ctp}/resources/css/common.css">
  <script>
	  function nWin(orderIdx) {
	  	var url = "${ctp}/shop/orderDelivery?orderIdx="+orderIdx;
	  	window.open(url,"orderDelivery","width=350px,height=400px");
	  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>결제내역</h2>
  <hr/>
  <p>상품명 : ${sPaymentVO.name}</p>
  <p>주문금액 : ${sPaymentVO.amount} (실제주문금액:${orderTotalPrice})</p>
  <p>주문자 이메일 : ${sPaymentVO.buyer_email}</p>
  <p>주문자 성명 : ${sPaymentVO.buyer_name}</p>
  <p>주문자 전화번호 : ${sPaymentVO.buyer_tel}</p>
  <p>배송지 주소 : ${sPaymentVO.buyer_addr}</p>
  <p>배송지 우편번호 : ${sPaymentVO.buyer_postcode}</p>
  <p>결제 고유ID : ${sPaymentVO.imp_uid}</p>
  <p>결제 상점 거래 ID : ${sPaymentVO.merchant_uid}</p>
  <p>결제 금액 : ${sPaymentVO.paid_amount}</p>
  <p>카드 승인번호 : ${sPaymentVO.apply_num}</p>
  <hr/>
  <h2 class="text-center">주문완료</h2>
  <hr/>
  <table class="table table-bordered">
    <tr style="text-align:center;">
      <th>상품이미지</th>
      <th>주문일시</th>
      <th>주문내역</th>
      <th>비고</th>
    </tr>
    <c:forEach var="vo" items="${orderVOS}">
    <tr>
        <td style="text-align:center;">
            <img src="${ctp}/shop/product/${vo.thumbImg}" width="100px"/>
        </td>
        <td style="text-align:center;"><br/>
            <p>주문번호 : ${vo.orderIdx}</p>
            <p>총 주문금액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
            <p><input type="button" value="배송지정보" class="btn btn-dark btn-sm" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td align="left">
	        <p><br/>상품명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p><br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	            - 주문 내역
	            <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
	            <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	              &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	            </c:forEach> 
	        </p>
	    </td>
        <td style="text-align:center;"><br/><font color="blue">결제완료</font><br/>(배송준비중)</td>
    </tr>
    </c:forEach>
  </table>
  <hr/>
  <p class="text-center"><a href="${ctp}/shop/productList" class="btn btn-dark">계속쇼핑하기</a> &nbsp;
    <a href="${ctp}/shop/myOrder" class="btn btn-dark">구매내역보기</a>
  </p>
  <hr/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>