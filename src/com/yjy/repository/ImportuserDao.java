package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Inuser;

public interface ImportuserDao extends PagingAndSortingRepository<Inuser, Long>, JpaSpecificationExecutor<Inuser> {

	@Query(nativeQuery = true, value = "select * from inuser u where u.cardnum=?1")
	List<Inuser> findBycardnum(String cardnum);
	
	@Query(nativeQuery = true, value = "select * from inuser u where u.name=?1 and u.cardnum=?2")
	List<Inuser> findByNameAndCardNumber(String name, String cardnum);
	
	@Query(nativeQuery = true, value = "select count(*) from inuser u where u.openid=?1")
	int getCountByOpenid(String openid);

	@Query(nativeQuery = true, value = " update inuser set point=point-?2 where id=?1")
	@Modifying
	void updatePoint(Long id, int count);

	@Query(value = "from Inuser where openid=?1")
	List<Inuser> getUseListByOpenid(String openid);
	
	@Query(nativeQuery = true, value = "select * from inuser u where u.cardnum=?1")
	Inuser findByname(String cardnum);
	
	@Query(nativeQuery = true, value = "delete  from inuser where cardnum=?1")
	@Modifying
	void delet(String cardnum);
}
