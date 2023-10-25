package com.study.springboot.spring.log;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

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
public class RegisterRequest {

//	@Pattern(regexp = "/^[a-z]+[a-z0-9]{5,9}$/g",message = "양식에 맞게 작성하세요")
	private String id;
	@NotBlank
	private String name;
	private String phone;
	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}", message = "영문, 숫자, 특수문자 (8~16자)")
	private String password;
	@NotEmpty
	private String confirmPassword;

	
	public boolean isPasswordEqualToConfirmPassword() {
		return password.equals(confirmPassword);
	}
}
