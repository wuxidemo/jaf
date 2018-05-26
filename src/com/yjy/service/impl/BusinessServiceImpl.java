package com.yjy.service.impl;

import java.util.HashMap;
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

import com.yjy.entity.Business;
import com.yjy.repository.BusinessDao;
import com.yjy.service.BusinessService;
import com.yjy.utils.Util;

/**
 * 类BusinessService.java的实现描述： Business 进下增删改查操作
 * 
 * @author zhangmengmeng 2015-3-28 下午3:27:19
 */
@Component
// 类中所有public函数都纳入事务管理的标识.
@Transactional
public class BusinessServiceImpl implements BusinessService {
	@Autowired
	private BusinessDao businessDao;

	/**
	 * 获取Business集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:43:09
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return Page<Business>
	 */
	public Page<Business> getBusinessList(
			Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Business> spec = Util.buildSpecification(
				searchParams, Business.class);
		return businessDao.findAll(spec, pageRequest);
	}

	/**
	 * 分页查询方法
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:43:27
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		sort = new Sort(Direction.ASC, "categoryValue.id").and(new Sort(Direction.DESC, "createtime"));
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	/**
	 * 获取Business集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:15:37
	 * @return
	 */
	public List<Business> getList() {
		List<Business> list = businessDao.getList();
		return list;
	}
	/**
	 * 根据商圈名称，字典项id获取business集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:17:12
	 * @param value
	 * @param cid
	 * @return
	 */
	public List<Business> getBusinessByName(String value, Long cid) {
		return businessDao.getBusinessByName(value, cid);
	}
	/**
	 * 更新Business对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:15:55
	 * @param Business
	 */
	public void SaveOrUpdate(Business Business) {
		businessDao.save(Business);
	}

	/**
	 * 删除Business对象。逻辑删除，状态设为1
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:16:10
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			businessDao.delete(Long.parseLong(i));
		}
		return true;
	}
	
	public List<Business> getBusinessListByDistrictid(Long districtid) {
		
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_categoryValue.id", districtid);
		Specification<Business> spec = Util.buildSpecification(
				searchParams, Business.class);
		
		List<Business> busilist = businessDao.findAll(spec);
		
		return busilist;
	}

	@Override
	public Business get(Long id) {
		// TODO Auto-generated method stub
		return businessDao.findOne(id);
	}

}
