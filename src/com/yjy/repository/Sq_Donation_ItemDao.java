package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_Donation_Item;

/**
 * 类Sq_Donation_ItemDao.java的实现描述：对数据进程操作
 * 
 * @author liping
 *
 */
public interface Sq_Donation_ItemDao
		extends PagingAndSortingRepository<Sq_Donation_Item, Long>, JpaSpecificationExecutor<Sq_Donation_Item> {

	@Query(nativeQuery = true, value = "select * from sq_donation_item where donationid=?1 order by id asc")
	List<Sq_Donation_Item> getSq_Donation_ItemBydonation(Long donationid);
}
