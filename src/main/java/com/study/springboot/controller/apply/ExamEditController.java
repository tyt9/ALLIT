package com.study.springboot.controller.apply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.spring.dao.apply.EditExamsDao;
import com.study.springboot.spring.dao.apply.ExamsDao;
import com.study.springboot.spring.dto.InsertExamInfo;

@Controller
@RequestMapping("/editExams")
public class ExamEditController {

	@Autowired
	private ExamsDao examsDao;
	
	@Autowired
	private EditExamsDao editExamsDao;

	@GetMapping("/insert")
	public String insertForm(Model model) {
		model.addAttribute("examsList",examsDao.selectExam());

		return "insertExamForm";
	}
	
	@PostMapping("/insertSuccess")
	public String insertSuccess(Model model, InsertExamInfo iei) {
		int num = editExamsDao.insertInfo(iei);
		System.out.println(iei);
		model.addAttribute("insertInfo",iei);
		return "insertInfo";
	}

}
