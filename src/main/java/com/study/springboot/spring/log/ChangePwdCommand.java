package com.study.springboot.spring.log;

import javax.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ChangePwdCommand {
	
	@NotBlank
	private String newPassword;
	@NotBlank
	private String newPasswordConfirm;
}
