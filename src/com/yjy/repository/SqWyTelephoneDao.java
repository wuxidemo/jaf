package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_Wy_Telephone;

public interface SqWyTelephoneDao extends PagingAndSortingRepository<Sq_Wy_Telephone, Long>, JpaSpecificationExecutor<Sq_Wy_Telephone> {

	@Query(value = " from Sq_Wy_Telephone where openid=?1")
	public List<Sq_Wy_Telephone> getListByOpenid(String openid);

	@Query(value = " from Sq_Wy_Telephone where telephone=?1")
	public List<Sq_Wy_Telephone> getListByTelephone(String telephone);

	@Query(nativeQuery=true,  value = "select count(*) from sq_wy_telephone where openid=?1")
	public int getCountByOpenid(String openid);
}
