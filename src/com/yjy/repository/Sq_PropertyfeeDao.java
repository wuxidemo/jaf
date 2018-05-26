package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_Propertyfee;

public interface Sq_PropertyfeeDao
		extends PagingAndSortingRepository<Sq_Propertyfee, Long>, JpaSpecificationExecutor<Sq_Propertyfee> {

	@Query(nativeQuery = true, value = "select * from sq_propertyfee where telephone=?1 order by comid DESC")
	List<Sq_Propertyfee> getByTelephone(String telephone);

	@Query(nativeQuery = true, value = " update sq_propertyfee set state=?2 where id=?1")
	@Modifying
	void updateStateById(Long id, int state);

}
