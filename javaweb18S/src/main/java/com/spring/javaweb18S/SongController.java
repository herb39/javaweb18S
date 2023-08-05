package com.spring.javaweb18S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.spring.javaweb18S.service.SongService;
import com.spring.javaweb18S.vo.ChartVO;
import com.spring.javaweb18S.vo.PlayListVO;
import com.spring.javaweb18S.vo.SongVO;

@Controller
@RequestMapping("/song")
public class SongController {

	@Autowired
	SongService songService;

	@Autowired
	MemberService memberService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public String chartGet(Model model, HttpSession session) {

//		int idx = (int) session.getAttribute("sIdx");
		
		List<ChartVO> vos = songService.getChart();
//		List<PlayListVO> playListVOS = songService.getPlayListIdx(idx);
		
		model.addAttribute("vos", vos);
//		model.addAttribute("playListVOS", playListVOS);
		
		return "song/chart";
	}
	
	// 플레이어
	@RequestMapping(value = "/player", method = RequestMethod.GET)
	public String playerGet(Model model,
			@RequestParam(name ="songIdx", defaultValue = "", required = false) int idx) {
		
		SongVO songVO = songService.getSongInfo(idx);
		model.addAttribute("songVO", songVO);
		
		return "song/player";
	}
	
	// 곡 상세정보 등록 페이지 (관리자)
	@RequestMapping(value = "/songInfoInsert", method = RequestMethod.GET)
	public String songInfoInsertGet(
//			@RequestParam(name ="songIdx", defaultValue = "", required = false) int idx, 
			Model model) {
//		SongVO songVO = songService.getSongInfo(idx);
//		
//		model.addAttribute("songVO", songVO);
		
		return "admin/song/songInfoInsert";
	}
	
	// 곡 상세정보 등록 (관리자)
	@RequestMapping(value = "/songInfoInsert", method = RequestMethod.POST)
	public String songInfoInsertPost(MultipartFile fName, SongVO vo) {
		
		int res = songService.setSongInfoAdminInsert(fName, vo);
		
		if(res == 1) return "redirect:/message/songInfoInsertOk";
		else return "redirect:/message/songInfoInsertNo";
	}
	
	// 곡 상세정보 페이지 (사용자)
	@RequestMapping(value = "/songInfo", method = RequestMethod.GET)
	public String songInfoGet(@RequestParam(name ="songIdx", defaultValue = "", required = false) int idx, 
			Model model) {
		SongVO songVO = songService.getSongInfo(idx);
		
		model.addAttribute("songVO", songVO);
		
		return "song/songInfo";
	}
	
	@RequestMapping(value = "/songInfoUpdate", method = RequestMethod.GET)
	public String songInfoUpdateGet(Model model) {

		List<SongVO> songVOS = songService.getSongList();
		
		model.addAttribute("songVOS", songVOS);
		
		return "admin/song/songInfoUpdate";
	}
	
	// 음원 정보 수정 페이지 (관리자)
	@RequestMapping(value = "/songInfoUpdateForm", method = RequestMethod.GET)
	public String songInfoUpdateFormGet(@RequestParam(name ="idx", defaultValue = "", required = false) int idx,
			Model model) {
		
		SongVO songVO = songService.getSongInfo(idx);
		
		model.addAttribute("songVO", songVO);
		
		return "admin/song/songInfoUpdateForm";
	}
	
	// 곡 상세정보 수정 (관리자)
	@RequestMapping(value = "/songInfoUpdateForm", method = RequestMethod.POST)
	public String songInfoUpdateFormPost(MultipartFile fName, SongVO vo) {
		
//		System.out.println("vo : " + vo);
		
		int res = songService.setSongInfoUpdate(fName, vo);
		
		if(res != 0) return "redirect:/message/songInfoUpdateOk";
		else return "redirect:/message/songInfoUpdateNo";
	}
	
	// 음원 정보 삭제 (관리자)
	@ResponseBody
 	@RequestMapping(value = "/songDelete", method = RequestMethod.POST)
 	public String songDeletePost(
 			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx) {
 		
 		SongVO songVO = songService.getSongInfo(idx);
		songService.setSongDelete(songVO.getIdx());
		
		return "admin/song/songInfoUpdate";
 	}
	
	// 음원 정보 검색 (관리자)
	@RequestMapping(value = "/songInfoSearch", method = RequestMethod.GET)
	public String songInfoSearchGet(Model model,
			String search, String searchString) {
		PageVO pageVO = pageProcess.sis(search, searchString);			
		
		List<SongVO> vos = songService.getSongInfoSearch(search, searchString);
		
		String searchTitle = "";
		if(pageVO.getSearch().equals("title")) searchTitle = "곡제목";
		else if(pageVO.getSearch().equals("artist")) searchTitle = "아티스트";
		else if(pageVO.getSearch().equals("album")) searchTitle = "앨범";
		else if(pageVO.getSearch().equals("genre")) searchTitle = "장르";
		else searchTitle = "가사";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		
		return "admin/song/songInfoSearch";
	}
	
	// 음원 정보 검색 (사용자)
	@RequestMapping(value = "/songSearch", method = RequestMethod.GET)
	public String songSearchGet(Model model, HttpSession session,
			String search, String searchString) {
		PageVO pageVO = pageProcess.sis(search, searchString);			
		
//		List<ChartVO> vos = songService.getSongSearch(search, searchString);
		List<SongVO> vos = songService.getSongInfoSearch(search, searchString);

		String searchTitle = "";
		if(pageVO.getSearch().equals("title")) searchTitle = "곡제목";
		else if(pageVO.getSearch().equals("artist")) searchTitle = "아티스트";
		else if(pageVO.getSearch().equals("album")) searchTitle = "앨범";
		else if(pageVO.getSearch().equals("genre")) searchTitle = "장르";
		else searchTitle = "가사";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		
		int idx = (int) session.getAttribute("sIdx");
		
		List<ChartVO> chartVOS = songService.getChart();
		List<PlayListVO> playListVOS = songService.getPlayListIdx(idx);
		
		
		model.addAttribute("chartVOS", chartVOS);
		model.addAttribute("playListVOS", playListVOS);
		
		return "song/songSearch";
	}
	
	
	
	
}
