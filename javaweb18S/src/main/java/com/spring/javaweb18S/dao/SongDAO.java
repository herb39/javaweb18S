package com.spring.javaweb18S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb18S.vo.ChartVO;
import com.spring.javaweb18S.vo.ChartVO2;
import com.spring.javaweb18S.vo.PlayListVO;
import com.spring.javaweb18S.vo.ProductVO;
import com.spring.javaweb18S.vo.SongVO;

public interface SongDAO {

	public void setChartUpdate(@Param("vo") ChartVO2 vo);
	
	public List<SongVO> getSongList();

	public SongVO getSongTitle(@Param("title") String title);

	public void setSongInfoInsert(@Param("vo") SongVO songVO);
	
	public SongVO getSongInfo(@Param("idx") int idx);

	public List<ChartVO> getChart();

	public List<PlayListVO> getPlayListIdx(@Param("idx") int idx);

	public int setSongInfoAdminInsert(@Param("vo") SongVO vo);

	public void setSongInfoUpdate(@Param("vo") SongVO vo);

	public int setSongDelete(@Param("idx") int idx);

	public List<SongVO> getSongInfoSearch(@Param("search") String search, @Param("searchString") String searchString);

	public List<ChartVO> getSongSearch(@Param("search") String search, @Param("searchString") String searchString);

	public void setMatchingSong();

	public List<SongVO> getSongListT();


}
