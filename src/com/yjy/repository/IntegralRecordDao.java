package com.yjy.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.IntegralRecord;

public interface IntegralRecordDao
		extends PagingAndSortingRepository<IntegralRecord, Long>, JpaSpecificationExecutor<IntegralRecord> {

	@Query(value = " from IntegralRecord where openid=?1")
	public List<IntegralRecord> getListByOpenid(String openid);

	@Query(value = " from IntegralRecord where cardnum=?1 order by createtime desc")
	public List<IntegralRecord> getListByCardnum(String cardnum);

	@Query(nativeQuery = true, value = " SELECT SUM(count),cardnum,createtime,name,phone FROM integralrecord where createtime>=?1 and createtime<=?2 GROUP BY cardnum  ")
	public List<Object[]> getSumList(Date s, Date e);
}
