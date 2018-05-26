package com.yjy.Temporary.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.PopularityRecord;

public interface PopularityRecordDao
		extends PagingAndSortingRepository<PopularityRecord, Long>, JpaSpecificationExecutor<PopularityRecord> {

	@Query(nativeQuery = true, value = " select count(*) from act_popularityrecord where fromopenid=?1")
	public int getFromCount(String openid);

	@Query(value = "  from PopularityRecord where fromopenid=?1 and score=?2 and fromopenid!=openid")
	public PopularityRecord getByFromopenid(String openid, int score);

	@Query(nativeQuery = true, value = "select count(*) from act_popularityrecord where openid=?1 and fromopenid=?1")
	public int getCountByOpenid(String openid);
}
