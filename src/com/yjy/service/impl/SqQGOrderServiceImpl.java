package com.yjy.service.impl;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Sq_QGOrder;
import com.yjy.repository.SqQGOrderDao;
import com.yjy.service.SqQGOrderService;
import com.yjy.utils.Util;

@Component
@Transactional
public class SqQGOrderServiceImpl implements SqQGOrderService {
	
	@Autowired
	private SqQGOrderDao sqQGOrderDao;

	@Override
	public Page<Sq_QGOrder> getQGOrders(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Sq_QGOrder> spec = Util.buildSpecification(
				searchParams, Sq_QGOrder.class);
		return sqQGOrderDao.findAll(spec, pageRequest);
	}
	
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public Sq_QGOrder save(Sq_QGOrder sq_QGOrder) {
		// TODO Auto-generated method stub
		return sqQGOrderDao.save(sq_QGOrder);
	}

	@Override
	public Sq_QGOrder get(Long id) {
		// TODO Auto-generated method stub
		return sqQGOrderDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		sqQGOrderDao.delete(id);
	}

	@Override
	public List<Sq_QGOrder> getOrderListByWXCode(String wxcode) {
		// TODO Auto-generated method stub
		return sqQGOrderDao.getOrderListByWXCode(wxcode);
	}

	@Override
	public List<Sq_QGOrder> getOrderListByOpenid(String openid) {
		// TODO Auto-generated method stub
		return sqQGOrderDao.getOrderListByOpenid(openid);
	}

	@Override
	public List<Sq_QGOrder> getOrderListByOpenidAndActId(String openid, Long actid) {
		// TODO Auto-generated method stub
		return sqQGOrderDao.getOrderListByOpenidAndActId(openid, actid);
	}
	
}

