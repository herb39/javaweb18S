> 음원 스트리밍, 굿즈 판매 사이트 제작 <br/>
> 기간 : 2023.06.29 - 2023.07.31 <br/>
> 인원 : 1인 <br/>

링크 : http://49.142.157.251:9090/javaweb18S/

<h1>사용 기술 스택</h1>
<ul>
 <li>
      <img src="https://img.shields.io/badge/java-red?style=for-the-badge&logo=java&logoColor=white"> 
      <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white">
    </li>
    <li>
      <img src="https://img.shields.io/badge/apache tomcat-orange?style=for-the-badge&logo=apachetomcat&logoColor=white">
      <img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
      <img src="https://img.shields.io/badge/myBatis-black?style=for-the-badge&logo=myBatis&logoColor=white">
    <li>
      <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
      <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"> 
      <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> 
      <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white">
      <img src="https://img.shields.io/badge/bootstrap4-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white">
      <img src="https://img.shields.io/badge/fontawesome-339AF0?style=for-the-badge&logo=fontawesome&logoColor=white">
    </li>
    <li>
     그외 : Jsoup / Selenium / CkEditor4 / 포트원 결제 모듈
    </li>
</ul>

<h1>구현 기능</h1>
<div>
    <ul>
        <li>
            <strong>계정</strong>
            <ul>
                <li>로그인, 로그아웃, 회원가입, 회원탈퇴</li>
                <li>ID찾기</li>
                <li>비밀번호 재발급 - 이메일 전송</li>
                <li>주문 목록</li>
                <li>관리자 페이지를 통한 음원/상품 조회, 수정</li>
            </ul>
        </li>
        <li>
            <strong>음악 플레이어</strong>
            <ul>
                <li>음원 파일 재생</li>
                <li>재생 위치, 볼륨 조절 / 가사 보기</li>
            </ul>
        </li>
        <li>
            <strong>음원 정보</strong>
            <ul>
                <li>카테고리별 음원 조회, 검색</li>
                <li>Jsoup / Selenium을 이용한 크롤링 - 멜론 인기차트</li>
                <li>음원 상세정보 조회</li>
                <li>음원 등록, 수정, 삭제</li>
            </ul>
        </li>
        <li>
            <strong>상품</strong>
            <ul>
                <li>카테고리별 상품 조회</li>
                <li>카테고리 등록, 삭제</li>
                <li>상품 등록, 수정, 삭제</li>
            </ul>
        </li>
        <li>
            <strong>게시판</strong>
            <ul>
                <li>게시판 CRUD</li>
                <li>버튼 페이징</li>
            </ul>
        </li>
        <li>
            <strong>장바구니</strong>
            <ul>
                <li>추가, 개별주문, 선택주문</li>
            </ul>
        </li>
        <li>
            <strong>결제 - KG 이니시스</strong>
            <ul>
                <li>신용카드, 가상계좌</li>
            </ul>
        </li>
    </ul>
</div>


<h1>이미지</h1>
<div>
    <ul>
        <li>
            <strong>메인 페이지</strong>
            <ul>
                <img src="https://i.imgur.com/e6e2ogX.png" width="500px">
                <li>인기 차트 100 / 음원 검색 가능</li>
                  <img src="https://i.imgur.com/bLE4f2X.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>음원 플레이어</strong>
            <ul>
                <li>재생 위치 변경, 볼륨 조절, 가사 보기 가능</li>
                  <img src="https://i.imgur.com/c2TWmEh.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>로그인/회원가입/아이디찾기/비밀번호찾기</strong>
            <ul>
                <li>아이디 중복검사</li>
                <li>프론트 유효성 검사</li>
                <li>SMTP이용 - 임시비밀번호 재발급</li>
                  <img src="https://i.imgur.com/chBvyvC.png" width="500px">
                  <img src="https://i.imgur.com/rt1fkSG.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>마이페이지</strong>
            <ul>
                <li>장바구니, 배송정보, 회원탈퇴, 회원수정 가능</li>
            </ul>
        </li>
        <li>
            <strong>굿즈</strong>
            <ul>
                <li>아티스트 선택 정렬 가능</li>
                <li>수량 변경 가능</li>
                    <img src="https://i.imgur.com/cuQxUhx.png" width="500px">
                    <img src="https://i.imgur.com/1OlyRRs.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>장바구니</strong>
            <ul>
                <li>개별 혹은 선택주문</li>
                <li>선택 삭제 가능</li>
                <li>배송비 5만원 이상일 경우 0원으로, 이하일 경우 2500원으로 변경</li>
                    <img src="https://i.imgur.com/sjqNtId.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>상품 주문</strong>
            <ul>
                <li>구매하려는 상품 목록 표시</li>
                <li>구매 클릭시 프론트에서 배송정보 유효성 검사후 결제 진행</li>
                <li>무통장입금, 가상계좌 결제 가능</li>
                    <img src="https://i.imgur.com/kvVDu99.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>주문 정보</strong>
            <ul>
                <li>주문 날짜 별 검색 가능</li>
                <li>주문한 상품에 대한 기본 정보 표시</li>
                    <img src="https://i.imgur.com/JoaEHuM.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>관리자 페이지 메인</strong>
            <ul>
                <li>최근 5건의 주문 목록, CS 통계</li>
                <img src="https://i.imgur.com/Nx5Gvb6.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>관리자 상품 관리</strong>
            <ul>
                <li>카테고리 생성/삭제 가능</li>
                <li>대분류 선택 후 동적으로 중분류 활성화</li>
                <li>카테고리 삭제 - 해당 카테고리 내에 상품이 1개도 없을 경우 삭제 가능</li>
                <li>상품 추가 - 이미지 드래그&드롭을 통한 업로드 기능, 썸네일 지정 가능, CK에디터 사용</li>
                <li>상품 리스트 - TOAST UI Grid 이용, 리스트에서 더블클릭으로 상품 정보 수정 가능</li>
                <li>상품 삭제 - 주문이 1건도 들어오지 않은 경우 삭제 가능</li>
                <img src="https://i.imgur.com/BXLgIqG.png" width="500px">
                <img src="https://imgur.com/MeEavtF.png" width="500px">
                <img src="https://i.imgur.com/BXLgIqG.png" width="500px">
                <img src="https://imgur.com/hiJZIqM.png" width="500px">
            </ul>
        </li>
         <br/>
        <li>
            <strong>관리자 페이지 주문목록</strong>
            <ul>
                <li>주문상태 변경 기능</li>
                <li>쿼리스트링, AJAX 이용 - 비동기식 검색 및 갱신</li>
                <li>선택 주문 주문상태 변경 가능</li>
                <img src="https://imgur.com/EEiPcdp.png" width="500px">
                <img src="https://imgur.com/IZeVU0j.png" width="500px">
            </ul>
        </li>
        <br/>
        <li>
            <strong>관리자 페이지 상품배송</strong>
            <ul>
                <li>배송중인 주문만 표시</li>
                <li>운송장 입력후 배송시 해당 주문 배송상태를 '배송중'으로 변경</li>
            </ul>
        </li>
        <br/>
    </ul>
</div>
<br/>
