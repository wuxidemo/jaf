package com.yjy.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.WXUser;

public interface WXUserService {

	public Page<WXUser> getWXUser(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);

	public WXUser save(WXUser user);

	public WXUser update(WXUser user);

	public void delete(Long id);

	public WXUser get(Long id);

	public WXUser getUserByOpenid(String openid);

	public boolean isUser(String name);

	/**
	 * 
	 * 根据OPENID查询用户信息,如果不存在向微信查询
	 * 
	 * @author lyf
	 * @date 2015年6月17日 上午9:36:45
	 * @param openid
	 * @return
	 */
	public WXUser getOrNewWXUser(String openid);
	
	public int getAdCount();
	
	public int getJDCount();
	
	public int getTHCount();
}
