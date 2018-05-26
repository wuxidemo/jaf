package com.yjy.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Inrecord;
import com.yjy.repository.DataRecordDao;
import com.yjy.service.DataRecordService;
import com.yjy.utils.Util;

@Component
@Transactional
public class DataRecordServiceImpl implements DataRecordService{

	
	@Autowired
	private DataRecordDao dataRecordDao;

	public Page<Inrecord> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Inrecord> spec = Util.buildSpecification(searchParams, Inrecord.class);
		return dataRecordDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} /*
			 * else if("schoolorwork".equals(sortType)){ sort=new
			 * Sort(Direction.DESC,"schoolorwork"); }
			 */
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

}
