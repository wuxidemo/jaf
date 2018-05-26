package com.yjy.dao;

import java.util.List;
import java.util.Map;

public interface MyMercommentDao {

	public List<Object[]> getMercommentData(Map<String, Object> params, int start, int count, String order);
	
	public Integer getMercommentCount(Map<String, Object> params);
	/**
	 * 加载分页查询
	 * @param params
	 * @param start
	 * @param siz
	 * @return
	 */
	public List<Object[]> getMercommentListData(Map<String,Object> params,int start,int siz);
	/**
	 * 根据merid查询商户，评论信息
	 * @param merid
	 * @return
	 */
	public List<Object[]> getMercommentListData(Long merid);
	
	/**
	 * 查询前三条
	 * @param params
	 * @param start
	 * @param siz
	 * @return
	 */
	public List<Object[]> getMercommentList(Map<String,Object> params);
	
	/**
	 * 我的订单 加载分页
	 * @param params
	 * @return
	 */
	public List<Object[]> getMyPayOrderByOpenid(Map<String,Object> params,int start,int size);
}
