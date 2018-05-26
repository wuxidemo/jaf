package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.FatherChildActivity;

public interface FatherChildActivityDao extends PagingAndSortingRepository<FatherChildActivity, Long>,
JpaSpecificationExecutor<FatherChildActivity>  {

	@Query(nativeQuery=true,value="select * from fatherchildactivity fca where fca.fatherid=?1")
	List<FatherChildActivity> findByFatherid(Long id);

	@Query(nativeQuery=true,value="select * from fatherchildactivity fca where fca.childid=?1")
	List<FatherChildActivity> findByChildid(Long id);
	
}
