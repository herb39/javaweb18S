<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>9 1 3</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="${ctp}/font/font.css">
	<link rel="stylesheet" href="${ctp}/css/common.css">
	<link rel="stylesheet" href="${ctp}/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${ctp}/css/owl.theme.default.min.css">
	<script src="${ctp}/js/owl.carousel.js"></script> 
	<script src="${ctp}/js/owl.carousel.min.js"></script>
	<style>
		.item {
			width: 120px;
			margin: 5px;
		}
		.item:hover {
			transform: scale(1.05);
			transition: transform 0.15s ease 0s;
		}
		.owl-carousel {
			z-index: 0;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<p><br /><p>
	<div class="container">
		
		<div class="row">
			<div style="font-size: 24px;" class="col-11">TOP 10</div>
			<button type="button" onclick="location.href='${ctp}/song/chart';" class="btn col-1 btn-dark">TOP 100</button>
		</div>
		
		<br />
		<div class="owl-carousel owl-theme">
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<c:if test="${st.count <= 15}">
			   		<div class="item">
			   			<a href="${ctp}/song/songInfo?songIdx=${vo.songIdx}">
			   				<img src="${vo.image}">
			   			</a>
			   		</div>
			   	</c:if>
			</c:forEach>
		</div>
		<br />




		<div class="row">
			<c:forEach var="vo" items="${productVOS}">
				<div class="col-md-4">
					<div style="text-align: center">
						<a href="${ctp}/shop/productContent?idx=${vo.idx}">
						<img src="${ctp}/shop/product/${vo.FSName}" width="200px" height="180px" />
							<div><font size="2">${vo.productName}</font></div>
							<div><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###" />원</font></div>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>







				<div class="" style="font-size: 24px;">매거진</div><br />
		<div class="row">
			<div class="col-4" style="text-align: center;">
				<img src="https://cdnimg.melon.co.kr/resource/image/cds/musicstory/imgUrl20230727023509380.jpg" style="width: 80%;">
			</div>
			<div class="col-8 mt-3">
				슈퍼루키에서 실력파 음악인으로 성장! JEY<br /><br />
				<span style="font-size: 14px; color: #777;">
				R&B 아티스트 JEY가 지난 4월 발매한 싱글 'Venus'에 이어 EP [Contact]로 돌아왔습니다. 이번 EP는 [Algorithm] 이후의 첫 EP 앨범인데요.
				이번 앨범은 R&B Soul 장르의 앨범으로 더욱 성숙된 JEY의 자아가 담겨 있는 앨범입니다.
				JEY의 이번 EP와 함께 타이틀곡 'Freaky' MV도 함께 릴리즈됐는데요! 지금 바로 'Freaky' 뮤직비디오 비하인드 현장으로 함께 떠나볼까요?
				</span>
			</div>
		</div>
		<hr />
		<div class="row">
			<div class="col-4" style="text-align: center;">
				<img src="https://cdnimg.melon.co.kr/resource/image/cds/musicstory/imgUrl20230727024913534.jpg" style="width: 80%;">
			</div>
			<div class="col-8 mt-3">
				한층 더 성장한 트레저의 프로듀싱 실력, TREASURE (트레저)<br /><br />
				<span style="font-size: 14px; color: #777;">
				글로벌 아티스트로 도약하고 있는 YG 보이그룹 TREASURE (트레저)가 정규 2집 [REBOOT]로 새로운 출발을 알린다. 지난 6월 유닛 선공개 곡 'MOVE (T5)'로 기존과 다른 차별화된 모습을 선보이며 전 세계 리스너들의 마음을 사로잡았다.
				한층 더 성장한 TREASURE (트레저)의 프로듀싱 실력을 담은 정규 2집 [REBOOT]은 총 10곡의 완성도 높은 곡으로 TREASURE (트레저)의 새로운 재시동을 알리는 신호탄이 될 것이다.
				</span>
			</div>
		</div>
		<hr />
		<div class="row">
			<div class="col-4" style="text-align: center;">
				<img src="https://cdnimg.melon.co.kr/resource/image/cds/musicstory/imgUrl20230727021525550.jpg" style="width: 80%;">
			</div>
			<div class="col-8 mt-3">
				불완전한 만큼 당당하고 행복한 지금, 새로운 버전의 Anne-Marie!<br /><br />
				<span style="font-size: 14px; color: #777;">
				싱어송라이터 Anne-Marie가 세 번째 정규앨범을 들고 돌아왔습니다. 지난 앨범 [Therapy]가 발매된 건 2년 전 여름인데요. 2집을 공개하면서 이런 얘기를 했죠.
				'음악은 모두에게 치료의 원천이자
				치료 그 자체예요.
				제가 쓴 가사는 여러분에게 공개하는
				저의 일기장이고요.
				[Therapy]의 작업이 제 감정을 이해하고
				집중하는 데 도움이 되었습니다.
				저에게 이 앨범이 필요했어요.'
				</span>
			</div>
		</div>
		<hr />
		<div class="row">
			<div class="col-4" style="text-align: center;">
				<img src="https://cdnimg.melon.co.kr/resource/image/cds/musicstory/imgUrl20230728060745104.jpg" style="width: 80%;">
			</div>
			<div class="col-8 mt-3">
				말레이시아의 기대주, Lunadira의 신곡 외 이주의 히든트랙<br /><br />
				<span style="font-size: 14px; color: #777;">
				SNS의 힘으로 전세계의 음악을
				시간 차 없이 즐길 수 있게된 요즘!
				말레이시아 출신인 Lunadira 역시
				2014년 SNS에 올린 우쿠렐레
				커버곡으로 해외 유저들에게
				이름을 알리기 시작했는데요.
				
				2017년 데뷔 싱글을 기점으로
				특유의 매혹적인 목소리와
				부드러운 인디 팝으로,
				다른 말레이시아 뮤지션과 함께
				영미 매체에 소개되곤 했지만,
				2020년 EP 이후 소식이 뜸했었지요.
				</span>
			</div>
		</div>
		
		
		
	</div>
	<p><br /><p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
		$('.owl-carousel').owlCarousel({
		    stagePadding: 100,
		    loop:true,
		    margin:0,
		    nav:true,
		    autoplay:true,
		    autoplayTimeout:2000,
		    autoplayHoverPause:true,
		    responsive:{
		        0:{
		            items:1
		        },
		        600:{
		            items:3
		        },
		        1000:{
		            items:6
		        }
		    }
		})
	</script>
</body>
</html>
