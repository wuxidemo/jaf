package com.yjy.Act.NewYear.dao;

import java.util.List;
import java.util.Map;

public interface MyWaiterRedbagDao {

	public List<Object[]> getWaiterRedbagData(Map<String, Object> params, int start, int count, String order);
	
	public int getWaiterRedbagCountByParam(Map<String, Object> params);

	public List<Object[]> getNoSendWaiterRedbagByDate(String datestr);
	
}
