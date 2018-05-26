package com.yjy.Temporary.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Temporary.entity.Servey;

public interface ServeyDao extends PagingAndSortingRepository<Servey, Long>, JpaSpecificationExecutor<Servey>{

	@Query(value = " from Servey where openid=?1")
	public List<Servey> findByOpenid(String openid);
	
	@Query(value = " from Servey where phone=?1")
	public List<Servey> findByPhone(String phone);
	
	@Query(nativeQuery = true, value = "select count(*) from servey s where s.openid=?1")
	public int findCountByOpenid(String openid);
	
	@Query(nativeQuery = true, value = "select count(*) from servey")
	public int getTotalCount();
	
	@Query(nativeQuery = true, value = "select * from servey order by id desc limit 0,1")
	public Servey getLastServey();
	
	@Query(nativeQuery = true, value = "select count(*) from servey where id<?1")
	public int idLessCount(Long id);
	
	@Query(nativeQuery = true, value = "select rank,nickname,phone,acttime,openid from servey")
	public List<Object[]> gatAllServey();
	
	@Query(nativeQuery = true, value = "select count(*) from servey where wuxi=1")
	public int countTotalWuxi();
	
}
