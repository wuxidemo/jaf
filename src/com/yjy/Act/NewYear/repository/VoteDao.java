package com.yjy.Act.NewYear.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;


import com.yjy.Act.NewYear.entity.Vote;


public interface VoteDao extends PagingAndSortingRepository<Vote, Long>,JpaSpecificationExecutor<Vote> {

	@Query(nativeQuery = true, value = "SELECT * FROM  vote  where name='双旦活动'")
	public List<Vote> changeVoteStage();
	
	@Query(nativeQuery = true, value = "SELECT * FROM  vote  where name='最美服务员'")
	public List<Vote> changeWaiterStage();
}
