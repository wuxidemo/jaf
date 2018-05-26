package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Payorder;

public interface PayorderDao extends PagingAndSortingRepository<Payorder, Long>, JpaSpecificationExecutor<Payorder> {

	@Query(nativeQuery = true, value = "select * from payorder where ?1=DATE_FORMAT(createtime,'%Y%m%d') and merchantid=?2 and paytype=?3 order by createtime desc")
	List<Payorder> getPayorders(String createtime, Long merchantid, String paytype);

	@Query(nativeQuery = true, value = "select * from payorder where ?1=DATE_FORMAT(createtime,'%Y%m%d') and merchantid=?2 order by createtime desc")
	List<Payorder> getAllPayorders(String createtime, Long merchantid);

	@Query(value = " from Payorder where ordernum=?1")
	List<Payorder> getByOrdernum(String ordernum);
	
	@Query(nativeQuery=true,value="select * from payorder where ordernum=?1")
	Payorder findByOrdernum(String ordernum);
}
