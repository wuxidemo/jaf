package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.WXCard;

public interface WXCardDao extends PagingAndSortingRepository<WXCard, Long>, JpaSpecificationExecutor<WXCard> {
	@Query(value = " from WXCard where cardid=?1")
	public List<WXCard> getWXCardByCardid(String cardid);

	@Query(value = " update WXCard set nownum=nownum-1 where cardid=?1")
	@Modifying
	public void updatecount(String cardid);
	
	@Query(value=" from WXCard where mytype=?1 ")
	public List<WXCard> getListByMytype(int mytype);
	
	/*根据子商户id查找所有卡券*/
	@Query(nativeQuery = true, value="SELECT * from WXCard where wxmerchantid=?1  and ?2 BETWEEN createtime  AND  DATE_ADD(createtime,INTERVAL usetime DAY) ")
	public List<WXCard> getList(Long wxmerchantid,String date);

	
	/*根据领用数量来进行排序*/
	@Query(nativeQuery = true, value=" SELECT  * FROM (SELECTb.poi_id  as poid,GROUP_CONCAT(b.`name`) AS NAMElist,b.businessid  AS bus,a.locationids  as locat,a.`name` as name,a.id as id,a.logourl as log,a.createtime as time,a.usetime AS usettime,DATE_ADD(a.createtime,INTERVAL a.usetime DAY) FROM merchant b LEFT JOIN `wxcard`  a on a.locationids like CONCAT('%,',b.poi_id) OR a.locationids =b.poi_id OR a.locationids like CONCAT('%,',b.poi_id,',%') or a.locationids like CONCAT(b.poi_id,',%') where b.businessid = ?2 AND ( ?1 BETWEEN a.createtime  AND  DATE_ADD(a.createtime,INTERVAL a.usetime DAY) )GROUP BY a.id) as cRIGHT  JOIN ( SELECT id,(totalnum-nownum) AS a FROM wxcard WHERE ?1 BETWEEN createtime  AND  DATE_ADD(createtime,INTERVAL usetime DAY)  order by a desc) as d ON c.id=d.id")
	public List<Object> getListsum(String date ,int id);
	
	/*根据最新上架经行排序*/
	@Query(nativeQuery = true, value=" SELECT  * FROM (SELECT  b.poi_id  as poid,GROUP_CONCAT(b.`name`) AS NAMElist,b.businessid  AS bus,a.locationids  as locat,a.`name` as name,a.id as id,a.logourl as log,a.createtime as time,a.usetime AS usettime,DATE_ADD(a.createtime,INTERVAL a.usetime DAY) FROM merchant b LEFT JOIN `wxcard`  a on a.locationids like CONCAT('%,',b.poi_id) OR a.locationids =b.poi_id OR a.locationids like CONCAT('%,',b.poi_id,',%') or a.locationids like CONCAT(b.poi_id,',%') where b.businessid = ?2 AND ( ?1 BETWEEN a.createtime  AND  DATE_ADD(a.createtime,INTERVAL a.usetime DAY) )GROUP BY a.id) as c RIGHT  JOIN ( SELECT id FROM wxcard  WHERE ?1 BETWEEN createtime  AND  DATE_ADD(createtime,INTERVAL usetime DAY) order by createtime DESC) as d ON c.id=d.id")
	public List<Object> getdateList(String date,int id);
	
	/*根据折扣力度进行排序*/
	@Query(nativeQuery = true, value=" SELECT p.* FROM wxcard  p WHERE ?1 BETWEEN p.createtime  AND  DATE_ADD(p.createtime,INTERVAL p.usetime DAY) order by p.price desc;")
	public List<Object> getpriList(String date);
	
}