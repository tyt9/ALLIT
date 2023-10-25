package com.study.springboot.spring.dao.apply;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.study.springboot.spring.dto.ExamDetail;
import com.study.springboot.spring.dto.ExamDetailPAN;
import com.study.springboot.spring.dto.Exams;

@Repository
public class ExamsDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<ExamDetail> selectList() {
		String sql = "select e.exnum,exname,infonum,infodate,info,infostart,infoend,infoloc,infoseq,infoPrice "
				+ " from exams e, examinfo i "
				+ " where e.exnum = i.exnum "
				+ " order by exname, infodate ";
		List<ExamDetail> list = jdbcTemplate.query(sql, (rs,n)-> examDetail(rs));
		return list;
	}
	
	private ExamDetail examDetail(ResultSet rs) throws SQLException {
		return new ExamDetail(rs.getInt(1), 
				rs.getString(2), rs.getInt(3), 
				rs.getTimestamp(4).toLocalDateTime(), rs.getString(5),
				rs.getTimestamp(6).toLocalDateTime(),rs.getTimestamp(7).toLocalDateTime(),
				rs.getString(8),rs.getInt(9),rs.getInt(10));
	}
	
	public List<Exams> selectExam() {
		String sql = "select * from exams";
		return jdbcTemplate.query(sql, (rs,n)->{
			return new Exams(rs.getInt(1),rs.getString(2));
		});
	}
	
	public List<ExamDetail> selectListByDate(String startDate, String endDate){
		String sql = "select e.exnum,exname,infonum,infodate,info,infostart,infoend,infoloc,infoseq,infoPrice "
				+ " from exams e, examinfo i "
				+ " where e.exnum = i.exnum "
				+ " and infodate >= ?"
				+ " and infodate <= ?"
				+ " order by exname, infodate ";
		return jdbcTemplate.query(sql, (rs,n) -> examDetail(rs),startDate,endDate);
	}
	
	public ExamDetailPAN selectInfoByInfoNum(int infoNum) {
		String sql = "select "
				+ " (select ei.infonum from  examinfo ei where ei.exnum = e.exnum "
				+ " and infoseq < i.infoseq order by infoseq desc limit 1) as prevNum"
				+ " ,(select ei.infonum from  examinfo ei where ei.exnum = e.exnum"
				+ " and infoseq > i.infoseq order by infoseq asc limit 1) as nextNum"
				+ " ,e.exnum,exname,infonum,infodate,info,infostart,infoend,infoloc,infoseq,infoPrice"
				+ " from exams e left outer join examinfo i"
				+ " on e.exnum = i.exnum"
				+ " where infonum = ?"
				+ " order by exname, infoseq";
		return jdbcTemplate.queryForObject(sql, (rs,n) -> examDetailPAN(rs),infoNum);
	}
	
	private ExamDetailPAN examDetailPAN(ResultSet rs) throws SQLException {
		return new ExamDetailPAN(rs.getInt(1), rs.getInt(2), rs.getInt(3), 
				rs.getString(4), rs.getInt(5), 
				rs.getTimestamp(6).toLocalDateTime(), rs.getString(7),
				rs.getTimestamp(8).toLocalDateTime(),rs.getTimestamp(9).toLocalDateTime(),
				rs.getString(10),rs.getInt(11),rs.getInt(12));
	}
	
	public int applyCount(int infoNum){
		String sql = "select count(menum) from memberexam where infoNum = ?";
		return jdbcTemplate.queryForObject(sql,Integer.class,infoNum);
	}
}
