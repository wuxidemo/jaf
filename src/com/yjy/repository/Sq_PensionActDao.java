package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_PensionAct;

public interface Sq_PensionActDao extends PagingAndSortingRepository<Sq_PensionAct, Long>,
JpaSpecificationExecutor<Sq_PensionAct>{

	@Query(nativeQuery=true,value="SELECT * FROM sq_pensionact WHERE 1=1 order by createtime desc , id desc ")
	List<Sq_PensionAct> getAllSqPensionAct();
	
	@Query(nativeQuery = true, value="select * from sq_pensionact where state<>0 and state<>3 order by createtime desc limit ?1,?2")
	List<Sq_PensionAct> getPensionActList(int start, int size);
	
	@Query(nativeQuery = true, value="select * from sq_pensionact where state<>0 order by createtime desc")
	List<Sq_PensionAct> getOnLineActs();
}
