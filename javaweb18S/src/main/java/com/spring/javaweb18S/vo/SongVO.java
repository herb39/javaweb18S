package com.spring.javaweb18S.vo;

import lombok.Data;

@Data
public class SongVO {
	
	public SongVO() {}
	
	public SongVO(String image, String title, String artist, String album, String releaseDate, String genre, String lyrics) {
		this.image = image;
		this.title = title;
		this.artist = artist;
		this.album = album;
		this.releaseDate = releaseDate;
		this.genre = genre;
		this.lyrics = lyrics;
	}
	
	private int idx;
	private String image;
	private String title;
	private String artist;
	private String album;
	private String music;
	private String releaseDate;
	private String genre;
	private String lyrics;
	
	
}
