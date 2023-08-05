package com.spring.javaweb18S.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb18S.common.JavawebProvide;
import com.spring.javaweb18S.dao.MemberDAO;
import com.spring.javaweb18S.vo.MemberVO;
import com.spring.javaweb18S.vo.PlayListVO;
import com.spring.javaweb18S.vo.SongVO;

@Service
public class MemberServieImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickNameCheck(String nickName) {
		return memberDAO.getMemberNickNameCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		int res = 0;
		memberDAO.setMemberJoinOk(vo);
		
		res = 1;

		return res;
	}

	@Override
	public void setMemberVisitProcess(MemberVO vo) {
		memberDAO.setMemberVisitProcess(vo);
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid, pwd);
	}

	@Override
	public MemberVO getMemberNameCheck(String name) {
		return memberDAO.getMemberNameCheck(name);
	}

	@Override
	public int setMemberUpdateOk(MultipartFile fName, MemberVO vo) {
		int res = 0;
		try {
			String oFileName = fName.getOriginalFilename();
			if (oFileName.equals("")) {
				UUID uuid = UUID.randomUUID();
				String saveFileName = uuid + "_" + oFileName;

				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(fName, saveFileName, "member");

				// 기존에 있던 파일 삭제
				if (!vo.getImage().equals("noimage.jsp")) {
					HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
					String realPath = request.getSession().getServletContext().getRealPath("/resources/data/member/");
					File file = new File(realPath + vo.getImage());
					file.delete();
				}
				// 기존에 존재하는 파일 삭제 후 새로 업로드 한 파일명 set
				vo.setImage(saveFileName);
			}
			memberDAO.setMemberUpdateOk(vo);

			res =1;
		} catch (IOException e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public String getMemberIdFind(String name, String email) {
		return memberDAO.getMemberIdFind(name, email);
	}

	@Override
	public void setMemberDeleteOk(String mid) {
		memberDAO.setMemberDeleteOk(mid);
	}

	@Override
	public List<MemberVO> getMemberList(String mid) {
		return memberDAO.getMemberList(mid);
	}

	@Override
	public PlayListVO getPlayListSearch(String content, int memberIdx) {
		return memberDAO.getPlayListSearch(content, memberIdx);
	}

	@Override
	public void playListUpdate(PlayListVO vo) {
		memberDAO.playListUpdate(vo);
	}

	@Override
	public void playListInput(PlayListVO vo) {
		memberDAO.playListInput(vo);
	}

	@Override
	public int isPlayListExists(int memberIdx, String name) {
		return memberDAO.isPlayListExists(memberIdx, name);
	}

	@Override
	public void createPlayList(int memberIdx, String name) {
		memberDAO.createPlayList(memberIdx, name);
	}

//	@Override
//	public List<PlayListVO> getPlayList(int memberIdx) {
//		return memberDAO.getPlayList(memberIdx);
//	}
	
	@Override
	public List<PlayListVO> getPlayList(int memberIdx) {
        List<PlayListVO> playListVOS = memberDAO.getPlayList(memberIdx);
        
        // content 컬럼의 값을 가져와서 쉼표로 분리하여 contentList에 저장
        for (PlayListVO playListVO : playListVOS) {
            String content = playListVO.getContent();
            if (content != null && !content.isEmpty()) {
                List<Integer> contentList = Arrays.stream(content.split(","))
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
                playListVO.setContentList(contentList);
            }
        }
        
        return playListVOS;
    }

	@Override
	public List<SongVO> getSongsByContentList(List<Integer> contentList) {
		return memberDAO.getSongsByContentList(contentList);
	}

	@Override
	public PlayListVO getPlayListDetail(int idx) {
		return memberDAO.getPlayListDetail(idx);
	}

	@Override
	public ArrayList<SongVO> getPlayListSongDetail(ArrayList<Integer> songIdxes) {
		return memberDAO.getPlayListSongDetail(songIdxes);
	}

	@Override
	public int setPlayListDelete(int idx) {
		return memberDAO.setPlayListDelete(idx);
	}

	@Override
	public void playListNameUpdate(int memberIdx, int idx, String name) {
		memberDAO.playListNameUpdate(memberIdx, idx, name);
	}

	@Override
	public List<MemberVO> getMemberListT(String mid) {
		return memberDAO.getMemberListT(mid);
	}


//	@Override
//	public void setPlayListSongDelete(List<Integer> idxList) {
//		memberDAO.setPlayListSongDelete(idxList);
//	}

	





}
