package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Sq_AreaManage;

public interface Sq_AreaManageService {
	/**
	 * 根据条件查询网格列表
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Sq_AreaManage> getAreaManageList(Map<String, Object> searchParams, int pageNumber,int pageSize,String sortType);
	/**
	 * 保存
	 * @param sa
	 * @return
	 */
	public Sq_AreaManage save(Sq_AreaManage sa);
	/**
	 * 根据id获得网格记录
	 * @param id
	 * @return
	 */
	public Sq_AreaManage get(Long id);
	/**
	 * 根据id删除
	 * @param id
	 */
	public void delete(Long id);
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	public Boolean delete(String ids);
	/**
	 * 分页查询方法
	 * @param start
	 * @param size
	 * @return
	 */
	public List<Sq_AreaManage> pageList(int start, int size);
	
}
