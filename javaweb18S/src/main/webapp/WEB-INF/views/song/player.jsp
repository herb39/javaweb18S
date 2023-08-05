<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>9 1 3 Player</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${ctp}/resources/css/playerBG.css">
	<link rel="stylesheet" href="${ctp}/resources/css/player.css">
	<link rel="stylesheet" href="${ctp}/resources/font/font.css">
	<style>
		.white-icon {
			color: white;
		}
		#image {
		    margin-top: 150px;
		    width: 250px;
		    margin-left: 80px
		}
		#lyrics {
			min-height: 556px;
			max-height: 556px;
	  		overflow-y: auto;
	  		background-color: #000;
	  		opacity: 0.45;
	  		color: #fff;
	  		white-space: pre-line;
	  		font-family: 'IBMPlexSansKR-Regular';
	  		text-align:center;
		}
	</style>
</head>
<body>
	<div class="bgImage" id="bgImage"></div>
	<audio id="music">
		<source src="${ctp}/resources/data/music/${songVO.music}" />
		<%-- <source src="${ctp}/resources/mp3/${songVO.music}" /> --%>
	</audio>
	<div class="row">
		<div class="col">
			<img src="${songVO.image}" id="image">
		</div>
		<div class="col" id="lyrics">
			${fn:replace(songVO.lyrics, newLine, "<br/>")}
		<br/>
		</div>
	</div>
	
	
	
	<div class="player">
		<div id="progressBar" class="progressBar">
		    <div id="progressIndicator" class="progressIndicator"></div>
		</div>
		<div>
			<div style="color: white;">
				<span id="formattedCurrentTime"></span>
				<span id="formattedDuration"></span>
			</div>
		</div><br/>
		<div class="row">
			<div id="ttt" class="col-2" style="color: #eee; margin-left: 15px;">
				<marquee style="margin-top:8px">${songVO.artist} - ${songVO.title}</marquee>				
			</div>
			<div class="col-2 mt-2" style="text-align: left;">
				<span id="repeat" class="repeat ml-4">
					<i class="fa-solid fa-repeat"></i>
				</span>
				<span id="shuffle" class="shuffle ml-4" style="">
					<i class="fa-solid fa-shuffle"></i>
				</span>
			</div>
			<div class="col-4" style="margin-top: -5px;">
				<span id="backward" class="backward bppf" style="margin-left: -30px;">
					<i class="fa-solid fa-backward-step mr-6"></i>
				</span>
				<span id="pp" class="pp bppf" style="margin-left: 30px;">
					<a href="javascript:void(0);" class="play"><i class="fa-solid fa-play mr-6"></i></a>
					<a href="javascript:void(0);" class="pause"><i class="fa-solid fa-pause mr-6"></i></a>
				</span>
				<span id="forward" class="forward bppf" style="margin-left: 30px;">
					<i class="fa-solid fa-forward-step mr-6"></i>
				</span>
			</div>
			<div id="volume" class="volume col" style="margin-right: 80px;">
				<i class="fa-solid fa-volume-xmark h" id="vm" style="position: fixed; position: fixed; bottom: 32px; right: 220px;"></i>
				<i class="fa-solid fa-volume-off h" id="v0" style="position: fixed; position: fixed; bottom: 32px; right: 220px;"></i>
				<i class="fa-solid fa-volume-low h" id="v49" style="position: fixed; position: fixed; bottom: 32px; right: 220px;"></i>
				<i class="fa-solid fa-volume-high" id="v50" style="position: fixed; position: fixed; bottom: 32px; right: 220px;"></i>
				<input type="range" min="0" max="100" value="50" id="volumeBar" style="position: fixed; bottom: 40px; right: 110px;">
				<span id="currentVolume" class="currentVolume" style="position: fixed; bottom: 33px; right: 78px;"></span>
			</div>
		</div>
	</div>
	<script>
		// 우클릭 금지
	    document.addEventListener("contextmenu", function(e) {
	        e.preventDefault();
	    });
	
	    // 새로고침 금지
	    /* window.addEventListener("beforeunload", function(e) {
	        e.preventDefault();
	        e.returnValue = "";
	    }); */
	
		// 앨범 이미지 배경으로 사용
		var bgImage = document.getElementById('bgImage');
		var image = document.getElementById("image");
        var imageUrl = image.src;
		
		bgImage.style.backgroundImage = 'url(' + imageUrl + ')';

		
		// 음원 재생 / 일시정지
		var audio = document.getElementById("music");
		let isPlaying = true;
		audio.autoplay = true;

		$(function() {
			// 클릭 재생 / 일시정지
			$('.play').on('click', function(e) {
				e = e || window.event;
				var btn = e.target;
				audio.play();
				isPlaying = true;
				$('.pause').show();
				$('.play').hide();
			});
			$('.pause').on('click', function(e) {
				audio.pause();
				isPlaying = false;
				$('.play').show();
				$('.pause').hide();
			});
			
			// 스페이스바 재생 / 일시정지
			$(document).on('keypress', function(e) {
				if (e.which === 32) {
					e.preventDefault();
					if (isPlaying) {
						audio.pause();
						isPlaying = false;
						$('.play').show();
						$('.pause').hide();
					} else {
						audio.play();
						isPlaying = true;
						$('.pause').show();
						$('.play').hide();
					}
				}
			});
		});
		
		// 볼륨
		var volumeIcons = {
	        'vm': 'fa-volume-xmark', // 음소거
	        'v0': 'fa-volume-off', // 볼륨 0
	        'v49': 'fa-volume-low', // 볼륨 49 이하
	        'v50': 'fa-volume-high' // 볼륨 50 이상
	    };
	
	    var currentVolume = 50;
	    updateVolumeIcon();
	
	    // 음소거
	    $('.volume i').on('click', function() {
	        var volumeId = $(this).attr('id');
	        if (volumeId === 'v0' || volumeId === 'v49' || volumeId === 'v50') {
	            audio.muted = true;
	        } else {
	            audio.muted = false;
	        }
	        updateVolumeIcon();
	    });
	    
	    // 볼륨 값에 따라 아이콘 변경
	    function updateVolumeIcon() {
	        $('.volume i').hide();
	        if (audio.muted) {
	            $('#vm').show();
	        } else if (currentVolume <= 0) {
	            $('#v0').show();
	        } else if (currentVolume <= 49) {
	            $('#v49').show();
	        } else {
	            $('#v50').show();
	        }
	    }
	
	    // 볼륨 바
	    var volumeBar = document.getElementById("volumeBar");
	    volumeBar.addEventListener("input", function() {
	        var volumeLevel = parseInt(this.value);
	        setVolumeBar(volumeLevel);
	        setVolumeLevel(volumeLevel);
	    });
	
	    function setVolumeBar(volumeLevel) {
	        volumeBar.value = volumeLevel;
	    }
	
	    function setVolumeLevel(volumeLevel) {
	        audio.volume = volumeLevel / 100;
	        currentVolume = volumeLevel;
	        updateVolumeIcon();
	    }
	    
	 	// 볼륨 바 이벤트 처리
	    volumeBar.addEventListener("input", function() {
	        var volumeLevel = parseInt(this.value);
	        setVolumeBar(volumeLevel);
	        setVolumeLevel(volumeLevel);
	        updateCurrentVolume();
	    });
	    
	 	// 현재 음량 표시 업데이트
	    function updateCurrentVolume() {
	        var volume = audio.volume * 100;
	        document.getElementById('currentVolume').textContent = Math.floor(volume);
	    }
	    
	    // 초기 볼륨 값 50
	    setVolumeLevel(50);
	    updateCurrentVolume();
		
	 	// 음원 파일 재생 시간 폼
        function formatDuration(duration) {
            var minutes = Math.floor(duration / 60);
            var seconds = Math.floor(duration % 60);
    
            var formattedMinutes = String(minutes).padStart(2, '0');
            var formattedSeconds = String(seconds).padStart(2, '0');
    
            return formattedMinutes + ':' + formattedSeconds;
        }
        
     	// 음원 파일 재생 구간 표시
        audio.addEventListener('timeupdate', function() {
            var currentTime = audio.currentTime;
            var formattedCurrentTime = formatDuration(currentTime);

            var duration = audio.duration;
            var formattedDuration = formatDuration(duration);

            document.getElementById('formattedCurrentTime').textContent = formattedCurrentTime;
            document.getElementById('formattedDuration').textContent = formattedDuration;

            // 재생 바 위치 업데이트
            var progressBar = document.querySelector('.progressBar');
            var progressIndicator = document.querySelector('.progressIndicator');

            var progressWidth = (currentTime / duration) * 100 + '%';
            progressIndicator.style.width = progressWidth;

            // 재생 바 클릭 이벤트 처리
            progressBar.addEventListener('click', function(e) {
                var clickPosition = e.clientX - progressBar.getBoundingClientRect().left;
                var progressBarWidth = progressBar.offsetWidth;
                var seekTime = (clickPosition / progressBarWidth) * duration;
                audio.currentTime = seekTime;
                audio.play();
                $('.pause').show();
				$('.play').hide();
            });
        });
     	
        const REPEAT_MODES = {
            NO_REPEAT: 0,
            ALL_REPEAT: 1,
            SINGLE_REPEAT: 2,
        };

        let currentRepeatMode = REPEAT_MODES.NO_REPEAT;

        // 반복 아이콘 클릭 시 반복 모드 변경 및 동작 처리
        document.getElementById('repeat').addEventListener('click', function() {
            currentRepeatMode = (currentRepeatMode + 1) % 3;
            updateRepeatIcon();
            handleRepeatBehavior();
        });

        // 반복 아이콘을 현재 반복 모드에 맞게 업데이트
        function updateRepeatIcon() {
	    const repeatIcon = document.querySelector('#repeat i');
	    switch (currentRepeatMode) {
	        case REPEAT_MODES.NO_REPEAT:
	            repeatIcon.classList.remove('fa-rotate-right', 'fa-repeat', 'fa-rotate-180', 'white-icon');
	            repeatIcon.classList.add('fa-repeat', 'fa-rotate-180');
	            break;
	        case REPEAT_MODES.ALL_REPEAT:
	            repeatIcon.classList.remove('fa-rotate-right');
	            repeatIcon.classList.add('fa-repeat');
	            repeatIcon.classList.remove('fa-rotate-180');
	            repeatIcon.classList.add('white-icon');
	            break;
	        case REPEAT_MODES.SINGLE_REPEAT:
	            repeatIcon.classList.remove('fa-repeat', 'fa-rotate-180', 'white-icon');
	            repeatIcon.classList.add('fa-rotate-right');
	            break;
		    }
		}

        // 반복 모드에 따라 오디오 동작 처리
        function handleRepeatBehavior() {
            switch (currentRepeatMode) {
                case REPEAT_MODES.NO_REPEAT:
                    audio.loop = false;
                    break;
                case REPEAT_MODES.ALL_REPEAT:
                    audio.loop = true;
                    break;
                case REPEAT_MODES.SINGLE_REPEAT:
                    audio.loop = true;
                    break;
            }
        }
	</script>
</body>
</html>