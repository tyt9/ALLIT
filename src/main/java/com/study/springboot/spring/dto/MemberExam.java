package com.study.springboot.spring.dto;

import java.time.LocalDateTime;

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
public class MemberExam {

	private int meNum;
	private LocalDateTime meDate;
	private int memberNum;
	private int infoNum;
	private int expass;
	
	public MemberExam(LocalDateTime meDate, int memberNum, int infoNum, int expass) {
		super();
		this.meDate = meDate;
		this.memberNum = memberNum;
		this.infoNum = infoNum;
		this.expass = expass;
	}
	
}
