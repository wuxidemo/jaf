package com.yjy.Temporary.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.tmphb;

public interface tmphbDao extends PagingAndSortingRepository<tmphb, Long>, JpaSpecificationExecutor<tmphb> {

	@Query(value = " from tmphb where state=1")
	public List<tmphb> getList();
}
