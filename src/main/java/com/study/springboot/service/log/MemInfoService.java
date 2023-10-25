package com.study.springboot.service.log;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.apply.ApplyDao;
import com.study.springboot.spring.dao.log.MemberDao;
import com.study.springboot.spring.dao.qna.QnaDao;
import com.study.springboot.spring.dto.Member;
import com.study.springboot.spring.dto.MemberExam;
import com.study.springboot.spring.dto.MyExam;
import com.study.springboot.spring.dto.Qna;

@Service
public class MemInfoService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private ApplyDao applyDao;
	
	public List<Qna> findQnaByMemberNum(int memberNum) {
		return qnaDao.selectQnaByMemberNum(memberNum);
	}
	
	public int findQnaCountByMemberNum(int memberNum) {	
	return qnaDao.CountQnaByMemberNum(memberNum);
	}
	
	public Member findMyInfoByMemberNum(int memberNum) {
		Member member = memberDao.selectMemberByMemberNum(memberNum);
		return member;
	}
	
	public String findMyIdByNameAndPhone(String name, String phone) {
		String memberId = memberDao.selectMemberIdByNameAndPhone(name, phone);
		return memberId;
	}
	
	public Member findMyPwByIdAndPhone(String id, String phone) {
		Member member = memberDao.selectMemberByIdAndPhone(id,phone);
		return member;
	}
	
	public List<MyExam> findMyExamsByMemberNum(int memberNum){
		return applyDao.selectMyExam(memberNum);
	}
	
	public List<Qna> findMyQnaByMemberNum(int memberNum){
		return qnaDao.findMyQnaByMemberNum(memberNum);
	}
}
