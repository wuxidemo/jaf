package com.yjy.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.PushMsg;

public interface PushMsgDao extends PagingAndSortingRepository<PushMsg, Long>, JpaSpecificationExecutor<PushMsg> {

}
