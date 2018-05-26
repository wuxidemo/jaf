package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_QuickBuy;

public interface SqQuickBuyDao extends PagingAndSortingRepository<Sq_QuickBuy, Long>, JpaSpecificationExecutor<Sq_QuickBuy> {

	@Query(nativeQuery=true, value="select * from sq_qianggou")
	List<Sq_QuickBuy> getSq_QuickBuyList();

	@Query(nativeQuery=true, value="select * from sq_qianggou where state != 4 and position<=5 order by starttime asc")
	List<Sq_QuickBuy> getOnlineQuickBuyList();

}
