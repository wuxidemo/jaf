/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.yjy.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.RebateRecord;

public interface RebateRecordDao
		extends PagingAndSortingRepository<RebateRecord, Long>, JpaSpecificationExecutor<RebateRecord> {

	@Query(value = " from RebateRecord where state=?1 and rebatecode is not null")
	public List<RebateRecord> getListByState(int state);

	@Query(value = " from RebateRecord where receiveopenid=?1 and (state=1 or state=2)")
	public List<RebateRecord> getListByOpenid(String openid);

	@Query(nativeQuery = true, value = "select count(*) from RebateRecord where state=?2 and createdate>?1")
	public int getCountByStateTime(Date time, int state);
}
