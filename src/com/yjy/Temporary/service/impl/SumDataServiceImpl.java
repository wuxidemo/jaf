package com.yjy.Temporary.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Temporary.entity.Servey;
import com.yjy.Temporary.entity.SumData;
import com.yjy.Temporary.repository.SumDataDao;
import com.yjy.Temporary.service.SumDataService;
import com.yjy.utils.Util;
@Component
@Transactional
public class SumDataServiceImpl implements SumDataService{
	
	@Autowired
	SumDataDao sumDataDao;
	
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
	public SumData save(SumData sumdata) {
		// TODO Auto-generated method stub
		return sumDataDao.save(sumdata);
	}

	@Override
	public SumData get(Long id) {
		// TODO Auto-generated method stub
		return sumDataDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		sumDataDao.delete(id);
	}

	@Override
	public Page<SumData> getSumData(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<SumData> spec = Util.buildSpecification(searchParams, SumData.class);
		return sumDataDao.findAll(spec, pageRequest);
	}

	@Override
	public SumData findNumByName(String name) {
		// TODO Auto-generated method stub
		return sumDataDao.findNumByName(name);
	}

}
