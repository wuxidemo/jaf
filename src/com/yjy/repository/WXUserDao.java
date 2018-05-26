package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.WXUser;

public interface WXUserDao extends PagingAndSortingRepository<WXUser, Long>,
		JpaSpecificationExecutor<WXUser> {
	@Modifying
	@Query(nativeQuery = true, value = "select * from wxuser where openid=?1")
	public List<WXUser> getUserByOpenid(String openid);

	@Query(nativeQuery = true, value = " select count(*) from user where name=?1")
	public int isUser(String name);
	
	@Query(nativeQuery = true, value = " select count(*) from wxuser where fromact= 'gzjaf' ")
	public int getAdCount();
	
	@Query(nativeQuery = true, value = " select count(*) from wxuser where fromact like 'jiangda%' ")
	public int getJDCount();
	
	@Query(nativeQuery = true, value = " select count(*) from wxuser where fromact like 'taihu%' ")
	public int getTHCount();
}
