package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_AreaManage;

public interface Sq_AreaManageDao extends PagingAndSortingRepository<Sq_AreaManage, Long>, JpaSpecificationExecutor<Sq_AreaManage> {
	@Query(nativeQuery = true, value="select * from sq_areamanage where 1=1 limit ?1 , ?2")
	List<Sq_AreaManage> pageList(int start, int size);
	
	
}
