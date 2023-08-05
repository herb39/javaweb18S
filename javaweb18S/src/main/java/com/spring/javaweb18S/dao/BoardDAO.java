package com.spring.javaweb18S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb18S.vo.BoardReplyVO;
import com.spring.javaweb18S.vo.BoardVO;

public interface BoardDAO {

	public int totRecCnt();

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setBoardInput(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public ArrayList<BoardVO> getPrevNext(@Param("idx") int idx);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public List<BoardVO> getBoardListSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int setBoardDelete(@Param("idx") int idx);

	public int setBoardUpdate(@Param("vo") BoardVO vo);

	public void setBoardReplyInput(@Param("replyVO") BoardReplyVO replyVO);

	public List<BoardReplyVO> setBoardReply(@Param("idx") int idx);

	public void setBoardReplyDelete(@Param("idx") int idx, @Param("boardIdx") int boardIdx);

	public BoardReplyVO getBoardReplyIdx(@Param("replyIdx") int replyIdx);

	public void setBoardReplyUpdate(@Param("idx") int idx, @Param("content") String content, @Param("hostIp") String hostIp);

}
