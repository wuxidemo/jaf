/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.yjy.repository;

import java.util.List;

import com.yjy.entity.CategoryType;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 类CategoryTypeDao.java的实现描述： 对数据库进程操作
 * 
 * @author zhangmengmeng 2015-3-28 下午3:29:01
 */
public interface CategoryTypeDao extends
		PagingAndSortingRepository<CategoryType, Long>,
		JpaSpecificationExecutor<CategoryType> {

	/**
	 * 查询集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:21:59
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from categorytype where state=0")
	List<CategoryType> getList();

	/**
	 * 删除数据
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:22:02
	 * @param id
	 */
	@Query(nativeQuery = true, value = "update categorytype  set state=1 where id=?1")
	@Modifying
	void deleteCategoryType(Long id);

	/**
	 * 查询集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:22:04
	 * @param value
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from categorytype where state=0 and value=?1")
	List<CategoryType> findByValue(String value);
}
