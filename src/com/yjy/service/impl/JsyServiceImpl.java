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

import com.yjy.entity.Jsy;
import com.yjy.repository.JsyDao;
import com.yjy.service.JsyService;
import com.yjy.utils.Util;

@Component
@Transactional
public class JsyServiceImpl implements JsyService{
	
	@Autowired
	private JsyDao jsyDao;
	
	public Page<Jsy> getJsys(
			Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Jsy> spec = Util.buildSpecification(
				searchParams, Jsy.class);
		return jsyDao.findAll(spec, pageRequest);
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
	
	public Jsy save(Jsy jsy) {
		return jsyDao.save(jsy);
	}
	
	public void delete(Long id) {
		jsyDao.delete(id);
	}
	
	public Jsy get(Long id) {
		return jsyDao.findOne(id);
	}
	
	public List<Jsy> getJsyByTelephone(String telephone) {
		return jsyDao.getJsyByTelephone(telephone);
	}
}
