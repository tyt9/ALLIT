package com.study.springboot.controller.log;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.study.springboot.spring.log.LoginCommand;



public class LogInOutValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return LoginCommand.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		LoginCommand loginCommand = (LoginCommand) target;
		if (loginCommand.getId() == null || loginCommand.getId().trim().isEmpty()) {
			errors.rejectValue("id", "required");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "required");
	}
}
