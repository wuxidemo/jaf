package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Apply;

public interface ApplyDao extends PagingAndSortingRepository<Apply, Long>,
		JpaSpecificationExecutor<Apply> {
	@Query(nativeQuery = true, value = " select count(a.id) from apply a where a.pid=?1")
	int getCountByServerType(Long sid);

	@Query(value = " from Apply where openid=?1")
	public List<Apply> getApplyByOpenid(String openid);
}