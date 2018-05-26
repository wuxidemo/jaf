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

import com.yjy.entity.Sq_UserAccessControl;
import com.yjy.repository.Sq_UserAccessControlDao;
import com.yjy.service.Sq_UserAccessControlService;
import com.yjy.utils.Util;

@Component
@Transactional
public class Sq_UserAccessControlServiceImpl implements Sq_UserAccessControlService {

	@Autowired
	Sq_UserAccessControlDao accessControlDao;

	@Override
	public Page<Sq_UserAccessControl> getList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Sq_UserAccessControl> spec = Util.buildSpecification(searchParams, Sq_UserAccessControl.class);
		return accessControlDao.findAll(spec, pageRequest);
	}

	/**
	 * 分页方法
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		}
		sort = new Sort(Direction.DESC, "id");
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public Sq_UserAccessControl get(Long id) {
		// TODO Auto-generated method stub
		return accessControlDao.findOne(id);
	}

	@Override
	public Sq_UserAccessControl save(Sq_UserAccessControl accessControl) {
		// TODO Auto-generated method stub
		return accessControlDao.save(accessControl);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		accessControlDao.delete(id);
	}

	@Override
	public List<Sq_UserAccessControl> getListByOpenid(String openid) {
		// TODO Auto-generated method stub
		return accessControlDao.getListByOpenid(openid);
	}

	@Override
	public boolean delete(String ids) {
		// TODO Auto-generated method stub
		String[] id = ids.split("\\|");
		for (String i : id) {
			accessControlDao.delete(Long.parseLong(i));
		}
		return true;
	}

}
