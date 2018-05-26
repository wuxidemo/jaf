package com.yjy.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.LoginInfo;
import com.yjy.repository.LoginInfoDao;
import com.yjy.service.LoginInfoService;
import com.yjy.utils.Util;

/**
 * 类LoginInfoService.java的实现描述：实现LoginInfo的增删改查
 * @author zhangmengmeng 2015-4-20 上午10:21:25
 */
@Component
// 类中所有public函数都纳入事务管理的标识.
@Transactional
public class LoginInfoServiceImpl implements LoginInfoService{

	@Autowired
	private LoginInfoDao loginInfoDao;

	/**
	 * 获取用户信息 分页查询
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:16
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<LoginInfo> getLoginInfo(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<LoginInfo> spec = Util.buildSpecification(searchParams,
				LoginInfo.class);
		return loginInfoDao.findAll(spec, pageRequest);
	}

	/**
	 * 保存
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:35
	 * @param loginInfo
	 * @return
	 */
	public LoginInfo save(LoginInfo loginInfo) {
		return loginInfoDao.save(loginInfo);
	}

	/**
	 * 更新
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:43
	 * @param loginInfo
	 * @return
	 */
	public LoginInfo update(LoginInfo loginInfo) {
		return loginInfoDao.save(loginInfo);
	}

	/**
	 * 删除
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:50
	 * @param id
	 */
	public void delete(Long id) {
		loginInfoDao.delete(id);
	}

	/**
	 * 获取单个信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:55
	 * @param id
	 * @return
	 */
	public LoginInfo get(Long id) {
		return loginInfoDao.findOne(id);
	}

	/**
	 * 分页排序
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "logintime");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "title");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}
}
