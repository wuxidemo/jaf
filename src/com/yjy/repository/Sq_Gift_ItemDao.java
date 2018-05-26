package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_Gift_Item;

/**
 * 类Sq_Gift_ItemDao.java的实现描述：对数据进程操作
 */
public interface Sq_Gift_ItemDao
		extends PagingAndSortingRepository<Sq_Gift_Item, Long>, JpaSpecificationExecutor<Sq_Gift_Item> {

	@Query(nativeQuery = true, value = "select * from sq_gift_item where giftid=?1 order by id asc")
	List<Sq_Gift_Item> getSq_Gift_ItemByGift(Long giftid);
}
