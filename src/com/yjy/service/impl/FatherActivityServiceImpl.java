package com.yjy.service.impl;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MyActivityDao;
import com.yjy.entity.FatherActivity;
import com.yjy.repository.FatherActivityDao;
import com.yjy.service.FatherActivityService;

@Component
@Transactional
public class FatherActivityServiceImpl implements FatherActivityService {
	
	@Autowired
	private FatherActivityDao fatherActivityDao;
	
	@Autowired
	private MyActivityDao myActivityDao;
	
	public Page<Object[]> getFatherActivitys(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(myActivityDao.getFatherActivityByParam(searchParams, pageNumber, pageSize, order), pageRequest,
				myActivityDao.getFatherActivityCountByParam(searchParams, pageNumber, pageSize, order));
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
	public FatherActivity save(FatherActivity fatherActivity) {
		// TODO Auto-generated method stub
		return fatherActivityDao.save(fatherActivity);
	}

	@Override
	public FatherActivity get(Long id) {
		// TODO Auto-generated method stub
		return fatherActivityDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		fatherActivityDao.delete(id);
	}
}

