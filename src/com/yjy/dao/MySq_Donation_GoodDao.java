package com.yjy.dao;

import java.util.List;
import java.util.Map;

import com.yjy.entity.Community;

public interface MySq_Donation_GoodDao {

	/* 以下商品记录 */
	public List<Object[]> getSq_Donation_Goods(Map<String, Object> params, int start, int size, String order,Community c);

	public int getSq_Donation_GoodsCount(Map<String, Object> params,Community c);
	
	public List<Object[]> getSq_Donation_GoodById(Long id);

}
