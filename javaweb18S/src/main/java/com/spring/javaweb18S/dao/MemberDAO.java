package com.spring.javaweb18S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb18S.vo.MemberVO;
import com.spring.javaweb18S.vo.PlayListVO;
import com.spring.javaweb18S.vo.SongVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickNameCheck(@Param("nickName") String nickName);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public void setMemberVisitProcess(@Param("vo") MemberVO vo);

	public void setMemberPwdUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public MemberVO getMemberNameCheck(@Param("name") String name);

	public void setMemberUpdateOk(@Param("vo") MemberVO vo);

	public String getMemberIdFind(@Param("name") String name, @Param("email") String email);

	public void setMemberDeleteOk(@Param("mid") String mid);

	public List<MemberVO> getMemberList(@Param("mid") String mid);

	public PlayListVO getPlayListSearch(@Param("content") String content, @Param("memberIdx") int memberIdx);

	public void playListUpdate(@Param("vo") PlayListVO vo);

	public void playListInput(@Param("vo") PlayListVO vo);

	public int isPlayListExists(@Param("memberIdx") int memberIdx, @Param("name") String name);

	public void createPlayList(@Param("memberIdx") int memberIdx, @Param("name") String name);

	public List<PlayListVO> getPlayList(@Param("memberIdx") int memberIdx);

	public List<SongVO> getSongsByContentList(@Param("contentList") List<Integer> contentList);

	public PlayListVO getPlayListDetail(@Param("idx") int idx);

	public ArrayList<SongVO> getPlayListSongDetail(@Param("songIdxes") ArrayList<Integer> songIdxes);

	public int setPlayListDelete(@Param("idx") int idx);

	public void playListNameUpdate(@Param("memberIdx") int memberIdx, @Param("idx") int idx, @Param("name") String name);

	public List<MemberVO> getMemberListT(@Param("mid") String mid);

//	public void setPlayListSongDelete(@Param("idxList") List<Integer> idxList);




}
