package com.study.springboot.controller.log;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.auth.NoSuchIdException;
import com.study.springboot.auth.User;
import com.study.springboot.auth.WrongPassException;
import com.study.springboot.service.log.LoginService;
import com.study.springboot.service.log.MemInfoService;
import com.study.springboot.spring.dto.Member;
import com.study.springboot.spring.log.LoginCommand;

@Controller
public class LogController {

	@Autowired
	private LoginService loginService;

	@Autowired
	private MemInfoService memInfoService;

	
	@GetMapping("/login")
	public String login1(LoginCommand loginCommand, @CookieValue(value = "REMEMBER", required = false) Cookie rCookie) {
		if (rCookie != null) {
			loginCommand.setId(rCookie.getValue());
			loginCommand.setRememberId(true);
		}
		return "login/loginForm";

	}

	@PostMapping("/login")
	public String login2(@Valid LoginCommand loginCommand, Errors errors, HttpSession session,
			HttpServletResponse response) {
		if (errors.hasErrors()) {
			return "login/loginForm";
		}

		try {
			User user = loginService.login(loginCommand.getId(), loginCommand.getPassword());
			session.setAttribute("authUser", user);
			Cookie rememberCookie = new Cookie("REMEMBER", loginCommand.getId());
			rememberCookie.setPath("/");
			if (loginCommand.isRememberId()) {
				rememberCookie.setMaxAge(60 * 60 * 24 * 30);
			} else {
				rememberCookie.setMaxAge(0);
			}
			response.addCookie(rememberCookie);
			return "redirect:/main";

		} catch (WrongPassException e) {
			errors.rejectValue("password", "wrong");
			return "login/loginForm";
		} catch (NoSuchIdException e) {
			errors.rejectValue("id", "noSuchId");
			return "login/loginForm";
		}
	}

	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		return "redirect:/main";
	}

	@GetMapping("/findInfo")
	public String findMyInfoGet() {
		return "login/findIdOrPassword";
	}

	@GetMapping("/findId")
	public String findMyIdGet() {
		return "login/findIdForm";
	}

	
	@PostMapping("/findId")
	@ResponseBody
	public String findMyIdPost(@RequestParam("name") String name, @RequestParam("phone") String phone) {
		String memberId = memInfoService.findMyIdByNameAndPhone(name, phone);
		if(memberId != null) {
			return "true";
		} else {
			return "false";
		}
	}
	
	@PostMapping("/findIdSuccess")
	public String findIdSuccess(Model model, String name, String phone) {
		String memberId = memInfoService.findMyIdByNameAndPhone(name, phone);
		model.addAttribute("memberId", memberId);
		model.addAttribute("name", name);
		model.addAttribute("phone", phone);
		return "login/findIdSuccess";
	}
	

	@GetMapping("/findPassword")
	public String findMyPasswordGet() {
		return "login/findPwForm";
	}

	@PostMapping("/findPassword")
	@ResponseBody
	public String findMyPasswordPost(Model model, @RequestParam String memberId, 
								@RequestParam String phone, HttpSession session) {
		Member member = memInfoService.findMyPwByIdAndPhone(memberId, phone);
		if(member != null) {
			session.setAttribute("memberId", member.getMemberId());
			return "true";
		} else {
			return "false";
		}
	}

}
