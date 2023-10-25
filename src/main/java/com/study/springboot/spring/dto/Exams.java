package com.study.springboot.spring.dto;

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
public class Exams {

	private int exNum;
	private String exName;
	
	public Exams(String exName) {
		super();
		this.exName = exName;
	}
	
	
}
