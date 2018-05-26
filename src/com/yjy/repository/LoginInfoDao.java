package com.yjy.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.LoginInfo;

public interface LoginInfoDao extends PagingAndSortingRepository<LoginInfo, Long>,
JpaSpecificationExecutor<LoginInfo>  {

}
