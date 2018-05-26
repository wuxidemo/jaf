package com.yjy.Temporary.service.impl;

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

import com.yjy.Temporary.entity.Servey;
import com.yjy.Temporary.repository.ServeyDao;
import com.yjy.Temporary.service.ServeyService;
import com.yjy.utils.Util;
@Component
@Transactional
public class ServeyServiceImpl implements ServeyService{
	
	@Autowired
	ServeyDao serveyDao;

	@Override
	public Servey findByOpenid(String openid) {
		// TODO Auto-generated method stub
		
		List<Servey> serlist = serveyDao.findByOpenid(openid);
		
		if(serlist != null && serlist.size() > 0) {
			return serlist.get(0);
		}
		
		return null;
	}

	@Override
	public int findCountByOpenid(String openid) {
		// TODO Auto-generated method stub
		return serveyDao.findCountByOpenid(openid);
	}

	@Override
	public Servey save(Servey servey) {
		// TODO Auto-generated method stub
		return serveyDao.save(servey);
	}

	@Override
	public Servey get(Long id) {
		// TODO Auto-generated method stub
		return serveyDao.findOne(id);
	}

	@Override
	public Page<Servey> getServey(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Servey> spec = Util.buildSpecification(searchParams, Servey.class);
		return serveyDao.findAll(spec, pageRequest);
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
	public Servey getLastServey() {
		// TODO Auto-generated method stub
		return serveyDao.getLastServey();
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return serveyDao.getTotalCount();
	}

	@Override
	public Servey findByPhone(String phone) {
		// TODO Auto-generated method stub
		List<Servey> serlist = serveyDao.findByPhone(phone.trim());
		if(serlist != null && serlist.size() > 0) {
			return serlist.get(0);
		}
		
		return null;
	}

	@Override
	public int idLessCount(Long id) {
		// TODO Auto-generated method stub
		return serveyDao.idLessCount(id);
	}

	@Override
	public List<Object[]> gatAllServey() {
		// TODO Auto-generated method stub
		return serveyDao.gatAllServey();
	}

	@Override
	public int countTotalWuxi() {
		// TODO Auto-generated method stub
		return serveyDao.countTotalWuxi();
	}

}
