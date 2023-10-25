package com.study.springboot.service.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.auth.NoSuchIdException;
import com.study.springboot.auth.User;
import com.study.springboot.auth.WrongPassException;
import com.study.springboot.spring.dao.log.MemberDao;
import com.study.springboot.spring.dto.Member;

@Service
public class LoginService {

	@Autowired
	private MemberDao memberDao;
	
//	@Transactional
	public User login(String id, String password) {

		Member member = memberDao.selectMemberByMemberId(id);
		if (member == null) {
			throw new NoSuchIdException();
		}
		if (!member.matchPassword(password)) {
			throw new WrongPassException();
		}
		return new User(member.getMemberNum(), member.getMemberId(),
				member.getMemberName(), member.getMemberGrade());
	}
}
