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
public class MyExam {

	private String exName;
	private int memberNum;
	private int infoNum;
	private LocalDateTime infoDate;
	private int meNum;
	
}
