package com.yjy.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Merchant;
import com.yjy.entity.WXUser;
import com.yjy.entity.WXUserRecord;

public interface WXUserRecordDao extends PagingAndSortingRepository<WXUserRecord, Long>,
		JpaSpecificationExecutor<WXUserRecord> {
	
	
	@Query(nativeQuery=true,value="select * from wxuserrecord where key1=?1")
	List<WXUserRecord> getallwxusercord(String key);
	
	
	
  /* 根据key1查询当天的记录		*/
	@Query(nativeQuery=true,value="SELECT * FROM wxuserrecord WHERE (DATE_FORMAT(createtime,'%Y-%m-%d')=CURDATE())AND key1=?1")
	List<WXUserRecord> getallwxusercord1(String key);
	
	
  /*根据传进来的key1查询最近七天的记录*/
	@Query(nativeQuery=true,value="SELECT * FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 7 DAY),'%Y-%m-%d') AND  CURDATE()) AND key1=?1")
	List<WXUserRecord> getallwxusercord2(String key);
	
  /*根据传进来的key1查询最近30天的记录*/
	@Query(nativeQuery=true,value="SELECT * FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 30 DAY),'%Y-%m-%d') AND  CURDATE()) AND key1=?1")
	List<WXUserRecord> getallwxusercord3(String key);
	
  /*更据传入的开始和结束时间查询数据*/
	
	@Query(nativeQuery=true,value="SELECT * FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 ) AND key1=?3")
	List<WXUserRecord> getallwxusercord4(Date start,Date end ,String key);
	
	
/* =========== 商户点击查询	*/
	/*查询商户所有的击量*/
	@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) AS zom FROM wxuserrecord WHERE  type='merchant' group by key1")
	List<Object> getallmerchant();
	
	
	/*查询商户当天的点击量*/
	@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) AS zom FROM wxuserrecord WHERE (DATE_FORMAT(createtime,'%Y-%m-%d')=CURDATE())AND type='merchant' group by key1")
	List<Object> getallmerchant1();
	
	
	/*查询最近七天的记录*/
	@Query(nativeQuery=true,value="SELECT  wxuserrecord.key1,wxuserrecord.key2,COUNT(key1)AS zom FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 7 DAY),'%Y-%m-%d') AND  CURDATE()) AND type='merchant'group by key1")
	List<Object> getallmerchant2();
	
	 /*查询最近30天的记录*/
		@Query(nativeQuery=true,value="SELECT  wxuserrecord.key1,wxuserrecord.key2,COUNT(key1)AS zom FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 30 DAY),'%Y-%m-%d') AND  CURDATE()) AND type='merchant'group by key1")
		List<Object> getallmerchant3();
		
	     /*更据传入的开始时间和结束时间查询	*/
		@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) as zom FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 ) AND type='merchant' group by key1")
		List<Object> getallmerchant4(Date start,Date end );
		
		/*根据传入的商家名查找*/
		@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2 ,COUNT(key2)FROM wxuserrecord WHERE key2=?1 ")
		List<Object> getallmerchant5(String key);
		
		 /*更据传入的开始时间和结束时间和商家名查询	*/
		@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) as zom FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 ) AND key2=?3 GROUP BY key1")
		List<Object> getallmerchant6(Date start,Date end,String key);
		
		
		
  /* =================活动点击查询==========================*/
		/*查询活动当天的点击量*/
		@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) FROM wxuserrecord WHERE (DATE_FORMAT(createtime,'%Y-%m-%d')=CURDATE()) AND type='activity' GROUP BY key1")
		List<Object> getallactivity1();
		
		
		/*查询最近七天的记录*/
		@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 7 DAY),'%Y-%m-%d') AND  CURDATE()) AND type='activity'group by key1")
		List<Object> getallactivity2();
		
		/*查询最近30天的记录*/
		@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 30 DAY),'%Y-%m-%d') AND  CURDATE()) AND type='activity'group by key1")
		List<Object> getallactivity3();
		
		
		/*查询所有的活动点击记录*/
		@Query(nativeQuery=true,value="SELECT wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) FROM wxuserrecord WHERE  type='activity'group by key1")
		List<Object> getallactivity4();
		
		
		/*根据活动名称查找活动的点击记录*/
		@Query(nativeQuery=true,value="SELECT  wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) FROM wxuserrecord WHERE  type='activity' AND key2=?1 GROUP BY key2")
		List<Object> getallactivity5(String name);
		
		
		/*根据开始和结束时间查询*/
		@Query(nativeQuery=true,value="SELECT  wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 ) AND type='activity'group by key1")
		List<Object> getallactivity6(Date a,Date b);
		
		/*根据开始和结束时间跟活动名称进行组合查询*/
		@Query(nativeQuery=true,value="SELECT  wxuserrecord.key1,wxuserrecord.key2,COUNT(key1) FROM wxuserrecord WHERE ((DATE_FORMAT(createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 ) AND type='activity' AND key2=?3 group by key1")
		List<Object> getallactivity7(Date a,Date b,String name);
}
