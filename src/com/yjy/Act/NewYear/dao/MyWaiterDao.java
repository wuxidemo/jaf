package com.yjy.Act.NewYear.dao;

import java.util.List;
import java.util.Map;

public interface MyWaiterDao {

	public List<Object[]> getWaiterData(Map<String, Object> params, int start, int count, String order);
	
	public int getWaiterCountByParam(Map<String, Object> params);
	
}
