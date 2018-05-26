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

import com.yjy.entity.Sq_Advert;
import com.yjy.repository.SqAdvertDao;
import com.yjy.service.SqAdvertService;
import com.yjy.utils.Util;

@Component
@Transactional
public class SqAdvertServiceImpl implements SqAdvertService{
	
	@Autowired
	private SqAdvertDao sqAdvertDao;

	@Override
	public Page<Sq_Advert> getSqAdverts(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,sortType);
		Specification<Sq_Advert> spec = Util.buildSpecification(searchParams, Sq_Advert.class);
		return sqAdvertDao.findAll(spec, pageRequest);
	}
	
	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.ASC, "id");
		} else if ("name".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} 

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public Sq_Advert get(Long id) {
		// TODO Auto-generated method stub
		return sqAdvertDao.findOne(id);
	}

	@Override
	public Sq_Advert save(Sq_Advert sqAdvert) {
		// TODO Auto-generated method stub
		return sqAdvertDao.save(sqAdvert);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		sqAdvertDao.delete(id);
	}

	@Override
	public List<Sq_Advert> getSqAdvertByType(int type) {
		// TODO Auto-generated method stub
		return sqAdvertDao.getSqAdvertByType(type);
	}

	@Override
	public List<Sq_Advert> getSqAdvertByComid(Long comid) {
		// TODO Auto-generated method stub
		return sqAdvertDao.getSqAdvertByComid(comid);
	}

}
