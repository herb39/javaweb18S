package com.spring.javaweb18S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.taglibs.standard.tag.rt.fmt.ParseDateTag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb18S.pagination.PageProcess;
import com.spring.javaweb18S.pagination.PageVO;
import com.spring.javaweb18S.service.MemberService;
import com.spring.javaweb18S.vo.MemberVO;
import com.spring.javaweb18S.vo.PlayListVO;
import com.spring.javaweb18S.vo.SongVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	HttpSession session;

	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}

	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(name = "pwd", defaultValue = "", required = false) String pwd,
			@RequestParam(name = "idSave", defaultValue = "", required = false) String idSave,
			HttpSession session) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if (vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 회원 인증 성공 ? strLevel, session 저장, 쿠키 저장, ... 등

			session.setAttribute("sIdx", vo.getIdx());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName", vo.getNickName());

			Cookie cookie = new Cookie("cMid", mid);
			if (idSave.equals("on")) {
				cookie.setPath("/");
				cookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookie);
			} else {
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			
			return "redirect:/message/memberLoginOk?mid="+mid;
		} else {
			return "redirect:/message/memberLoginNo";
		}
	}

	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");

		session.invalidate();

		return "redirect:/message/memberLogout?mid="+mid;
	}

	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}

	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		// 아이디 중복 체크
		if (memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/idCheckNo";
		// 닉네임 중복 체크
		if (memberService.getMemberNickNameCheck(vo.getNickName()) != null) return "redirect:/message/nickNameCheckNo";

		// 비밀번호 암호화(Spring Security 사용)
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));

		// 체크 완료 ? vo에 담긴 자료 -> DB에 저장 (회원가입)
		int res = memberService.setMemberJoinOk(vo);

		if (res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}

	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if (vo != null) return "1";
		else return "0";
	}

	// 닉네임 중복 체크
	@ResponseBody
	@RequestMapping(value = "/memberNickNameCheck", method = RequestMethod.POST)
	public String memberNickNameCheckPost(String nickName) {
		MemberVO vo = memberService.getMemberNickNameCheck(nickName);
		if (vo != null) return "1";
		else return "0";
	}

	// 비밀번호 찾기
	@RequestMapping(value = "/memberPwdFind", method = RequestMethod.GET)
	public String memberPwdFindGet() {
		return "member/memberPwdFind";
	}

	@RequestMapping(value = "/memberPwdFind", method = RequestMethod.POST)
	public String memberPwdFindPost(String mid, String email, HttpServletRequest request) throws MessagingException {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if (vo != null) {
			if (vo.getEmail().equals(email)) {
				// 회원정보가 맞다면 임시비밀번호 발급 (8자리)
				UUID uuid = UUID.randomUUID();
				String pwd = uuid.toString().substring(0, 8);

				// 회원이 임시비밀번호를 변경할 수 있도록 유도하기 위해 임시 세션 생성
				HttpSession session = request.getSession();
				session.setAttribute("sImsiPwd", "ok");

				// 발급받은 임시비밀번호를 암호화 후 DB에 저장
				memberService.setMemberPwdUpdate(mid, passwordEncoder.encode(pwd));

				// 저장된 임시비밀번호를 메일로 전송
				String content = pwd;
				int res = mailSend(email, content);

				if (res == 1) {
					return "redirect:/message/memberImsiPwdOk";
				} else {
					return "redirect:/message/memberImsiPwdNo";
				}
			} else {
				return "redirect:/message/memberEmailCheckNo";
			}
		} else {
			return "redirect:/message/memberIdCheckNo";
		}
	}
	
	// 임시비밀번호를 메일로 전송
	private int mailSend(String email, String content) throws MessagingException {
		String title = "임시 비밀번호가 발급되었습니다.";
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

		// 메일 보관함에 (받는 사람, 제목, 내용) 저장한 후 처리
		messageHelper.setTo(email.split(";"));
		messageHelper.setSubject(title);

		// 메시지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
		content += "<br><hr><h3>임시비밀번호 : <font color='red'>"+content+"</font></h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
//		content += "<p><a href='http://49.142.157.251:9090/javaweb18J/Main'>Hello World 프로젝트</a></p>";
		content += "<p><a href='http://localhost:9090/javaweb18S/'><b>9 1 3</b></a></p>";
		content += "<hr>";
		// 보관함에 내용 담기
		messageHelper.setText(content, true);

		// 본문에 기재된 그림파일의 경로를 별도로 표시한 후 다시 보관함에 담기
		FileSystemResource file = new FileSystemResource("/Users/herb/Documents/workspace-sts-3.9.18.RELEASE/javawebS/src/main/webapp/resources/images/main.jpg");
		messageHelper.addInline("main.jpg", file);

		// 메일 전송
		mailSender.send(message);

		return 1;
	}

	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.GET)
	public String memberPwdUpdateGet() {
		return "member/memberPwdUpdate";
	}

	// 비밀번호 변경
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.POST)
	public String memberPwdUpdatePost(
				@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
				@RequestParam(name = "newPwd", defaultValue = "", required = false) String newPwd,
				HttpSession session
			) {
		newPwd = passwordEncoder.encode(newPwd);
		
		memberService.setMemberPwdUpdate(mid, newPwd);
		
		if (session.getAttribute("sImsiPwd") != null) session.removeAttribute("sImsiPwd");

		return "redirect:/message/memberPwdUpdateOk";
	}

	// 아이디 찾기 폼
	@RequestMapping(value = "/memberIdFind", method = RequestMethod.GET)
	public String memberIdFindGet() {
		return "member/memberIdFind";
	}
	
	// 아이디 찾기
	@ResponseBody
	@RequestMapping(value = "/memberIdFind", method = RequestMethod.POST)
	public String memberIdFindPost(String name, String email, Model model) {
		String mid = memberService.getMemberIdFind(name, email) == null ? "" : memberService.getMemberIdFind(name, email);
		
		model.addAttribute("name", name);
		model.addAttribute("email", email);
		
		if (mid.equals("")) {
			mid = "0";
		} else {
			int maskLength = mid.length() - 2; // 마스킹
			String maskedMid = mid.substring(0, maskLength) + maskStar(maskLength);
			return maskedMid;
		}
		return mid;
	}

	// 마스킹 문자 만들기
	private String maskStar(int maskLength) {
		StringBuilder maskBuilder = new StringBuilder();
		for (int i = 0; i < maskLength; i++) {
			maskBuilder.append("*");
		}
		return maskBuilder.toString();
	}
	
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.GET)
	public String memberPwdCheckGet() {
		return "member/memberPwdCheck";
	}

	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(String mid, String pwd, Model model) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if (vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			model.addAttribute("vo", vo);
			return "member/memberUpdate";
		} else {
			return "redirect:/message/memberPwdCheckNo";
		}
	}

	// 회원 탈퇴
	@RequestMapping(value = "memberDelete", method = RequestMethod.GET)
	public String memberDelete(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		memberService.setMemberDeleteOk(mid);
		
		session.invalidate();
		
		model.addAttribute("mid", mid);
		
		return "redirect:/message/memberDeleteOk";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);

		return "member/memberUpdateOk";
	}

	@RequestMapping(value = "/memberUpdateOk", method = RequestMethod.POST)
	public String memberUpdateOkPost(MemberVO vo, MultipartFile fName, HttpSession session) {
		// 닉네임 체크
		String nickName = (String) session.getAttribute("sNickName");
		if (memberService.getMemberNickNameCheck(vo.getNickName()) != null && !nickName.equals(vo.getNickName())) {
			return "redirect:/message/memberNickCheckNo";
		}

		int res = memberService.setMemberUpdateOk(fName, vo);

		if (res == 1) {
			session.setAttribute("sNickName", vo.getNickName());
			return "redirect:/message/memberUpdateOk";
		} else {
			return "redirect:/message/memberUpdateNo";
		}
	}

	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid
