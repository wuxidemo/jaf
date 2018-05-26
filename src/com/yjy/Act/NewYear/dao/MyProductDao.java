package com.yjy.Act.NewYear.dao;

import java.util.List;
import java.util.Map;

public interface MyProductDao {

	public List<Object[]> getProData(Map<String, Object> params, int start, int count, String order);
	
	public int getProCountByParam(Map<String, Object> params);
	
	/*****************************下面是江南大学和太湖学院Dao方法*************************************/
	
	public List<Object[]> getJDProData(Map<String, Object> params, int start, int count, String order);
	
	public int getJDProCountByParam(Map<String, Object> params);
	
	
	
	public List<Object[]> getTHProData(Map<String, Object> params, int start, int count, String order);
	
	public int getTHProCountByParam(Map<String, Object> params);
	
	/**************************************************************************************/
	
}
