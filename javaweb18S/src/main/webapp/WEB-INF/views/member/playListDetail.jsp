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
		td {
			vertical-align: middle!important;
			white-space: nowrap;
	        overflow: hidden;
	        text-overflow: ellipsis;
		}
		.left {
			text-align: left;
		}
		.title1 {
			max-width: 280px;		
		}
		.artist {
			max-width: 170px;
		}
		.album {
			max-width: 140px;
		}
		#topBtn {
			z-index: 99;
			font-size: 2em;
			cursor: pointer;
  			position: fixed;
		    display: none;
  			bottom: 50px;
  			right: 50px;
		}
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
	<h2 class="text-center" style="font-size: 28px;">${playListVO.name}</h2>
	<div>
		<span>
			<a href="${ctp}/member/playList" type="button" class="btn btn-dark">목록</a>
		</span>
		<div class="text-right">
			<button type="button" class="btn btn-dark" onClick="openModal()">이름수정</button>
			<button type="button" class="btn btn-dark" onClick="playListDelete()">플리삭제</button>
		</div>	
	<div class="text-center">
		<button type="button" style="font-size: 40px;" class="btn btn-dark" onClick="openPlayer()"><i class="fa-solid fa-music" style="color: #ffffff;"></i>&nbsp;PLAY</button>
	</div>
	<br />
	<button type="button" class="btn btn-dark ml-3" onClick="playListSongDelete(${songVO.idx})">선택삭제</button>
  	<c:if test="${!empty songVOS}">
  			<table class="table table-hover text-center">
            <tr>
              <th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
		      <th></th>
		      <th>곡정보</th>
		      <th>아티스트</th>
		      <th>앨범</th>
            </tr>
  			<c:forEach var="songVO" items="${songVOS}" varStatus="St">
                <tr>
                	<td><input type="checkbox" name="idxChecked" id="idx${songVO.idx}" value="${songVO.idx}" onClick="onCheck()" /></td>
                    <td class="title1 left"><a href="${ctp}/song/songInfo?songIdx=${songVO.idx}"><img src="${songVO.image}" style="width: 60px;"></a></td>
                    <td class="artist left"><a href="${ctp}/song/songInfo?songIdx=${songVO.idx}">${songVO.title}</a></td>
                    <td><a href="${ctp}/song/songInfo?songIdx=${songVO.idx}">${songVO.artist}</a></td>
                    <td class="album left"><a href="${ctp}/song/songInfo?songIdx=${songVO.idx}">${songVO.album}</a></td>
                </tr>
            </c:forEach>
            <tr><td colspan="5" class="m-0 p-0"></td></tr>
        </table>
	    <c:set var="minIdx" value="${songVOS[0].idx}" />
		<c:set var="maxIdx" value="${songVOS[fn:length(songVOS) - 1].idx}" />
  	</c:if>
</div>
<p><br/></p>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<div id="playListNameUpdateModal" class="modal">
  <div class="modal-content">
  <h2 class="text-center">플레이리스트 이름 수정</h2>
  <br />
  <div class="mb-2"> 변경할 플레이리스트 이름을 입력해주세요.</div>
	<form name="playListNameUpdateForm" method="post">
		<input type="text" id="playListName" name="playListName" value="${playListVO.name}" class="form-control"/>
	</form>
  <br />
  <span>
    <button class="close btn text-right mr-3" style="font-size: 20px;" onclick="closeModal()">닫기</button>
    <button class="close btn text-right mr-3" style="font-size: 20px;" onclick="playListNameUpdate()">저장</button>
  </span>
  </div>
</div>
<script>
	'use strict';
	
	let minIdx = parseInt(${minIdx});
    let maxIdx = parseInt(${maxIdx});
	let popupPlayer;
	
	function openPlayer() {
			let url = "${ctp}/song/player";
			let popupWidth = 800;
			let popupHeight = 700;
			
			let popupX = (window.screen.width / 2) - (popupWidth / 2);
			let popupY= (window.screen.height / 2) - (popupHeight / 2);
			
			popupPlayer = window.open(url, 'player', 'status=no, scrollbars=no, resizable, toolbars=no, menubar=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
			popupPlayer.resizeTo(popupWidth, popupHeight);
			popupPlayer.onresize = (_=>{
			popupPlayer.resizeTo(popupWidth, popupHeight);
		})
	}
	
    function allCheck() {
        const checkboxes = document.querySelectorAll('input[name="idxChecked"]');
        const allCheckBtn = document.getElementById('allcheck');

        if (allCheckBtn.checked) {
            checkboxes.forEach(checkbox => checkbox.checked = true);
        } else {
            checkboxes.forEach(checkbox => checkbox.checked = false);
        }
    }
    
    function onCheck() {
        let emptyCnt = 0;
        for (let i = minIdx; i <= maxIdx; i++) {
            if ($("#idx" + i).length != 0 && document.getElementById("idx" + i).checked == false) {
                emptyCnt++;
                break;
            }
        }
        if (emptyCnt != 0) {
            document.getElementById("allcheck").checked = false;
        } else {
            document.getElementById("allcheck").checked = true;
        }
    }
    
 	// 플레이리스트 삭제
    function playListDelete() {
    	let ans = confirm("플레이리스트를 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/member/playListDelete?idx=${playListVO.idx}";
    }
 	
 	// 플레이리스트에서 곡 삭제 (업데이트)
    /* function playListSongDelete(idx) {
        let selectedIdxList = []; // 선택된 항목의 idx를 저장할 배열

        // 선택된 체크박스의 값을 배열에 저장
        const checkboxes = document.querySelectorAll('input[name="idxChecked"]');
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                selectedIdxList.push(checkbox.value);
            }
        });

        if (selectedIdxList.length === 0) {
            alert("선택된 곡이 없습니다.");
            return;
        }

        let ans = confirm("선택한 곡들을 플레이리스트에서 삭제하시겠습니까?");
        if (ans) {
            $.ajax({
                type: "post",
                url: "${ctp}/member/playListSongDelete",
                data: { idxList: selectedIdxList }, // 배열 형태로 서버로 보냅니다.
                traditional: true, // 배열 파라미터를 전통적인 방식으로 전송
                success: function () {
                    location.reload(); // 삭제 후 페이지 새로고침
                },
                error: function () {
                    alert("전송에러!");
                }
            });
        }
    } */
    
 	// 모달 열기
	function openModal() {
	  var modal = document.getElementById("playListNameUpdateModal");
	  modal.style.display = "block";
	}

	// 모달 닫기
	function closeModal() {
	  var modal = document.getElementById("playListNameUpdateModal");
	  modal.style.display = "none";
	}
	
	// 플레이리스트 이름 수정
	function playListNameUpdate() {
	  var name = document.getElementById("playListName").value;
	  var memberIdx = "${sIdx}";
	  var idx = "${playListVO.idx}";
	  
	  
	  $.ajax({
	    type: "POST",
	    url: "${ctp}/member/playListNameUpdate",
	    data: { memberIdx: memberIdx, name: name, idx: idx },
	    success: function (response) {
	      if (response === "이미 동일한 이름의 플레이리스트가 존재합니다.") {
	        alert(response);
	        location.reload();
	      } else {
	        alert("플레이리스트 이름이 변경되었습니다.");
	        location.reload();
	      }
	    },
	    error: function () {
	      alert("플레이리스트 이름 변경에 실패했습니다.");
	    }
	  });

	  // 모달 닫기
	  closeModal();
	}

 	
    
</script>
</body>
</html>