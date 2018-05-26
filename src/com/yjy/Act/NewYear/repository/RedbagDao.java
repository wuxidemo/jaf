package com.yjy.Act.NewYear.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Act.NewYear.entity.Redbag;

public interface RedbagDao extends PagingAndSortingRepository<Redbag, Long>,JpaSpecificationExecutor<Redbag> {

	
}
