/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Business;

/**
 * 类BusinessDao.java的实现描述： 对数据库进程操作
 * 
 * @author zhangmengmeng 2015-3-28 下午3:29:01
 */
public interface BusinessDao extends
		PagingAndSortingRepository<Business, Long>,
		JpaSpecificationExecutor<Business> {

	/**
	 * 查询集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:21:59
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from business")
	List<Business> getList();
	
	@Query(nativeQuery = true, value = "select * from business where name=?1 and district=?2")
	List<Business> getBusinessByName(String name, Long cid);
	
}
