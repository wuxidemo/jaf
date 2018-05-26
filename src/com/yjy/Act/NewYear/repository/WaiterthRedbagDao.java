package com.yjy.Act.NewYear.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Act.NewYear.entity.WaiterthRedbag;

public interface WaiterthRedbagDao extends PagingAndSortingRepository<WaiterthRedbag, Long>,JpaSpecificationExecutor<WaiterthRedbag> {

	
}
