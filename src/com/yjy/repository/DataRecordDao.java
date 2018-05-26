package com.yjy.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Inrecord;


public interface DataRecordDao extends PagingAndSortingRepository<Inrecord, Long>, JpaSpecificationExecutor<Inrecord>  {

}
