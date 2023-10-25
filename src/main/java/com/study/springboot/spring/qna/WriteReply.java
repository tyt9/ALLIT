package com.study.springboot.spring.qna;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class WriteReply {

	private int qNum;
	private String reContent;
	private String replyName;
	
	public void validate(Map<String, Boolean> errors) {
		if (reContent == null || reContent.trim().isEmpty()) {
			errors.put("content", Boolean.TRUE);
		}
	}
}
