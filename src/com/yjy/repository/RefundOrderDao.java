package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Payorder;
import com.yjy.entity.RefundOrder;

public interface RefundOrderDao
		extends PagingAndSortingRepository<RefundOrder, Long>, JpaSpecificationExecutor<RefundOrder> {

	@Query(value = "from RefundOrder where state=1")
	public List<RefundOrder> getListByState();
}
