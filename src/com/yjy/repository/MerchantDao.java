package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Merchant;

public interface MerchantDao extends PagingAndSortingRepository<Merchant, Long>,
JpaSpecificationExecutor<Merchant> {
	
	@Query(nativeQuery=true,value="select count(*) from merchant where recommend=1")
	int getRecommendedNum();
	
	@Query(nativeQuery=true,value="select * from merchant where state=1")
	List<Merchant> getAllMerchant();
	
	@Query(nativeQuery=true,value="select * from merchant where recommend=1 and state=1")
	List<Merchant> getRecommend();
	
	@Query(nativeQuery=true,value="select * from merchant where poi_id=?1")
	List<Merchant> getMerchantByPoi_id(String poi_id);
	
	@Query(nativeQuery=true,value="select * from merchant where poi_id not in ?1")
	List<Merchant> getOtherMerchantListByPoi_ids(String poiids);
	
	@Query(nativeQuery = true, value = "select id from merchant")
	List<Integer> findAllmerId();
	
	@Modifying
	@Query(nativeQuery=true,value="update merchant set state=0 where id=?1")
	void setState(String idstrs);
	
	@Modifying
	@Query(nativeQuery=true,value="update user set enabled=0 where merchantid is not null and merchantid=?1")
	void disableUser(String idstrs);
	
	
	/*/根据传过来的商圈id,找到他商圈中的商户*/
	@Query(nativeQuery=true,value="select * from merchant where businessid=?1")
	List<Merchant> getOtherMerchantList(int id);
	
	
	/*根据传过来的商圈id,找到他商圈中的卡券*/
	@Query(nativeQuery=true,value="SELECT b.poi_id ,GROUP_CONCAT(b.`name`) as mernames,b.businessid,a.locationids,a.`name`,a.id,a.logourl,a.createtime,a.usetime,DATE_ADD(a.createtime,INTERVAL a.usetime DAY) FROM merchant b LEFT JOIN `wxcard`  a on a.locationids like CONCAT('%,',b.poi_id) OR a.locationids =b.poi_id OR a.locationids like CONCAT('%,',b.poi_id,',%') or a.locationids like CONCAT(b.poi_id,',%') where b.businessid = ?1 AND ( ?2 BETWEEN a.createtime  AND  DATE_ADD(a.createtime,INTERVAL a.usetime DAY) )GROUP BY a.id")
	List<Object> getcarList(int bus ,String date);
}
