package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_UserAccessControl;

public interface Sq_UserAccessControlDao extends PagingAndSortingRepository<Sq_UserAccessControl, Long>,JpaSpecificationExecutor<Sq_UserAccessControl>{
	@Query(nativeQuery = true, value="select * from sq_useraccesscontrol where openid=?1")
	List<Sq_UserAccessControl> getListByOpenid(String openid);
}
