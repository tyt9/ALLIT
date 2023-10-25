package com.study.springboot.spring.notice;



import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class NoticeData {

	
	public NoticeData(Notice notice) {
		this.notice = notice;
	}

	private Notice notice;
} 
