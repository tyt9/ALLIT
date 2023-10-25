package com.study.springboot.controller.apply;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.study.springboot.spring.dao.apply.EditExamsDao;
import com.study.springboot.spring.dao.apply.ExamsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.study.springboot.auth.User;
import com.study.springboot.spring.dao.apply.ApplyDao;

@RestController
@RequestMapping("/applyCheck")
public class ApplyCheckController {
	
	@Autowired
	private ApplyDao applyDao;

	@Autowired
	private ExamsDao examsDao;

	@Autowired
	private EditExamsDao editExamsDao;

	@RequestMapping(method = RequestMethod.POST)
    public int applyCheck(@RequestBody Map<String, Integer> reqData, HttpSession session) {
		int applyCheckNum = 99;
        int infoNum = reqData.get("infoNum");
        if (session != null) {
			User user = (User) session.getAttribute("authUser");
			applyCheckNum = applyDao.ApplyCheckNum(infoNum, user.getMemberNum());
		}
        return applyCheckNum;
    }

	@RequestMapping(value = "/applyCount", method = RequestMethod.POST)
	public int applyCount(@RequestBody Map<String, Integer> reqData, HttpSession session){
		int infoNum = reqData.get("infoNum");
		return examsDao.applyCount(infoNum);
	}

	@RequestMapping(value = "/nextSeq", method = RequestMethod.POST)
	public int nextSeq(@RequestBody Map<String, Integer> reqData){
		int exNum = reqData.get("exNum");
		return editExamsDao.selectSeqByExNum(exNum);
	}

	@RequestMapping(value = "/delExam", method = RequestMethod.POST)
	public int delExam(@RequestBody Map<String, Integer> reqData){
		int infoNum = reqData.get("infoNum");
		return editExamsDao.deleteExam(infoNum);
	}

}
