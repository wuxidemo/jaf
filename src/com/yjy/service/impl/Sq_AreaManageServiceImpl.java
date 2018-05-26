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

import com.yjy.entity.Sq_AreaManage;
import com.yjy.repository.Sq_AreaManageDao;
import com.yjy.service.Sq_AreaManageService;
import com.yjy.utils.Util;

@Component
@Transactional
public class Sq_AreaManageServiceImpl implements Sq_AreaManageService {
	
	@Autowired Sq_AreaManageDao areaManageDao;
	
	/**
	 * 根据条件获取Sq_areaManage集合
	 */
	@Override
	public Page<Sq_AreaManage> getAreaManageList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest=buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Sq_AreaManage> spec=Util.buildSpecification(searchParams, Sq_AreaManage.class);
		return areaManageDao.findAll(spec, pageRequest); 
	}
	/**
	 * 分页
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort=null;
		if("auto".equals(sortType)){
			sort=new Sort(Direction.DESC,"id");
		}
		sort=new Sort(Direction.DESC,"id");
		return new PageRequest(pageNumber-1, pageSize, sort);
	}

	@Override
	public Sq_AreaManage save(Sq_AreaManage sa) {
		// TODO Auto-generated method stub
		return areaManageDao.save(sa);
	}

	@Override
	public Sq_AreaManage get(Long id) {
		// TODO Auto-generated method stub
		return areaManageDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		areaManageDao.delete(id);
	}

	@Override
	public Boolean delete(String ids) {
		// TODO Auto-generated method stub
		String []id=ids.split("\\|");
		for (String i : id) {
			areaManageDao.delete(Long.parseLong(i));
		}
		return true;
	}
	@Override
	public List<Sq_AreaManage> pageList(int start, int size) {
		// TODO Auto-generated method stub
		return areaManageDao.pageList(start,size);
	}

}
