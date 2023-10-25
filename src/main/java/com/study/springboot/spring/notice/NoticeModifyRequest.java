package com.study.springboot.spring.notice;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.study.springboot.spring.dao.notice.NoticeDao;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
@Getter
@Setter
public class NoticeModifyRequest {

	@Autowired
	private NoticeDao noticeDao;
	


	
	public NoticeModifyRequest(int noNum,String title, String content, Integer impor) {
		this.noNum = noNum;
		this.title = title;
		this.content = content;
		if(impor==null) {
			impor=0;
			
		}
		this.impor = impor;
	}
	private int noNum;
	private String title;
	private String content;
	private Integer impor;

	public void validate(Map<String, Boolean> errors) {
		if (title == null || title.trim().isEmpty()) {
			errors.put("title", Boolean.TRUE);
		}
	}
	
}
