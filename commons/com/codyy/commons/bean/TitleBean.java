package com.codyy.commons.bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.ConnectionPoolDataSource;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

import com.codyy.commons.CommonsConstant;

public class TitleBean {
	
	private static ConnectionPoolDataSource dataSource;
	
	private static StringRedisTemplate redisTemplate;
	
	public void setDataSource(ConnectionPoolDataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	private static String loadTitle(){
		ValueOperations<String, String> oper = redisTemplate.opsForValue();
		Connection connection = null;
		String value = null;
		try {
			connection = dataSource.getPooledConnection().getConnection();
			Statement stmt = connection.createStatement();
			stmt.execute("select config_value from base_config where base_config_id = '"+CommonsConstant.SYS_CONFIG_SYS_TITLE+"'");
			ResultSet resultSet = stmt.getResultSet();
			if(resultSet.next()){
				value = resultSet.getString("config_value");
			}
			oper.set(CommonsConstant.SYS_CONFIG + CommonsConstant.SYS_CONFIG_SYS_TITLE, value);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return value;
	}
	
	public static String readTitle(){
		ValueOperations<String, String> oper = redisTemplate.opsForValue();
		String value = oper.get(CommonsConstant.SYS_CONFIG + CommonsConstant.SYS_CONFIG_SYS_TITLE);
		if(StringUtils.isBlank(value)){
			value = loadTitle();
		}
		return value;
	}

	public void setRedisTemplate(StringRedisTemplate redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

}
