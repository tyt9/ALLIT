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
public class ExamDetail {
	
	private int exNum;
	private String exName;
	private int infoNum;
	private LocalDateTime infoDate;
	private String info;
	private LocalDateTime infoStart;
	private LocalDateTime infoEnd;
	private String infoLoc;
	private int infoSeq;
	private int infoPrice;
}
