/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.CategoryValue;

/**
 * 类CategoryValueDao.java的实现描述： 对CategoryValue进下数据库操作
 * 
 * @author zhangmengmeng 2015-3-28 下午3:27:07
 */
public interface CategoryValueDao extends
		PagingAndSortingRepository<CategoryValue, Long>,
		JpaSpecificationExecutor<CategoryValue> {
	/**
	 * 查询集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:23:48
	 * @param value
	 * @param cid
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from categoryvalue where state=0 and value=?1 and cid=?2")
	List<CategoryValue> getCategoryValueByValue(String value, Long cid);

	/**
	 * 删除对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:23:51
	 * @param id
	 */
	@Query(nativeQuery = true, value = "update categoryvalue set state=1 where id=?1")
	@Modifying
	void deleteCategoryValue(Long id);

	/**
	 * 删除对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:23:53
	 * @param id
	 */
	@Query(nativeQuery = true, value = "update categoryvalue set state=1 where pid=?1")
	@Modifying
	void deleteCategoryPid(Long id);

	/**
	 * 删除对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:23:57
	 * @param parseLong
	 */
	@Query(nativeQuery = true, value = "update categoryvalue set state=1 where cid=?1")
	@Modifying
	void deleteCategoryCid(Long parseLong);

	/**
	 * 查询集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:23:59
	 * @param pid
	 * @param state
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from categoryvalue where pid=?1 and state=?2 order by createtime desc")
	List<CategoryValue> getCategoryValueListByPid(Long pid, int state);

	/**
	 * 查询集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:24:02
	 * @param cid
	 * @param state
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from categoryvalue where cid=?1 and  pid is null and state=?2")
	List<CategoryValue> getCategoryValueListByCid(Long cid, int state);
	
}
