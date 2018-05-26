package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Sq_QGOrder;

public interface SqQGOrderService {
	
	public Page<Sq_QGOrder> getQGOrders(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType);
	
	public Sq_QGOrder save(Sq_QGOrder sq_QGOrder);
	
	public Sq_QGOrder get(Long id);
	
	public void delete(Long id);
	
	public List<Sq_QGOrder> getOrderListByWXCode(String wxcode);
	
	public List<Sq_QGOrder> getOrderListByOpenid(String openid);
	
	public List<Sq_QGOrder> getOrderListByOpenidAndActId(String openid, Long actid);
	
}
