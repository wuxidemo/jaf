package com.yjy.Act.NewYear.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Act.NewYear.entity.Vote;
import com.yjy.Act.NewYear.repository.VoteDao;
import com.yjy.Act.NewYear.service.VoteService;

@Component
@Transactional
public class VoteServiceImpl implements VoteService {

	@Autowired
	private VoteDao voteDao;

	public int getNewYearStage() {
		return voteDao.findOne(1l).getStage();
	}
	
	public int getWaiterStage() {
		return voteDao.findOne(2l).getStage();
	}
	
	public Vote changeVoteStage(){
		List<Vote> votelist = voteDao.changeVoteStage();
		if(votelist != null && votelist.size() > 0) {
			return votelist.get(0);
		}
		return null;
	}
	
	public Vote changeWaiterStage(){
		List<Vote> votelist = voteDao.changeWaiterStage();
		if(votelist != null && votelist.size() > 0) {
			return votelist.get(0);
		}
		return null;
	}
	
	public Vote save(Vote vote){
		
		return voteDao.save(vote);
	}
}
