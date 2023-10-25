package com.study.springboot.controller.notice;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.service.notice.NoticeDeleteService;
import com.study.springboot.service.notice.NoticeListService;
import com.study.springboot.service.notice.NoticeModifyService;
import com.study.springboot.service.notice.NoticeReadService;
import com.study.springboot.service.notice.NoticeWriteService;
import com.study.springboot.spring.dao.notice.NoticeDao;
import com.study.springboot.spring.notice.NoticeData;
import com.study.springboot.spring.notice.NoticeModifyRequest;
import com.study.springboot.spring.notice.NoticeNotFoundException;
import com.study.springboot.spring.notice.NoticePage;
import com.study.springboot.spring.notice.WriteRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeDao noticeDao;

	@Autowired
	private NoticeListService noticeListService;
	@Autowired
	private NoticeReadService noticeReadService;
	@Autowired
	private NoticeWriteService noticeWriteService;
	@Autowired
	private NoticeModifyService noticeModifyService;
	@Autowired
	private NoticeDeleteService noticeDeleteService;

	@GetMapping("/list")
	public String noticeList(Model model, @RequestParam(value = "pageNo", required = false) String pageNoVal) {
		int pageNo = 1;
		if (pageNoVal != null) {
			pageNo = Integer.parseInt(pageNoVal);
		}
		NoticePage noticePage = noticeListService.getNoticePage(pageNo);
		log.info("-------" + noticePage);
		model.addAttribute("noticePage", noticePage);
		model.addAttribute("pageNo", pageNo);
		return "notice/list";

	}

	@GetMapping("/write")
	public String noticeWrite() {
		return "notice/write";
	}
	
	@PostMapping("/write")
	public String noticewrite2(Model model, WriteRequest writeReq){

		Map<String, Boolean> errors = new HashMap<>();
		model.addAttribute("errors", errors);

		
//		WriteRequest writeReq = new WriteRequest(req.getParameter("title"), req.getParameter("content"),
//				Integer.parseInt(req.getParameter("impor")));
	
		writeReq.validate(errors);
		
		if (!errors.isEmpty()) {
			return "notice/write";

		}

		int newNoticeNo = noticeWriteService.write(writeReq);
		model.addAttribute("noNum", newNoticeNo);

		return "notice/writerSuccess";

	}

	
	@GetMapping("/read")
	public String noticeRead1(Model model, @RequestParam(value = "noNum", defaultValue = "0") Integer noNum)
			throws NoticeNotFoundException {
		NoticeData noticeData = noticeReadService.getNotice(noNum, true);
		model.addAttribute("noticeData", noticeData);

		return "notice/read";
	}

	
	@GetMapping("/delete")
	public String NoticeDelete(HttpServletRequest req, Model model, @RequestParam String no) {
		int noNum = Integer.parseInt(no);
		try {
			noticeDeleteService.delete(noNum);
			return "notice/deleteSuccess";
		} catch (NoticeNotFoundException e) {
			// res.sendError(HttpServletResponse.SC_NOT_FOUND);
			return "notice/errorPage";
		} catch (Exception e) {
			// res.sendError(HttpServletResponse.SC_FORBIDDEN);
			return "notice/errorPage";
		}
	}

	@GetMapping("/modify")
	public String noticeModify(HttpServletRequest req,Model model) {
		try {
			String noVal = req.getParameter("noNum");
			int noNum = Integer.parseInt(noVal);
			System.out.println("------------------"+noNum);
			NoticeData noticeData = noticeReadService.getNotice(noNum,false);
//			,NoticeModifyRequest modReq	
			NoticeModifyRequest modReq = new NoticeModifyRequest(
						noticeData.getNotice().getNoNum(),
						noticeData.getNotice().getNoTitle(),
						noticeData.getNotice().getNoContent(),
					
						noticeData.getNotice().getNoImpor());

				model.addAttribute("modReq", modReq);
				return "notice/modifyForm";
			} catch (NoticeNotFoundException e) {
				//res.sendError(HttpServletResponse.SC_NOT_FOUND);
				return "notice/errorPage";
			}
}
	
	@PostMapping("/modify")
	public String modifyArticle2( NoticeModifyRequest modReq, Model model) {
//		
//		String noVal = req.getParameter("no");
//		int no = Integer.parseInt(noVal);

//	      model.addAttribute("modReq", modReq);
//	      Map<String, Boolean> errors = new HashMap<>();
//	      model.addAttribute("errors", errors);
//	      modReq.validate(errors);
//	      if (!errors.isEmpty()) {
//	         return "notice/modifyForm";
//	      }
//	      try {
//	        noticeModifyService.modify(modReq);
//	         return "notice/modifySuccess";
//	      } catch(NoticeNotFoundException e) {
//	         return "notice/errorPage";
	     
	 Map<String, Boolean> errors = new HashMap<>();
	 		model.addAttribute("errors", errors);
			modReq.validate(errors);
			if (!errors.isEmpty()) {
				return "notice/modifyForm";
			}
			try {
				noticeModifyService.modify(modReq);
				System.out.println("-------------------------" +modReq.getNoNum());
				model.addAttribute("num", modReq.getNoNum());
				return "notice/modifySuccess";
			} catch (NoticeNotFoundException e) {
				//res.sendError(HttpServletResponse.SC_NOT_FOUND);
				return "errorPage";
		}     
	}
}
//}

