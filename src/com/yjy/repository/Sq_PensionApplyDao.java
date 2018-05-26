package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_PensionApply;

public interface Sq_PensionApplyDao
		extends PagingAndSortingRepository<Sq_PensionApply, Long>, JpaSpecificationExecutor<Sq_PensionApply> {

	@Query(nativeQuery = true, value = "select * from sq_pensionapply where openid=?1")
	public Sq_PensionApply getPensionApplyByOpenid(String openid);

	@Query(nativeQuery = true, value="select * from sq_pensionapply where sqactid=?1 and  openid=?2")
	List<Sq_PensionApply> getPenActListByOpenAndAct(Long sqactid,String openid);
	
	@Query(nativeQuery = true, value="select * from sq_pensionapply where sqactid=?1")
	List<Sq_PensionApply> getPenApplyListBySqactid(Long sqactid);
}
