package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Jsy;

public interface JsyDao extends PagingAndSortingRepository<Jsy, Long>,
JpaSpecificationExecutor<Jsy> {
	
	@Query(nativeQuery=true,value="select * from jsy where telephone=?1")
	List<Jsy> getJsyByTelephone(String telephone);

}
