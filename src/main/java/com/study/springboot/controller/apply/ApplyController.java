package com.study.springboot.controller.apply;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.study.springboot.spring.dao.log.MemberDao;
import com.study.springboot.spring.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.auth.User;
import com.study.springboot.spring.dao.apply.ApplyDao;
import com.study.springboot.spring.dao.apply.ExamsDao;
import com.study.springboot.spring.dto.Apply;

@Controller
@RequestMapping("/apply")
public class ApplyController {

	@Autowired
	private ExamsDao examsDao;
	
	@Autowired
	private ApplyDao applyDao;

	@Autowired
	private MemberDao memberDao;
	
	@GetMapping // << 인터셉트 
	public String applyForm(Model model, @RequestParam int infoNum, HttpSession session) {
		model.addAttribute("examDetail",examsDao.selectInfoByInfoNum(infoNum));
		if (session != null) {
			User user = (User) session.getAttribute("authUser");
			model.addAttribute("userName", user.getUserName());
			Member member = memberDao.selectMemberByMemberNum(user.getMemberNum());
			model.addAttribute("userPhone", member.getMemberPhone());
		}
		return "applyForm";
	}
	
	@PostMapping  // << 세션처리
	public String applyFormPost(Model model,Apply apply,Errors errors,@RequestParam int infoNum,
			 HttpSession session, HttpServletRequest req) {
		model.addAttribute("examDetail",examsDao.selectInfoByInfoNum(infoNum));
		if(errors.hasErrors()) {
			return "applyForm";
		}
		if (session != null) {
			User user = (User) session.getAttribute("authUser");
			model.addAttribute("userName",user.getUserName());
			Member member = memberDao.selectMemberByMemberNum(user.getMemberNum());
			model.addAttribute("userPhone",member.getMemberPhone());
			applyDao.insert(user.getMemberNum(), infoNum);
			model.addAttribute("exam",examsDao.selectInfoByInfoNum(infoNum));
			return "applySuccess";
		}
		return "applyForm";
	}
}
