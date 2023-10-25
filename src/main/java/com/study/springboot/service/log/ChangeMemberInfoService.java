package com.study.springboot.service.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.study.springboot.auth.WrongPassException;
import com.study.springboot.spring.dao.log.MemberDao;
import com.study.springboot.spring.dto.Member;
import com.study.springboot.spring.log.EmptyCommandException;
import com.study.springboot.spring.log.InvalidPasswordException;
import com.study.springboot.spring.log.MemberNotFoundException;


@Service
public class ChangeMemberInfoService {

	@Autowired
	private MemberDao memberDao;

	@Transactional
	public void changePassword(int memberNum, String curPwd, String newPwd) {

		Member member = memberDao.selectMemberByMemberNum(memberNum);
		
		if(member == null) {
			throw new MemberNotFoundException();
		}
		if (!member.matchPassword(curPwd)) {
			throw new InvalidPasswordException();
		}
		member.changePassword(curPwd, newPwd);
		memberDao.update(member);
	}
	
	public void changePhone(int memberNum, String newPhone) {
		Member member = memberDao.selectMemberByMemberNum(memberNum);
		if(member == null) {
			throw new MemberNotFoundException();
		}
		
		member.setMemberPhone(newPhone);
		memberDao.update(member);
	}
	
	public void renewPassword(String memberId, String newPwd, String confirmNewPwd) {
		
		if (newPwd.equals("") ||confirmNewPwd.equals("")){
		throw new EmptyCommandException();
	}
		if (!newPwd.equals(confirmNewPwd)){

		throw new WrongPassException();
	}
		
		Member member = memberDao.selectMemberByMemberId(memberId);
		
		if(member == null) {
			throw new MemberNotFoundException();
		}
		member.changePassword(member.getMemberPassword(), newPwd);
		memberDao.update(member);
	}
}
