package com.spring.javaweb18S.vo;

import lombok.Data;

@Data
public class ChartVO2 {

	public ChartVO2(String image, String title, String artist, String album, int ranking) {
		this.image = image;
		this.title = title;
		this.artist = artist;
		this.album = album;
		this.ranking = ranking;
	}
	
	private int idx;
	private int songIdx;
	private String image;
	private String title;
	private String artist;
	private String album;
	private int ranking;
	
	

}
