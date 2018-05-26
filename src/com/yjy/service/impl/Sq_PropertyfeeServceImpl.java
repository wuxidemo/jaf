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

import com.yjy.entity.Sq_Propertyfee;
import com.yjy.repository.Sq_PropertyfeeDao;
import com.yjy.service.Sq_PropertyfeeService;
import com.yjy.utils.Util;

/**
 * 类Sq_Propertyfee.java的实现描述：Sq_Propertyfee下的增删查改
 * 
 * @author liping
 *
 */
@Component
@Transactional
public class Sq_PropertyfeeServceImpl implements Sq_PropertyfeeService {

	@Autowired
	private Sq_PropertyfeeDao sq_PropertyfeeDao;

	@Override
	public Page<Sq_Propertyfee> getSqPropertyfee(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Sq_Propertyfee> spec = Util.buildSpecification(searchParams, Sq_Propertyfee.class);
		return sq_PropertyfeeDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else {
			sort = new Sort(Direction.DESC, "id");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public Sq_Propertyfee save(Sq_Propertyfee s) {
		return sq_PropertyfeeDao.save(s);
	}

	@Override
	public Sq_Propertyfee getById(Long id) {
		return sq_PropertyfeeDao.findOne(id);
	}

	@Override
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			sq_PropertyfeeDao.delete(Long.parseLong(i));
		}
		return true;
	}

	@Override
	public List<Sq_Propertyfee> getByTelephone(String telephone) {
		// TODO Auto-generated method stub
		return sq_PropertyfeeDao.getByTelephone(telephone);
	}

	public void updateStateById(Long id, int state) {
		sq_PropertyfeeDao.updateStateById(id, state);
	}

}
