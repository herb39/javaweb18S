package com.spring.javaweb18S.vo;

import lombok.Data;

@Data
public class BoardReplyVO {
	private int idx;
	private int boardIdx;
	private String mid;
	private String nickName;
	private String wDate;
	private String hostIp;
	private String content;
}
