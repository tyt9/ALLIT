package com.study.springboot.spring.dao.apply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.study.springboot.spring.dto.MyExam;

@Repository
public class ApplyDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Number insert(int memberNum, int infoNum) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
		String sql = "insert into memberexam values(null,now(),?,?,0)";
		jdbcTemplate.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql,
						new String[] { "MENUM" });
				pstmt.setInt(1, memberNum);
				pstmt.setInt(2, infoNum);
				return pstmt;
			}
		}, keyHolder);
		Number keyValue = keyHolder.getKey();
		return keyValue;
		
	}
	
	public int selectCount(int infoNum) {
		String sql = "select count(menum) from memberexam where infonum = ?";
		return jdbcTemplate.queryForObject(sql, Integer.class, infoNum);
	}
	
	public int ApplyCheckNum(int infoNum, int memberNum) {
		String sql = "select count(menum) from memberexam where infonum = ? and membernum = ?";
		return jdbcTemplate.queryForObject(sql, Integer.class, infoNum, memberNum);
	}
	
	public List<MyExam> selectMyExam(int memberNum){
		String sql = "select e.exname, me.membernum, ei.infonum, ei.infodate, me.menum from exams e "
				+ "inner join examinfo ei on e.exnum = ei.exnum "
				+ "inner join memberexam me on ei.infonum = me.infonum "
				+ "where membernum = ? "
				+ "order by infodate desc limit 5";
		List <MyExam> list = jdbcTemplate.query(sql, (rs,n) -> {
			MyExam exam = new MyExam(rs.getString("exname"), rs.getInt("membernum"),
					rs.getInt("infonum"), rs.getTimestamp("infodate").toLocalDateTime(),
					rs.getInt("menum"));
			return exam;
		}, memberNum);
		return list;
	}
	
	public void deleteMyExam(int meNum) {
		String sql = "delete from memberexam where menum = ?";
		jdbcTemplate.update(sql,meNum);
	}
	
}
