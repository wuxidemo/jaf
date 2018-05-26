package com.yjy.dao;

import java.util.List;
import java.util.Map;

import com.yjy.entity.CategoryValue;
import com.yjy.entity.Community;

public interface MyVolunteerDao {

	public List<Object[]> getVolunteerListData(Map<String, Object> params, int start, int size);
	
	/*****************************下面后台志愿者列表查询Dao方法*************************************/
	
	public List<Object[]> getVolunteerListByParam(Map<String, Object> params, int start, int size,String order,List<CategoryValue>  keywordlist,Community c);
	
	public int getVolCountByParam(Map<String, Object> params,List<CategoryValue>  keywordlist,Community c);

	public List<Object[]> getVolunteerDetail(Long id);
	
	public List<Object[]> getVolunteerDetail2(Long id);
	
}
