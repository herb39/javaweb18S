package com.spring.javaweb18S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.spring.javaweb18S.service.BoardService;
import com.spring.javaweb18S.vo.BoardReplyVO;
import com.spring.javaweb18S.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", "", "");
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {

		// content안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res = boardService.setBoardInput(vo);
		
		if(res == 1) return "redirect:/message/boardInputOk";
		else return "redirect:/message/boardInputNo";
	}
	
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		// ckeditor에서 올린(전송)한 파일을 서버 파일시스템에 실제로 저장처리시켜준다.
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(bytes);
		
		// 서버 파일시스템에 저장되어 있는 그림파일을 브라우저 편집화면(textarea)에 보여주는 처리
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();		
		fos.close();
	}

	// 글내용 상세보기
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(HttpSession session,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 이전글/다음글 가져오기
		ArrayList<BoardVO> pnVos = boardService.getPrevNext(idx);
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		// 댓글 가져오기(replyVOS)
		List<BoardReplyVO> replyVOS = boardService.setBoardReply(idx);
		model.addAttribute("replyVOS", replyVOS);
		
		return "board/boardContent";
	}
	
	// 게시글 검색처리
	@RequestMapping(value = "/boardSearch", method = RequestMethod.GET)
	public String boardSearchGet(String search, String searchString,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {		// search = search+"/"+searchString
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", search, searchString);
		
		List<BoardVO> vos = boardService.getBoardListSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);
		
		String searchTitle = "";
		if(pageVO.getSearch().equals("title")) searchTitle = "글제목";
		else if(pageVO.getSearch().equals("nickName")) searchTitle = "글쓴이";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		
		return "board/boardSearch";
	}
	
	// 게시글 삭제하기
	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(HttpSession session, HttpServletRequest request,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			@RequestParam(name="nickName", defaultValue = "", required=false) String nickName
			) {
		
		// DB에서 실제로 존재하는 게시글을 삭제처리한다.
		int res = boardService.setBoardDelete(idx);
		
		if(res == 1) return "redirect:/message/boardDeleteOk";
		else return "redirect:/message/boardDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	
	// 게시글 수정하기 폼
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize
		) {

		BoardVO vo = boardService.getBoardContent(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "board/boardUpdate";
	}
	
	// 게시글 수정
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(BoardVO vo,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {

		int res = boardService.setBoardUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		if(res == 1) {
			return "redirect:/message/boardUpdateOk";
		}
		else {
			return "redirect:/message/boardUpdateNo";
		}
	}
	
	// 댓글 작성
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVO replyVO) {
		
		boardService.setBoardReplyInput(replyVO);
		
		return "1";
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/boardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(
			@RequestParam(name = "replyIdx", defaultValue = "0", required = false) int replyIdx) {
		BoardReplyVO replyVO = boardService.getBoardReplyIdx(replyIdx);
		boardService.setBoardReplyDelete(replyVO.getIdx(), replyVO.getBoardIdx());
		
		return "1";
	}
	
	// 댓글 수정
	@ResponseBody
	@RequestMapping(value = "/boardReplyUpdate", method = RequestMethod.POST)
	public String boardReplyUpdatePost(
			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name = "content", defaultValue = "", required = false) String content,
		  @RequestParam(name = "hostIp", defaultValue = "", required = false) String hostIp) {
		boardService.setBoardReplyUpdate(idx, content, hostIp);
		
		return "1";
	}
	
}
