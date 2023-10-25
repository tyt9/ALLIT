package com.study.springboot.controller.apply;

import java.time.LocalDateTime;

import com.study.springboot.auth.User;
import com.study.springboot.spring.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.spring.dao.apply.ApplyDao;
import com.study.springboot.spring.dao.apply.ExamsDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	private ExamsDao examsDao;
	
	@Autowired
	private ApplyDao applyDao;
	
	@GetMapping
	public String list(Model model, HttpSession session) {
		if (session != null) {
			User user = (User) session.getAttribute("authUser");
			if(user != null){
				model.addAttribute("userGrade", user.getMemberGrade());
			}else {
				model.addAttribute("userGrade","F");
			}

		}else {
			model.addAttribute("userGrade","F");
		}

		model.addAttribute("startDate",LocalDateTime.now().toString().substring(0,4)+"-01-01");
		model.addAttribute("endDate",LocalDateTime.now().toString().substring(0,4)+"-12-31");
		model.addAttribute("list",examsDao.selectList());
		model.addAttribute("examsList",examsDao.selectExam());
		return "examSchedule";
	}
	
	@PostMapping
	public String listPost(Model model,
			@RequestParam String startDate,
			@RequestParam String endDate,
			@RequestParam String hiddenActBtn) {
		model.addAttribute("hiddenActBtnVal",hiddenActBtn);
		model.addAttribute("examsList",examsDao.selectExam());
		model.addAttribute("startDate",startDate);
		model.addAttribute("endDate",endDate);
		model.addAttribute("list",examsDao.selectListByDate(startDate, endDate));
		return "examSchedule";
	}
	
	@GetMapping("/examDetail")
	public String examDetail(Model model, @RequestParam int infoNum, HttpSession session) {
		System.out.println("1 > "+session);
		if (session != null) {
			System.out.println("2 > "+session);
			User user = (User) session.getAttribute("authUser");
			if(user != null){
				System.out.println("user > "+user);
				model.addAttribute("applySession", user.getMemberNum());
			}else {
				System.out.println("user 2 > ");
				model.addAttribute("applySession", "F");

				model.addAttribute("selectCount",applyDao.selectCount(infoNum));
				model.addAttribute("examDetail",examsDao.selectInfoByInfoNum(infoNum));
				return "examDetail";
			}
			System.out.println("2-1 > "+ user);

			System.out.println("2-2 > "+user.getMemberNum());
		}else{
			System.out.println("3 > "+session);
			model.addAttribute("applySession", "F");
		}
		System.out.println("4 > "+session);
		model.addAttribute("selectCount",applyDao.selectCount(infoNum));
		model.addAttribute("examDetail",examsDao.selectInfoByInfoNum(infoNum));
		return "examDetail";
	}
}
