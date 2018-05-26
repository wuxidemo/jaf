package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Sq_UserAccessControl;

public interface Sq_UserAccessControlService {
	/**
	 * 查询分页
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Sq_UserAccessControl> getList(Map<String, Object>searchParams,int pageNumber,int pageSize,String sortType);
	/**
	 * 根据id获取实体
	 * @param id
	 * @return
	 */
	public Sq_UserAccessControl get(Long id);
	/**
	 * 保存
	 * @param accessControl
	 * @return
	 */
	public Sq_UserAccessControl save(Sq_UserAccessControl accessControl);
	/**
	 * 删除
	 * @param id
	 */
	public void delete(Long id);
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);
	/**
	 * 根据openid获取集合
	 * @param openid
	 * @return
	 */
	public List<Sq_UserAccessControl> getListByOpenid(String openid);
	
	
}
