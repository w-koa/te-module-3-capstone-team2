package com.techelevator.npgeek;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;


@Component
public class JdbcWeatherDao implements WeatherDao {

	private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	public JdbcWeatherDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public Weather getForecastByCode(String parkCode) {
		Weather weather = new Weather();
		String sqlSelectByParkCode = "SELECT fivedayforecast, low, high, forecast "
				+ "FROM weather WHERE parkcode = ?";
				SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectByParkCode);
				if(results.next()) {
					weather = mapRowToWeather(results);
				}
		return weather;
	}
	
	private Weather mapRowToWeather(SqlRowSet row) { 
		
		Weather weather = new Weather(); 
		weather.setForecastValue(row.getInt("fivedayforecastvalue"));
		weather.setLowInF(row.getInt("low"));
		weather.setHighInF(row.getInt("high"));
		weather.setForecast(row.getString("forecast"));
	return weather;
	}
	
}