//			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//			@RequestParam(name="pageSize", defaultValue = "3", required = false) int pageSize
			) {
		
//		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "member", "", mid);
//		PageVO pageVO = pageProcess.sis("", mid);
		
		List<MemberVO> vos = memberService.getMemberList(mid);
		
		model.addAttribute("vos", vos);
//		model.addAttribute("pageVO", pageVO);
		model.addAttribute("mid", mid);
		
		return "member/memberList";
	}
	
	// 전체 플레이리스트 보여주기
	@RequestMapping(value = "/playList", method = RequestMethod.GET)
	public String playListGet(Model model, PlayListVO vo, HttpSession session) {
		int memberIdx = (int) session.getAttribute("sIdx");
		
		List<PlayListVO> playListVOS = memberService.getPlayList(memberIdx);
		
		model.addAttribute("playListVOS", playListVOS);
		
		return "member/playList";
	}
	
	// 플레이리스트 세부내용 보여주기
	@RequestMapping(value = "/playListDetail", method = RequestMethod.GET)
	public String playListDetailGet(Model model, @RequestParam("idx") int idx) {
		PlayListVO playListVO = memberService.getPlayListDetail(idx);
		model.addAttribute("playListVO", playListVO);
		
		if(playListVO.getContent() != "") {
			ArrayList<Integer> songIdxes = new ArrayList<Integer>();
			String[] temp = playListVO.getContent().split(",");
			
			for(int i=0; i<temp.length; i++) {
				songIdxes.add(Integer.parseInt(temp[i]));
			}
			ArrayList<SongVO> songVOS = memberService.getPlayListSongDetail(songIdxes);
			model.addAttribute("songVOS", songVOS);
		}

	    return "member/playListDetail";
	}
	
	// 플레이리스트에 곡 추가
