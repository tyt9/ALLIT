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
@Builder
@ToString
public class ModifyRequest {

	private int memberNum;
	private int qNum;
	private String qTitle;
	private String qContent;
	
	public void validate(Map<String, Boolean> errors) {
		if (qTitle == null || qTitle.trim().isEmpty()) {
			errors.put("title", Boolean.TRUE);
		}
	}
}
