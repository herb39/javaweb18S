package com.spring.javaweb18S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb18S.vo.MemberVO;
import com.spring.javaweb18S.vo.PlayListVO;
import com.spring.javaweb18S.vo.SongVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickNameCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public void setMemberPwdUpdate(String mid, String pwd);

	public MemberVO getMemberNameCheck(String name);

	public int setMemberUpdateOk(MultipartFile fName, MemberVO vo);

	public String getMemberIdFind(String name, String email);

	public void setMemberDeleteOk(String mid);

	public List<MemberVO> getMemberList(String mid);

	public PlayListVO getPlayListSearch(String content, int memberIdx);

	public void playListUpdate(PlayListVO vo);

	public void playListInput(PlayListVO vo);

	public int isPlayListExists(int memberIdx, String name);

	public void createPlayList(int memberIdx, String name);

	public List<PlayListVO> getPlayList(int memberIdx);

	public List<SongVO> getSongsByContentList(List<Integer> contentList);

	public PlayListVO getPlayListDetail(int idx);

	public ArrayList<SongVO> getPlayListSongDetail(ArrayList<Integer> songIdxes);

	public int setPlayListDelete(int idx);

	public void playListNameUpdate(int memberIdx, int idx, String name);

	public List<MemberVO> getMemberListT(String mid);


//	public void setPlayListSongDelete(List<Integer> idxList);





}
