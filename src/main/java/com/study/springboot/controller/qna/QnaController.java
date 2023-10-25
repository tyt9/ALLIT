package com.study.springboot.controller.qna;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.auth.User;
import com.study.springboot.service.qna.QnaService;
import com.study.springboot.service.qna.ReplyService;
import com.study.springboot.spring.dao.qna.ReplyDao;
import com.study.springboot.spring.qna.DeleteReply;
import com.study.springboot.spring.qna.DeleteRequest;
import com.study.springboot.spring.qna.ModifyRequest;
import com.study.springboot.spring.qna.PermissionDeniedException;
import com.study.springboot.spring.qna.QnaNotFoundException;
import com.study.springboot.spring.qna.QnaPage;
import com.study.springboot.spring.qna.ReadRequest;
import com.study.springboot.spring.qna.Reply;
import com.study.springboot.spring.qna.ReplyNotFoundException;
import com.study.springboot.spring.qna.ReplyPermissionDeniedException;
import com.study.springboot.spring.qna.WriteReply;
import com.study.springboot.spring.qna.WriteRequest;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class QnaController {

	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private ReplyDao replyDao;
	
	@GetMapping("/qna/list")
	public String listQna(Model model, @RequestParam(value = "pageNo", required = false) String pageNoVal, HttpServletRequest req) {
		int pageNo = 1;
		if (pageNoVal != null) {
			pageNo = Integer.parseInt(pageNoVal);
		}
		
		QnaPage qnaPage = qnaService.getQnaPage(pageNo);
		model.addAttribute("qnaPage", qnaPage);
		return "qna/listQna";
	}
	
	
	
	@GetMapping("/qna/read")
	public String readQna(Model model, @RequestParam(value = "no", defaultValue = "0") 
    Integer articleNum, HttpServletRequest req) {
		try {
			ReadRequest readRequest = qnaService.getQna(articleNum, true);
			model.addAttribute("readRequest", readRequest);
			model.addAttribute("ListReply",  replyDao.listDao(articleNum));
//			model.addAttribute("ListReplyForm", new ListReply());
			return "qna/readQna";
		} catch (QnaNotFoundException e ) {
			return "errorPage";
		}
	}
	
	@PostMapping("/qna/read")
	public String writeReply(Model model, @RequestParam(value = "no", defaultValue = "0") 
    Integer articleNum, HttpServletRequest req) {
//		Map<String, Boolean> errors = new HashMap<>();
//		model.addAttribute("errors", errors);
		
		User user = (User) req.getSession(false).getAttribute("authUser");
		
		WriteReply re = createReplyRequest(user, req);
//		re.validate(errors);
//		
//		if (!errors.isEmpty()) {
//			return "/qna/readQna";
//		}
		int writeReply = replyDao.writeDao(re);
		model.addAttribute("writeReply", writeReply);
		return "redirect:/qna/read?no="+re.getQNum();
	}
	
	@GetMapping("/qna/deleteReply")
	public String deleteReply(HttpServletRequest req, Model model,@RequestParam(value = "no", defaultValue = "0") 
    Integer reNum, @RequestParam(value="qnum", defaultValue="0") Integer qNum) {
		User user = (User) req.getSession(false).getAttribute("authUser");

		DeleteReply delRepl = new DeleteReply(qNum, reNum, user.getMemberNum());
		model.addAttribute("delRep", delRepl);
		
		try {
			replyDao.deleteDao(reNum);
			return "redirect:/qna/read?no=" + delRepl.getQNum();
		} catch (ReplyNotFoundException	e) {
			return "errorPage";
		} catch(ReplyPermissionDeniedException e) {
			return "errorPage";
		}				
	}
	
	private WriteReply createReplyRequest(User user, HttpServletRequest req) {
		return new WriteReply(Integer.parseInt(req.getParameter("qNum")), req.getParameter("content"), user.getUserName());
	}
	
	@GetMapping("/qna/write")
	public String writeQna1() {
		return "qna/newQnaForm";
	}
	
	private WriteRequest createWriteRequest(User user, HttpServletRequest req) {
		return new WriteRequest(user.getMemberNum(), user.getUserName(), req.getParameter("title"), req.getParameter("content"));
	}
	
	@PostMapping("/qna/write")
	public String writeQna2(Model model, HttpServletRequest req) {
		Map<String, Boolean> errors = new HashMap<>();
		model.addAttribute("errors", errors);

		User user = (User) req.getSession(false).getAttribute("authUser");
		WriteRequest writeReq = createWriteRequest(user, req);
		writeReq.validate(errors);
		
		if (!errors.isEmpty()) {
			return "qna/newQnaForm";
		}
		
		int newQnaNo = qnaService.write(writeReq);
		model.addAttribute("newQnaNo", newQnaNo);
		return "qna/newQnaSuccess";
	}
	
	@GetMapping("/qna/modify")
	public String modifyQna1(Model model, HttpServletRequest req) {
		try {
			String noVal = req.getParameter("no");
			int no = Integer.parseInt(noVal);
			ReadRequest readRequest = qnaService.getQna(no, false);
			User user = (User) req.getSession(false).getAttribute("authUser");
			if (!canModify(user, readRequest)) {
				return "errorPage";
			}
			ModifyRequest modReq = new ModifyRequest(user.getMemberNum(), no, readRequest.getQTitle(), readRequest.getQContent());
			model.addAttribute("modReq", modReq);
			return "qna/modifyForm";
		} catch(QnaNotFoundException e) {
			System.out.println("조회 안됨");
			return "errorPage";
		}
	}
	
	private boolean canModify(User authUser, ReadRequest readRequest) {
		int writerId = readRequest.getMemberNum();
		
		return authUser.getMemberNum() == writerId;
	}
	
	@PostMapping("/qna/modify")
	public String modifyQna2(Model model, HttpServletRequest req,  @RequestParam(value = "no", defaultValue = "0") 
    Integer articleNum) {
		User user = (User) req.getSession().getAttribute("authUser");
		String noVal = req.getParameter("no");
		int no = Integer.parseInt(noVal);
		
		ModifyRequest modReq = new ModifyRequest(user.getMemberNum(), no, req.getParameter("title"), req.getParameter("content"));
		model.addAttribute("modReq", modReq);
		Map<String, Boolean> errors = new HashMap<>();
		model.addAttribute("errors", errors);
		modReq.validate(errors);
		if (!errors.isEmpty()) {
			return "qna/modifyForm";
		}
		try {
			qnaService.modify(modReq);
			return "qna/modifySuccess";
		} catch(QnaNotFoundException e) {
			return "errorPage";
		} catch(PermissionDeniedException e) {
			return "errorPage";
		}
	}
	
	@GetMapping("/qna/delete")
	public String deleteQna(HttpServletRequest req, Model model) {
		User user = (User) req.getSession(false).getAttribute("authUser");
		String noVal = req.getParameter("no");
		int no = Integer.parseInt(noVal);
		
		DeleteRequest delReq = new DeleteRequest(user.getMemberNum(), no);
		model.addAttribute("delReq", delReq);
		
		try {
			qnaService.delete(delReq);
			return "redirect:/qna/list";
		} catch(QnaNotFoundException e) {
			return "errorPage";
		} catch(PermissionDeniedException e) {
			return "errorPage";
		}
		
	}
	
	

}
