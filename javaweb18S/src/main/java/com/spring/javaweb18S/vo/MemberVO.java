package com.spring.javaweb18S.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String name;
	private String tel;
	private String email;
	private String image;
	private String userDel;
	private int level;
	private int membership;
	private String startDate;
	private String lastDate;
	private int todayCnt;
	
	private int deleteDiff;
	private String idSave;
}
