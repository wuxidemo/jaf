package com.yjy.Act.NewYear.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Act.NewYear.entity.WaiterthRedbag;
import com.yjy.Act.NewYear.repository.WaiterthRedbagDao;
import com.yjy.Act.NewYear.service.WaiterthRedbagService;
import com.yjy.utils.Util;


@Component
@Transactional
public class WaiterthRedbagServiceImpl implements WaiterthRedbagService {

	@Autowired
	private WaiterthRedbagDao waiterthRedbagDao;

	@Override
	public WaiterthRedbag save(WaiterthRedbag waiterthRedbag) {
		// TODO Auto-generated method stub
		return waiterthRedbagDao.save(waiterthRedbag);
	}

	@Override
	public Page<WaiterthRedbag> getList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<WaiterthRedbag> spec = Util.buildSpecification(searchParams,
				WaiterthRedbag.class);
		return waiterthRedbagDao.findAll(spec, pageRequest);
	}
	
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "nickname");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}
	
}
