package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_Advert;

public interface SqAdvertDao extends PagingAndSortingRepository<Sq_Advert, Long>, JpaSpecificationExecutor<Sq_Advert> {

	@Query(nativeQuery = true, value = "select * from sq_advert where type=?1")
	List<Sq_Advert> getSqAdvertByType(int type);

	@Query(nativeQuery = true, value = "select * from sq_advert where comid=?1")
	List<Sq_Advert> getSqAdvertByComid(Long comid);
	
	@Modifying
	@Query(nativeQuery = true, value = "delete from sq_advert where comid=?1")
	void deleteByComid(Long comid);

}
