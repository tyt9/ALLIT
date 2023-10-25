package com.study.springboot.spring.notice;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter

public class NoticeDeleteRequest {

	public NoticeDeleteRequest(String userId, int no) {
		this.userId = userId;
		this.noNum =noNum;
	}
	private int noNum;
	private String userId;

}


