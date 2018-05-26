package com.yjy.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.LoginInfo;

/**
 * 类LoginInfoService.java的实现描述：实现LoginInfo的增删改查
 * @author zhangmengmeng 2015-4-20 上午10:21:25
 */
public interface LoginInfoService {


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
			int pageNumber, int pageSize, String sortType) ;

	/**
	 * 保存
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:35
	 * @param loginInfo
	 * @return
	 */
	public LoginInfo save(LoginInfo loginInfo) ;

	/**
	 * 更新
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:43
	 * @param loginInfo
	 * @return
	 */
	public LoginInfo update(LoginInfo loginInfo);

	/**
	 * 删除
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:50
	 * @param id
	 */
	public void delete(Long id) ;

	/**
	 * 获取单个信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:20:55
	 * @param id
	 * @return
	 */
	public LoginInfo get(Long id);

}
