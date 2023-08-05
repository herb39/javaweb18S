package com.spring.javaweb18S.vo;

import lombok.Data;

@Data
public class OptionVO {
	private int idx;
	private int productIdx;
	private String optionName;
	private int optionPrice;
	
	private String productName;
}
