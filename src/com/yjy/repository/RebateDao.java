/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.yjy.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Rebate;

public interface RebateDao extends PagingAndSortingRepository<Rebate, Long>, JpaSpecificationExecutor<Rebate> {

	@Query(nativeQuery = true, value = "select * from Rebate where state=1 and starttime<=?1 and date_add(endtime, INTERVAL 1 day)>=?1")
	public List<Rebate> getUseRebate(Date now);

	@Query(nativeQuery = true, value = " select count(*) FROM rebaterecord where createdate >=?1 and createdate<date_add(?1, INTERVAL 1 day) and type=2 and state!=0")
	// @Query(nativeQuery = true, value =
	// " select count(*) FROM rebaterecord where createdate >=?1 and
	// createdate<?2")
	public int getCountByopenid(Date time);

	@Query(nativeQuery = true, value = " select count(*) FROM rebaterecord where createdate >=?1 and createdate<date_add(?1, INTERVAL 1 day) and type=2 and state!=0 and receiveopenid=?2")
	public int getCountByOpenidTime(Date time, String openid);

	@Query(nativeQuery = true, value = "select * from Rebate order by  CASE when state=1 then 1 when state=0 then 2 else 3 end asc,starttime asc limit ?1,?2")
	public List<Rebate> getListPage(int start, int end);

	@Query(nativeQuery = true, value = " select count(*) from Rebate")
	public int getAllcount();

	@Query(value = " update Rebate r set r.state=?2 where r.id=?1", nativeQuery = true)
	@Modifying
	public void updatestate(Long id, int state);

	@Query(value = " update rebateforfirst r set r.state=?2 where r.id=?1", nativeQuery = true)
	@Modifying
	public void updatefstate(Long id, int state);

	@Query(nativeQuery = true, value = " select count(*) from rebate where state!=2 and( (starttime <=?1 AND endtime>=?1) or  (starttime <=?2 AND endtime>=?2) or (starttime>=?1 and endtime<=?2) or (starttime<=?1 and endtime>=?2)) ")
	public int getTimeCount(Date s, Date e);

	@Query(nativeQuery = true, value = " update  rebate  r set r.state=2 where r.endtime<?1 and r.state=1")
	@Modifying
	public void updateUnuse(Date now);

	@Query(nativeQuery = true, value = "select * from rebate")
	List<Rebate> findAllRebates();
}
