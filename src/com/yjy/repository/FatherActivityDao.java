package com.yjy.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.FatherActivity;

public interface FatherActivityDao extends PagingAndSortingRepository<FatherActivity, Long>,
JpaSpecificationExecutor<FatherActivity>  {
	
}
