package com.spring.javaweb18S.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int idx;
	private String productCode;
	private String productName;
	private String detail;
	private int mainPrice;
	private String fSName;
	private String content;
	
	private String categoryArtistCode;
	private String categoryArtistName;
	private String categoryProductCode;
	private String categoryProductName;
}
