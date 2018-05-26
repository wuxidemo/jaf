package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Advert;

public interface AdvertDao extends PagingAndSortingRepository<Advert, Long>,
		JpaSpecificationExecutor<Advert> {

	@Query(nativeQuery=true,value="select * from advert where type=?1")
	List<Advert> getList(String type);
	
	@Query(nativeQuery=true,value="select * from advert where type=?1 and title!=''")
	List<Advert> getListTitle(String type);
	
	
	/**********************************************/

	@Query(nativeQuery=true, value="select * from advert where type=?1")
	List<Advert> getAdListByType(String type);

}
