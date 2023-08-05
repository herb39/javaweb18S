package com.spring.javaweb18S.vo;

import java.util.List;

import lombok.Data;

@Data
public class PlayListVO {
	private int idx;
	private int memberIdx;
	private String name;
	private String content;
	
	private List<Integer> contentList;
	private List<SongVO> songs;
}
