package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MySq_Donation_GoodDao;
import com.yjy.entity.Community;
import com.yjy.entity.Sq_Donation_Good;
import com.yjy.repository.Sq_Donation_GoodDao;
import com.yjy.service.Sq_Donation_GoodService;
import com.yjy.utils.Util;

@Component
@Transactional
public class Sq_Donation_GoodServiceImpl implements Sq_Donation_GoodService {

	@Autowired
	private Sq_Donation_GoodDao sq_Donation_GoodDao;
	@Autowired
	private MySq_Donation_GoodDao mySq_Donation_GoodDao;
	@Override
	public Page<Sq_Donation_Good> getSq_Donation_GoodServiceList(Map<String, Object> params, int pageNumber,
			int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Sq_Donation_Good> spec = Util.buildSpecification(params, Sq_Donation_Good.class);
		return sq_Donation_GoodDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {

		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public Sq_Donation_Good getSq_Donation_GoodById(Long id) {
		return sq_Donation_GoodDao.getSq_Donation_GoodById(id);
	}

	@Override
	public Sq_Donation_Good save(Sq_Donation_Good sq_Donation_Good) {
		return sq_Donation_GoodDao.save(sq_Donation_Good);
	}

	@Override
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			sq_Donation_GoodDao.delete(Long.parseLong(i));
		}
		return true;
	}

	public List<Sq_Donation_Good> getListByComid(Long comid) {
		return sq_Donation_GoodDao.getListByComid(comid);
	}

	@Override
	public Sq_Donation_Good getSqDonatioGoodnByNum(String num) {
		return sq_Donation_GoodDao.getSqDonatioGoodnByNum(num);
	}
/*以下物品记录*/
	@Override
	public Page<Object[]> getSq_Donation_Goods(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType, Community c) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(mySq_Donation_GoodDao.getSq_Donation_Goods(searchParams, pageNumber, pageSize, order,c),
				pageRequest, mySq_Donation_GoodDao.getSq_Donation_GoodsCount(searchParams,c));
	}

	@Override
	public List<Object[]> getSq_Donation_GoodById1(Long id) {
		return mySq_Donation_GoodDao.getSq_Donation_GoodById(id);
	}

}
