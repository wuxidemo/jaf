package com.yjy.dao;

import java.util.List;
import java.util.Map;

public interface MyActivityDao {
	
	public List<Object[]> getFatherActivityByParam(Map<String, Object> params, int start, int count, String order);
	
	public int getFatherActivityCountByParam(Map<String, Object> params, int start, int count, String order);

}
