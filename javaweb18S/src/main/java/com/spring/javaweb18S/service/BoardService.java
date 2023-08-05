package com.spring.javaweb18S.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaweb18S.vo.BoardReplyVO;
import com.spring.javaweb18S.vo.BoardVO;

public interface BoardService {

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize);

	public int setBoardInput(BoardVO vo);

	public BoardVO getBoardContent(int idx);

	public ArrayList<BoardVO> getPrevNext(int idx);

	public List<BoardVO> getBoardListSearch(int startIndexNo, int pageSize, String search, String searchString);

	public int setBoardDelete(int idx);

	public int setBoardUpdate(BoardVO vo);

	public void setBoardReplyInput(BoardReplyVO replyVO);

	public List<BoardReplyVO> setBoardReply(int idx);

	public void setBoardReplyDelete(int idx, int boardIdx);

	public BoardReplyVO getBoardReplyIdx(int replyIdx);

	public void setBoardReplyUpdate(int idx, String content, String hostIp);

}
