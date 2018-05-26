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

import com.yjy.Act.NewYear.entity.Redbag;
import com.yjy.Act.NewYear.repository.RedbagDao;
import com.yjy.Act.NewYear.service.RedbagService;
import com.yjy.utils.Util;


@Component
@Transactional
public class RedbagServiceImpl implements RedbagService {

	@Autowired
	private RedbagDao redbagDao;

	@Override
	public Redbag save(Redbag redbag) {
		// TODO Auto-generated method stub
		return redbagDao.save(redbag);
	}

	@Override
	public Page<Redbag> getList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Redbag> spec = Util.buildSpecification(searchParams,
				Redbag.class);
		return redbagDao.findAll(spec, pageRequest);
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
