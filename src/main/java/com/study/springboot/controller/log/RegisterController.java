package com.study.springboot.controller.log;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.study.springboot.SMS.CustomMessage;
import com.study.springboot.SMS.MessageRes;
import com.study.springboot.SMS.SmsService;
import com.study.springboot.service.log.MemberRegisterService;
import com.study.springboot.spring.log.DuplicateMemberException;
import com.study.springboot.spring.log.RegisterRequest;


@Controller
@RequestMapping("/register")
public class RegisterController {

	@Autowired
	private MemberRegisterService memberRegisterService;

	@Autowired
	private SmsService smsService;

	@RequestMapping("/step1")
	public String handleStep1() {
		return "register/step1";
	}

	@PostMapping("/send")
	@ResponseBody
	public Map<String, Object> sendPost(String phone) throws InvalidKeyException, JsonProcessingException,
	        RestClientException, NoSuchAlgorithmException, UnsupportedEncodingException, URISyntaxException {
	    CustomMessage message = new CustomMessage(phone);
	    MessageRes response = smsService.send(message);
	    Map<String, Object> res = new HashMap<>();

	    if (response.getStatusName().equals("success")) {
	        res.put("success", true);
	        res.put("signNum", message.getSignNum());
	    } else {
	        res.put("success", false);
	        res.put("signNum", "0");
	    }

	    return res;
	}

	@PostMapping("/result")
	@ResponseBody
	public String getSignNum(String signNum, String signNumInput) {
		if (signNum.equals(signNumInput)) {
			return "true";
		} else {
			return "false";
		}
	}

	@PostMapping("/success")
	public String handleStep2Get(RegisterRequest registerRequest, String phone, Model model) {
		model.addAttribute("phone", phone);
		return "register/step2";
	}

	@PostMapping("/step2")
	public String handleStep2(Model model, RegisterRequest registerRequest) {
		model.addAttribute("registerRequest", new RegisterRequest());
		return "register/step3";
	}

	@PostMapping("/step3")
	public String handleStep3(@Valid RegisterRequest regReq, Errors errors, Model model) {
		model.addAttribute("phone", regReq.getPhone());
		
		if (errors.hasErrors())
			return "register/step2";
		if (!regReq.isPasswordEqualToConfirmPassword()) {
			errors.rejectValue("confirmPassword", "nomatch");
			return "register/step2";
		}
		try {
			memberRegisterService.regist(regReq);
			return "register/step3";
		} catch (DuplicateMemberException ex) {
			errors.rejectValue("id", "duplicate");
			return "register/step2";
		}
	}

}
