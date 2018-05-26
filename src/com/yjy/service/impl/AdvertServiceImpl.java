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

import com.yjy.entity.Advert;
import com.yjy.repository.AdvertDao;
import com.yjy.service.AdvertService;
import com.yjy.utils.Util;

/**
 * 类AdvertService.java的实现描述：Advert 进下增删改查操作
 * 
 * @author zhangmengmeng 2015-6-16 下午2:10:48
 */
@Component
// 类中所有public函数都纳入事务管理的标识.
@Transactional
public class AdvertServiceImpl implements AdvertService{

	@Autowired
	private AdvertDao advertDao;

	/**
	 * 更新保存信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-16 下午2:31:52
	 * @param advert
	 */
	public void SaveOrUpdate(Advert advert) {
		// TODO Auto-generated method stub
		advertDao.save(advert);
	}

	/**
	 * 删除信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-16 下午2:32:03
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			advertDao.delete(Long.parseLong(i));
		}
		return true;
	}

	public List<Advert> getListTitle(String type) {
		// TODO Auto-generated method stub
		return advertDao.getListTitle(type);
	}
	public List<Advert> getList(String type) {
		// TODO Auto-generated method stub
		return advertDao.getList(type);
	}
	public Advert findOne(String id) {
		// TODO Auto-generated method stub
		return advertDao.findOne(Long.parseLong(id));
	}

	public Page<Advert> getAdvertList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Advert> spec = Util.buildSpecification(
				searchParams, Advert.class);
		return advertDao.findAll(spec, pageRequest);
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
	
	/*********************************************/

	@Override
	public List<Advert> getAdListByType(String type) {
		// TODO Auto-generated method stub
		return advertDao.getAdListByType(type);
	}
}
