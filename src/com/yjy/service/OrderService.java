package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Order;

public interface OrderService {

	public Page<Order> getOrder(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
		

	public Page<Object[]> getOrderData(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) ;



	public Order getByCWXCode(String code);

	public Order getByCode(String code);

	public Order update(Order o) ;

	public List<Order> getOrderByOpenid(String openid) ;
	public Order get(Long id) ;
}
