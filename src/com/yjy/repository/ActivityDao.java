package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Activity;

public interface ActivityDao extends PagingAndSortingRepository<Activity, Long>,
JpaSpecificationExecutor<Activity>  {
	
	@Query(nativeQuery=true,value="select * from activity u where u.state=?1")
	List<Activity> getActivityByState(int state);

	@Query(nativeQuery=true,value="select * from activity")
	List<Activity> getAllActivity();
	
}
