package com.study.springboot.controller.log;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.auth.User;
import com.study.springboot.auth.WrongPassException;
import com.study.springboot.service.apply.ApplyService;
import com.study.springboot.service.log.ChangeMemberInfoService;
import com.study.springboot.service.log.DeleteMemService;
import com.study.springboot.service.log.MemInfoService;
import com.study.springboot.spring.dto.Member;
import com.study.springboot.spring.dto.MyExam;
import com.study.springboot.spring.dto.Qna;
import com.study.springboot.spring.log.ChangePwdCommand;
import com.study.springboot.spring.log.EmptyCommandException;
import com.study.springboot.spring.log.UpdateCommand;

@Controller
@RequestMapping("/edit")
public class MypageController {

	@Autowired
	private MemInfoService memInfoService;

	@Autowired
	private DeleteMemService deleteMemService;

	@Autowired
	private ChangeMemberInfoService changeMemberInfoService;

	@Autowired
	private ApplyService applyService;
	
	
	@GetMapping("/changePassword")
	public String form(Model model, ChangePwdCommand changePwdCommand,
			@RequestParam("id") String id, @RequestParam("phone") String phone) {
		model.addAttribute("changePwdcommand", new ChangePwdCommand());
		model.addAttribute("id", id);
		model.addAttribute("phone", phone);
		return "edit/changePwdForm";
	}

	@PostMapping("/changePassword")
	public String submit(HttpSession session, @Valid ChangePwdCommand changePwdcommand, Errors errors) {
		if (errors.hasErrors()) {
			return "edit/changePwdForm";
		}
		try {
			String memberId = (String) session.getAttribute("memberId");
			changeMemberInfoService.renewPassword(memberId, changePwdcommand.getNewPassword(),
				changePwdcommand.getNewPasswordConfirm());
			session.invalidate();
			return "edit/changedPwd";
		} catch (EmptyCommandException e) {
			return "edit/changePwdForm";
		} catch (WrongPassException e) {
			errors.rejectValue("newPasswordConfirm", "wrong");
			return "edit/changePwdForm";
		}
	}

	@GetMapping("/myPage")
	public String myQna(Model model, HttpSession session) {
		User authUser = (User) session.getAttribute("authUser");
		Member member = memInfoService.findMyInfoByMemberNum(authUser.getMemberNum());
		String phone = member.getMemberPhone().substring(0, 3) + "-"
				+ member.getMemberPhone().substring(3, 7) + "-"
				+ member.getMemberPhone().substring(7, 11);
		model.addAttribute("member", member);
		model.addAttribute("phone", phone);
		return "myPage/myPageMain";
	}

	@GetMapping("/deleteMyInfo")
	public String deleteMine() {
		return "myPage/deleteUserConfirm";
	}

	@PostMapping("/deleteMyInfo")
	public String deleteConfirmOk(HttpSession session, Model model, 
		@CookieValue(value = "REMEMBER", required = false) Cookie rCookie) {
		User authUser = (User) session.getAttribute("authUser");
		model.addAttribute("authUser", authUser);
		deleteMemService.deleteMember(authUser.getMemberNum());
		rCookie.setMaxAge(0);
		session.invalidate();
		return "myPage/deleteUserSuccess";
	}
	
	@GetMapping("/ChangeForm")
	public String changeInfo() {
		return "edit/passCheck";
	}
	
	@PostMapping("/ChangeForm")
	public String changeInfoPass(Model model, @RequestParam String password, 
			HttpSession session) {
		User authUser = (User)session.getAttribute("authUser");
		Member member = memInfoService.findMyInfoByMemberNum(authUser.getMemberNum());
		if(member.matchPassword(password)) {
			model.addAttribute("updateCommand", new UpdateCommand());
			model.addAttribute("member", member);
			return "edit/changeInfoForm";
		} 	else {			
			model.addAttribute("fail", true);
			return "edit/passCheck";
		}
	}
	
	@PostMapping("/changeInfo")
	public String changeInfoForm (Model model, UpdateCommand updateCommand, HttpSession session) {
		User authUser = (User)session.getAttribute("authUser");
		Member member = memInfoService.findMyInfoByMemberNum(authUser.getMemberNum());
		
		changeMemberInfoService.changePassword(member.getMemberNum()
				, member.getMemberPassword(), updateCommand.getConfirmPassword());
		changeMemberInfoService.changePhone(member.getMemberNum(), updateCommand.getPhone());
		model.addAttribute("member", member);
		return "redirect:/edit/myPage";
	}
	
	@PostMapping("/quickMenu")
	@ResponseBody
	public String quickMenu(@RequestParam String option) {
	    if (option.equals("/myQna")) {
	        return "myPage/myQna";
	    } else if (option.equals("/myTest")) {
	        return "myPage/myTest";
	    } else {
	        return "myPage/myPageMain";
	    }
	}
	
	@PostMapping("/myTest")
	@ResponseBody
	public Map<String, Object> myTest(int memberNum){
		Map<String, Object> map1 = new HashMap<>();
		List<MyExam> list = memInfoService.findMyExamsByMemberNum(memberNum);
		if(!list.isEmpty()) {
			map1.put("success", true);
			map1.put("list", list);
		} else {
			map1.put("success", false);
			map1.put("list", null);
		}
		
		return map1;
	}
	
	@PostMapping("/myQna")
	@ResponseBody
	public Map<String, Object> myQna(int memberNum){
		Map<String, Object> map2 = new HashMap<>();
		List<Qna> list = memInfoService.findMyQnaByMemberNum(memberNum);
		if(!list.isEmpty()) {
			map2.put("success", true);
			map2.put("list", list);
		} else {
			map2.put("success", false);
			map2.put("list", null);
		}
		return map2;
	}
	
	@PostMapping("/deleteExam")
	@ResponseBody
	public String deleteMyExam(int meNum) {
		System.out.println("온다");
		applyService.deleteMyExamByMeNum(meNum);
		return "true";
	}
}
