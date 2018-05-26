package com.yjy.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.WXMerchant;

public interface WXMerchantDao
		extends PagingAndSortingRepository<WXMerchant, Long>, JpaSpecificationExecutor<WXMerchant> {

	@Query(value = " from WXMerchant where merchantid=?1")
	public WXMerchant getByMerid(Long merid);
}
