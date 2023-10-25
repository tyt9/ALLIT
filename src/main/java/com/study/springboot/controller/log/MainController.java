package com.study.springboot.controller.log;

import java.util.List;

import javax.servlet.http.Cookie;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.auth.NoSuchIdException;
import com.study.springboot.auth.User;
import com.study.springboot.auth.WrongPassException;
import com.study.springboot.service.log.LoginService;
import com.study.springboot.service.notice.NoticeReadService;
import com.study.springboot.spring.dao.apply.ExamsDao;
import com.study.springboot.spring.log.LoginCommand;
import com.study.springboot.spring.notice.Notice;

@Controller
public class MainController {
	
	@Autowired
	private LoginService loginService;

	@Autowired
	private NoticeReadService noticeReadService;
	
	@Autowired
	private ExamsDao examsDao;
	
	@GetMapping("/main")
	public String main(Model model, @RequestParam(required = false) LoginCommand loginCommand,
			 @CookieValue(value = "REMEMBER", required = false) Cookie rCookie) {
		if(loginCommand != null) {
			model.addAttribute("loginCommand", loginCommand);
		}else if(loginCommand == null && rCookie != null){
			LoginCommand command = new LoginCommand();
				command.setId(rCookie.getValue());
				command.setRememberId(true);
			model.addAttribute("loginCommand", command);
			}else{
			model.addAttribute("loginCommand", new LoginCommand());
	}
		List<Notice> list = noticeReadService.mainNotice();
		model.addAttribute("noticeList", list);
		model.addAttribute("list",examsDao.selectList());
		return "index";
	}
	
	@PostMapping("/main")
	public String mainPost(Model model, @Valid LoginCommand loginCommand, 
			Errors errors,  HttpSession session, HttpServletResponse response) {
		if(errors.hasErrors()) {
			return "index";
		}
		List<Notice> list = noticeReadService.mainNotice();
		model.addAttribute("noticeList", list);
		model.addAttribute("list",examsDao.selectList());
		try {
			User user = loginService.login(loginCommand.getId(), loginCommand.getPassword());
			session.setAttribute("authUser", user);
			Cookie rememberCookie = 
					new Cookie("REMEMBER", loginCommand.getId());
			rememberCookie.setPath("/");
			if (loginCommand.isRememberId()) {
				rememberCookie.setMaxAge(60 * 60 * 24 * 30);
			} else {
				rememberCookie.setMaxAge(0);
			}
			response.addCookie(rememberCookie);
			return "index";
			
		} catch (WrongPassException e) {
			errors.rejectValue("password", "wrong");
			return "index";
		} catch (NoSuchIdException e) {
			errors.rejectValue("id", "noSuchId");
			return "index";
		}
	}
	
	@GetMapping("/main/logout")
	public String logout(HttpSession session) {
		User authUser = (User) session.getAttribute("authUser");
		if (authUser != null) {
			session.invalidate();
		}
		return "redirect:/main";
	}
	
	//접속하면 바로 메인페이지 뜨게.
	@RequestMapping(value="/")
	public String index() {
		return "redirect:/main";
	}
}
