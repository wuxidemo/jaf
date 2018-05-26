package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.SqGiftRecord;
import com.yjy.entity.SqTmpOrder;

public interface SqTmpOrderDao
		extends PagingAndSortingRepository<SqTmpOrder, Long>, JpaSpecificationExecutor<SqTmpOrder> {

	@Query(value = " from SqTmpOrder where mycode=?1")
	public List<SqTmpOrder> getListByMycode(String code);
}
