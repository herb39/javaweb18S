package com.spring.javaweb18S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb18S.dao.BoardDAO;
import com.spring.javaweb18S.vo.BoardReplyVO;
import com.spring.javaweb18S.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		return boardDAO.getBoardList(startIndexNo, pageSize);
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public ArrayList<BoardVO> getPrevNext(int idx) {
		return boardDAO.getPrevNext(idx);
	}

	@Override
	public List<BoardVO> getBoardListSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return boardDAO.getBoardListSearch(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public int setBoardDelete(int idx) {
		return boardDAO.setBoardDelete(idx);
	}

	@Override
	public int setBoardUpdate(BoardVO vo) {
		return boardDAO.setBoardUpdate(vo);
	}

	@Override
	public void setBoardReplyInput(BoardReplyVO replyVO) {
		boardDAO.setBoardReplyInput(replyVO);
	}

	@Override
	public List<BoardReplyVO> setBoardReply(int idx) {
		return boardDAO.setBoardReply(idx);
	}

	@Override
	public void setBoardReplyDelete(int idx, int boardIdx) {
		boardDAO.setBoardReplyDelete(idx, boardIdx);
	}

	@Override
	public BoardReplyVO getBoardReplyIdx(int replyIdx) {
		return boardDAO.getBoardReplyIdx(replyIdx);
	}

	@Override
	public void setBoardReplyUpdate(int idx, String content, String hostIp) {
		boardDAO.setBoardReplyUpdate(idx, content, hostIp);
	}

}
