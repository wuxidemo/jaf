package com.yjy.Act.NewYear.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Act.NewYear.entity.WaiterRedbag;

public interface WaiterRedbagDao extends PagingAndSortingRepository<WaiterRedbag, Long>,JpaSpecificationExecutor<WaiterRedbag> {
	
	@Query(nativeQuery = true, value = "SELECT * FROM  waiterredbag where openid=?1 and fromopenid=?2")
	public List<WaiterRedbag> findByOpenidAndFromOpenid(String openid, String fromopenid);
	
}
