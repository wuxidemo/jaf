package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MyDao;
import com.yjy.entity.Order;
import com.yjy.repository.OrderDao;
import com.yjy.service.OrderService;

@Component
@Transactional
public class OrderServiceImpl implements OrderService{
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private MyDao myDao;

	public Page<Order> getOrder(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Order>(myDao.getOrderByParam(searchParams, pageNumber, pageSize, order), pageRequest,
				myDao.getOrderCountByParam(searchParams));
	}

	public Page<Object[]> getOrderData(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(myDao.getOrderData(searchParams, pageNumber, pageSize, order), pageRequest,
				myDao.getOrderCountByParam(searchParams));
	}

	// public Page<Order> getOrder(Map<String, Object> searchParams,
	// int pageNumber, int pageSize, String sortType) {
	// PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
	// sortType);
	// Specification<Order> spec = Util.buildSpecification(searchParams,
	// Order.class);
	//
	// return orderDao.findAll(spec, pageRequest);
	// }

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} else if ("paytime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "paytime");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public Order getByCWXCode(String code) {
		return orderDao.getByCWXCode(code);
	}

	public Order getByCode(String code) {
		return orderDao.getByCode(code);
	}

	public Order update(Order o) {
		return orderDao.save(o);
	}

	public List<Order> getOrderByOpenid(String openid) {
		return orderDao.getOrderByOpenid(openid);
	}

	public Order get(Long id) {
		return orderDao.findOne(id);
	}
}
