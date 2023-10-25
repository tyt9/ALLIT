package com.study.springboot.spring.notice;



import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class WriteRequest {


	private String title;
	private String content;
	private Integer impor;
	public WriteRequest(String title, String content, Integer impor) {
	
		this.title = title;
		this.content = content;
		if(impor==null) {
			impor=0;
			
		}
		this.impor = impor;
	}
	
	public void validate(Map<String, Boolean> errors) {
		if (title == null || title.trim().isEmpty()) {
			errors.put("title", Boolean.TRUE);
		}
	}
	
	
	
}
