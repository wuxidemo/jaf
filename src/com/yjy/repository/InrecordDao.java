package com.yjy.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Inrecord;



public interface InrecordDao extends PagingAndSortingRepository<Inrecord, Long>,
JpaSpecificationExecutor<Inrecord>{

	
	@Query(nativeQuery=true,value="select * from inrecord u where u.record=?1")
	Inrecord findByrecord(String record);
}
