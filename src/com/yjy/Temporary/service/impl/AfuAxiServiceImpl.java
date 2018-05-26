package com.yjy.Temporary.service.impl;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Temporary.entity.AfuAxi;
import com.yjy.Temporary.repository.AfuAxiDao;
import com.yjy.Temporary.service.AfuAxiService;
import com.yjy.utils.Util;
@Component
@Transactional
public class AfuAxiServiceImpl implements AfuAxiService{
	
	@Autowired
	AfuAxiDao afuAxiDao;
	
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
	public AfuAxi save(AfuAxi afuAxi) {
		// TODO Auto-generated method stub
		return afuAxiDao.save(afuAxi);
	}

	@Override
	public AfuAxi get(Long id) {
		// TODO Auto-generated method stub
		return afuAxiDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		afuAxiDao.delete(id);
	}

	@Override
	public Page<AfuAxi> getAfuAxi(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<AfuAxi> spec = Util.buildSpecification(searchParams, AfuAxi.class);
		return afuAxiDao.findAll(spec, pageRequest);
	}

	@Override
	public AfuAxi add(String openid) {
		// TODO Auto-generated method stub
		
		AfuAxi af = afuAxiDao.findByOpenid(openid);
		if(af != null) {
			
			return null;
			
		}else{
			
			AfuAxi afuaxi = new AfuAxi();
			afuaxi.setOpenid(openid);
			afuaxi.setCreatetime(new Date());
			
			return this.save(afuaxi);
		}
		
	}

	@Override
	public int getTotal() {
		// TODO Auto-generated method stub
		return afuAxiDao.getTotal();
	}


}
