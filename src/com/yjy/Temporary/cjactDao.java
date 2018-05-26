package com.yjy.Temporary;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.yjy.entity.Advert;

public interface cjactDao extends PagingAndSortingRepository<cjact, Long>, JpaSpecificationExecutor<cjact> {
	@Query(value = " select count(*) from cjact where openid=?1")
	public int getcount(String openid);

	@Query(value = " select count(*) from cjact ")
	public int getAllcount();
}
