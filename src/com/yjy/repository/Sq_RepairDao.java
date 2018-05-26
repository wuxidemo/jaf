package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_Repair;

public interface Sq_RepairDao extends PagingAndSortingRepository<Sq_Repair, Long>, JpaSpecificationExecutor<Sq_Repair> {

	@Query(nativeQuery = true, value = "select * from sq_repair where id=?1")
	List<Sq_Repair> getRepairById(Long id);

	@Query(nativeQuery = true, value = "select * from sq_repair where openid=?1 limit ?2, ?3")
	List<Sq_Repair> getRepairsByOpenid(String openid, int start, int size);

	@Query(nativeQuery = true, value = "select * from sq_repair where openid=?1 order by createtime desc limit ?2, ?3 ")
	List<Sq_Repair> getRepairByState0(String openid, int start, int size);

	@Query(nativeQuery = true, value = "select * from sq_repair where openid=?1 and state=4 order by createtime desc limit ?2, ?3 ")
	List<Sq_Repair> getRepairByState1(String openid, int start, int size);

	@Query(nativeQuery = true, value = "select * from sq_repair where openid=?1 and state<4 order by createtime desc limit ?2, ?3 ")
	List<Sq_Repair> getRepairByState2(String openid, int start, int size);
}
