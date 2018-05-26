package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.WXuserInfo;

public interface WXuserInfoDao
		extends PagingAndSortingRepository<WXuserInfo, Long>, JpaSpecificationExecutor<WXuserInfo> {
	@Query(value = "from WXuserInfo where openid=?1")
	public List<WXuserInfo> getInfoByOpenid(String openid);
	
	@Modifying
	@Query(nativeQuery = true, value="update WXuserInfo set name=?1 and phone=?2 and comid=?3 where id=?4")
	public WXuserInfo modifyWXuserInfo(String name,String phone,String commid,Long id);
	
}
