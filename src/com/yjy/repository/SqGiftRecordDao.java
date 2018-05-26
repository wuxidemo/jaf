package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.SqGiftRecord;

/**
 * 类SqGiftRecordDao.java的实现描述：对数据进程操作
 *
 */
public interface SqGiftRecordDao extends PagingAndSortingRepository<SqGiftRecord, Long>, JpaSpecificationExecutor<SqGiftRecord>  {

	@Query(nativeQuery=true,value="select * from sq_giftrecord where id=?1")
	SqGiftRecord getSqGiftRecordById(Long id);

	@Query(nativeQuery=true,value="select * from sq_giftrecord where comid=?1")
	List<SqGiftRecord> getSqGiftRecordByComid(Long comid);

	@Query(nativeQuery=true,value="select * from sq_giftrecord where phone=?1")
	List<SqGiftRecord> getSqDonationByPhoneNo(String phoneno);
	
	@Query(nativeQuery=true,value="select * from sq_giftrecord where num=?1")
	SqGiftRecord getSqGiftRecordByNum(String num);
}
