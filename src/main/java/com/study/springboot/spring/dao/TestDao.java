package com.study.springboot.spring.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TestDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int count() {
		Integer count = jdbcTemplate.queryForObject(
				"select 1+2", Integer.class);
		return count;
	}

}
