package com.study.springboot.spring.dao.log;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.stereotype.Repository;

import com.study.springboot.spring.dto.Member;

@Repository
public class MemberDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<Member> memRowMapper = (rs, n) -> {
		Member member = new Member(rs.getInt("MEMBERNUM"), rs.getString("MEMBERID"), rs.getString("MEMBERNAME"),
				rs.getString("MEMBERPHONE"), rs.getString("MEMBERPASSWORD"), rs.getInt("MEMBERGRADE"),
				rs.getTimestamp("MEMBERDATE").toLocalDateTime());
		return member;
	};

	public Member selectMemberByMemberNum(int memberNum) {
		String sql = "select * from MEMBER where MEMBERNUM = ?";
		List<Member> results = jdbcTemplate.query(sql, memRowMapper, memberNum);
		return results.isEmpty() ? null : results.get(0);
	}

	public Member selectMemberByMemberId(String memberId) {
		String sql = "select * from MEMBER where MEMBERID = ?";
		List<Member> results = jdbcTemplate.query(sql, memRowMapper, memberId);
		return results.isEmpty() ? null : results.get(0);
	}

	public void insert(Member member) {
		GeneratedKeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement("insert into MEMBER (MEMBERNUM, MEMBERID, "
						+ "MEMBERNAME, MEMBERPHONE, MEMBERPASSWORD, MEMBERGRADE, MEMBERDATE) "
						+ "values (0, ?, ?, ?, ?, 0, now())", new String[] { "MEMBERNUM" });
				pstmt.setString(1, member.getMemberId());
				pstmt.setString(2, member.getMemberName());
				pstmt.setString(3, member.getMemberPhone());
				pstmt.setString(4, member.getMemberPassword());
				return pstmt;
			}
		}, keyHolder);
		Number keyValue = keyHolder.getKey();
		member.setMemberNum(keyValue.intValue());
	}

	public void update(Member member) {
		jdbcTemplate.update("update MEMBER set MEMBERNAME = ?, MEMBERPHONE =?, MEMBERPASSWORD = ? where MEMBERID = ?",
				member.getMemberName(), member.getMemberPhone(), member.getMemberPassword(), member.getMemberId());
	}

	public List<Member> selectAllMember() {
		String sql = "select * from MEMBER";
		List<Member> results = jdbcTemplate.query(sql, memRowMapper);
		return results;
	}

	public boolean countMemberByMemberId(String memberId) {
		String sql = "select count(*) from MEMBER where MEMBERID = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, memberId);
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}

	public int countAll() {
		Integer count = jdbcTemplate.queryForObject("select count(*) from MEMBER", Integer.class);
		return count;
	}

	public void deleteMemberByMemberNum(int memberNum) {
		String sql = "delete from MEMBER where memberNum = ?";
		this.jdbcTemplate.update(sql, memberNum);
	}

	public String selectMemberIdByNameAndPhone(String name, String phone) {
		try {
			String sql = "select MEMBERID from MEMBER where MEMBERNAME = ? and MEMBERPHONE =?";
			String memberId = jdbcTemplate.queryForObject(sql, String.class, name, phone);
			return memberId;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public Member selectMemberByIdAndPhone(String id, String phone) {
		try {
		String sql = "select * from MEMBER where MEMBERID = ? and MEMBERPHONE =?";
		return jdbcTemplate.queryForObject(sql, memRowMapper, id, phone);
		}catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
}
