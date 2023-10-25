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
public class ExamInfo {

	private int infoNum;
	private LocalDateTime infoDate;
	private String info;
	private int exNum;
	private LocalDateTime infoStart;
	private LocalDateTime infoEnd;
	private String infoLoc;
	private int infoSeq;
	
	public ExamInfo(LocalDateTime infoDate, String info, int exNum, LocalDateTime infoStart, LocalDateTime infoEnd,
			String infoLoc, int infoSeq) {
		super();
		this.infoDate = infoDate;
		this.info = info;
		this.exNum = exNum;
		this.infoStart = infoStart;
		this.infoEnd = infoEnd;
		this.infoLoc = infoLoc;
		this.infoSeq = infoSeq;
	}
	
	
	
	
}