//	@RequestMapping(value = "/playList", method = RequestMethod.POST)
//	public String playListPost(HttpSession session,
//			@RequestParam("content") String content
//			) {
//	    
//	    int memberIdx = (int) session.getAttribute("sIdx");
//	    
//	    PlayListVO resVO = memberService.getPlayListSearch(content, memberIdx);
//	    if (resVO != null) {
//	        // 기존 플레이리스트가 존재하는 경우, 선택한 곡들의 인덱스를 추가
//	        String[] voContentNums = content.split(",");
//	        String[] resContentNums = resVO.getContent().split(",");
//	        int[] nums = new int[99];
//	        String strNums = "";
//	        for (int i = 0; i < voContentNums.length; i++) {
//	            nums[i] += (Integer.parseInt(voContentNums[i]) + Integer.parseInt(resContentNums[i]));
//	            strNums += nums[i];
//	            if (i < nums.length - 1) {
//	                strNums += ",";
//	            }
//	        }
//	        resVO.setContent(strNums);
//	        memberService.playListUpdate(resVO);
//	    } else {
//	        // 새로운 플레이리스트에 곡 추가
//	        PlayListVO newVO = new PlayListVO();
//	        newVO.setMemberIdx(memberIdx);
//	        newVO.setContent(content);
//	        memberService.playListInput(newVO);
//	    }
//
//	    return "member/playList";
//	}

    @ResponseBody
    @RequestMapping(value = "/createPlayList", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String createPlayList(
    		@RequestParam("memberIdx") int memberIdx, 
    		@RequestParam("name") String name) {
    	
    	int isPlayListExists = memberService.isPlayListExists(memberIdx, name);
        
        if (isPlayListExists == 1) {
            return "이미 동일한 이름의 플레이리스트가 존재합니다.";
        } else {
            PlayListVO newPlayList = new PlayListVO();
            newPlayList.setMemberIdx(memberIdx);
            newPlayList.setName(name);
            
            memberService.createPlayList(newPlayList.getMemberIdx(), newPlayList.getName());
            
            return "플레이리스트가 성공적으로 생성되었습니다.";
        }
    }
    
    @ResponseBody
    @RequestMapping(value = "/playListNameUpdate", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String playListNameUpdatePost(
    		@RequestParam("memberIdx") int memberIdx, 
    		@RequestParam("idx") int idx, 
    		@RequestParam("name") String name) {
    	
    	int isPlayListExists = memberService.isPlayListExists(memberIdx, name);
    	
    	if (isPlayListExists == 1) {
    		return "이미 동일한 이름의 플레이리스트가 존재합니다.";
    	} else {
    		PlayListVO playListVO = new PlayListVO();
    		playListVO.setMemberIdx(memberIdx);
    		playListVO.setIdx(idx);
    		playListVO.setName(name);
    		
    		memberService.playListNameUpdate(playListVO.getMemberIdx(), playListVO.getIdx(), playListVO.getName());
    		
    		return "플레이리스트가 성공적으로 생성되었습니다.";
    	}
    }
    
    // 플레이리스트 삭제
 	@RequestMapping(value = "/playListDelete", method = RequestMethod.GET)
 	public String playListDeleteGet(HttpSession session, HttpServletRequest request,
 			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx
 			) {
 		
 		int res = memberService.setPlayListDelete(idx);
 		
 		if(res == 1) return "redirect:/message/playListDeleteOk";
 		else return "redirect:/message/playListDeleteNo?idx="+idx;
 	}
 	
    // 플레이리스트에서 곡 삭제(업데이트)
// 	@ResponseBody
// 	@RequestMapping(value = "/playListSongDelete", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
// 	public String playListSongDeletePost(@RequestParam("idxList") List<Integer> idxList) {
// 	    memberService.setPlayListSongDelete(idxList);
// 	    return "";
// 	}
	
    
	
	
	
}
