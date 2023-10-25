package com.study.springboot.spring.dto;

import java.time.LocalDateTime;

import com.study.springboot.spring.log.InvalidPasswordException;

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
public class Member {

	private int memberNum;
	private String memberId;
	private String memberName;
	private String memberPhone;
	private String memberPassword;
	private int memberGrade;
	private LocalDateTime memberDate;
	
	public Member(String memberId, String memberName, String memberPhone, String memberPassword, LocalDateTime memberDate) {
		this.memberId = memberId;
		this.memberName = memberName;
		this.memberPhone = memberPhone;
		this.memberPassword = memberPassword;
		this.memberDate = memberDate;
	}
	
	public boolean matchPassword(String pwd) {
		return memberPassword.equals(pwd);
	}

	public void changePassword(String oldPassword, String newPassword) {
		if (!memberPassword.equals(oldPassword))
			throw new InvalidPasswordException();
		this.memberPassword = newPassword;
	}
	
}
