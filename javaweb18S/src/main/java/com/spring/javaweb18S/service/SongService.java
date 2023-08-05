package com.spring.javaweb18S.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb18S.vo.ChartVO;
import com.spring.javaweb18S.vo.PlayListVO;
import com.spring.javaweb18S.vo.SongVO;

public interface SongService {

	public List<ChartVO> getChart();

	public void setChartUpdate();

	public SongVO getSongInfo(int idx);

	public List<PlayListVO> getPlayListIdx(int idx);

	public List<SongVO> getSongList();

	public int setSongInfoAdminInsert(MultipartFile fName, SongVO vo);

	public int setSongInfoUpdate(MultipartFile fName, SongVO vo);

	public int setSongDelete(int idx);

	public List<SongVO> getSongInfoSearch(String search, String searchString);

	public List<ChartVO> getSongSearch(String search, String searchString);

	public List<SongVO> getSongListT();


}
