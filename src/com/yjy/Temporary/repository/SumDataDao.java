package com.yjy.Temporary.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.SumData;

public interface SumDataDao extends PagingAndSortingRepository<SumData, Long>, JpaSpecificationExecutor<SumData>{

	@Query(value = " from SumData where name=?1")
	public SumData findNumByName(String name);
	
}
