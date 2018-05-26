package com.yjy.repository;

import java.util.List;

import org.hibernate.type.TrueFalseType;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.FinanceInfo;

public interface FinanceInfoDao
		extends PagingAndSortingRepository<FinanceInfo, Long>, JpaSpecificationExecutor<FinanceInfo> {

	@Query(nativeQuery = true, value = "select * from financeinfo")
	List<FinanceInfo> getAllFinanceInfo();

	@Query(nativeQuery = true, value = "select * from financeinfo fi where fi.state=1")
	List<FinanceInfo> getPublishedFinanceInfo();

	@Query(nativeQuery = true, value = "update financeinfo set count=count+?2 where id=?1")
	@Modifying
	void updateCount(Long id, int count);
}
