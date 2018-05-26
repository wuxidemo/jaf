package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_QGOrder;

public interface SqQGOrderDao extends PagingAndSortingRepository<Sq_QGOrder, Long>,
JpaSpecificationExecutor<Sq_QGOrder>  {

	@Query(nativeQuery=true, value="select * from sq_qgorder where wxcode=?1")
	List<Sq_QGOrder> getOrderListByWXCode(String wxcode);

	@Query(nativeQuery=true, value="select * from sq_qgorder where openid=?1")
	List<Sq_QGOrder> getOrderListByOpenid(String openid);

	@Query(nativeQuery=true, value="select * from sq_qgorder where openid=?1 and actid=?2")
	List<Sq_QGOrder> getOrderListByOpenidAndActId(String openid, Long actid);
	
	
}
