package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_Donation_Good;

/**
 * 类Sq_Donation_GoodDao.java的实现描述：对数据进程操作
 *
 */
public interface Sq_Donation_GoodDao
		extends PagingAndSortingRepository<Sq_Donation_Good, Long>, JpaSpecificationExecutor<Sq_Donation_Good> {

	/**
	 * 通过id获取相应的义仓商品
	 * 
	 * @param id
	 * @return
	 */
	@Query(nativeQuery = true, value = "select * from sq_donation_good where id=?1")
	Sq_Donation_Good getSq_Donation_GoodById(Long id);

	@Query(value = " from Sq_Donation_Good where community.id=?1")
	List<Sq_Donation_Good> getListByComid(Long comid);
	
	@Query(nativeQuery = true, value = "select * from sq_donation_good where num=?1")
	Sq_Donation_Good getSqDonatioGoodnByNum(String num);
}
