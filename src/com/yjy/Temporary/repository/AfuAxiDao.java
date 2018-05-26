package com.yjy.Temporary.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.AfuAxi;

public interface AfuAxiDao extends PagingAndSortingRepository<AfuAxi, Long>, JpaSpecificationExecutor<AfuAxi>{

	@Query(value = " from AfuAxi where openid=?1")
	public AfuAxi findByOpenid(String openid);
	
	@Query(nativeQuery = true, value = "select count(*) from afuaxi")
	public int getTotal();
	
}
