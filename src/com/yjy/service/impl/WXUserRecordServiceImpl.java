package com.yjy.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.WXUser;
import com.yjy.entity.WXUserRecord;
import com.yjy.repository.WXUserDao;
import com.yjy.repository.WXUserRecordDao;
import com.yjy.service.WXUserRecordService;
import com.yjy.service.WXUserService;
import com.yjy.utils.Util;
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class WXUserRecordServiceImpl implements WXUserRecordService {
	@Autowired
	private WXUserRecordDao wXUserRecordDao;

	@Override
	public WXUserRecord save(WXUserRecord wr) {
		return wXUserRecordDao.save(wr);
	}
	
	
	/*根据传进来的key查找总记录*/
	public List<WXUserRecord> getallrecord(String key){
		return wXUserRecordDao.getallwxusercord(key);
	}
	
	/*更据传进来的key查询当天的记录*/
	public List<WXUserRecord> getallrecordday(String key){
		return wXUserRecordDao.getallwxusercord1(key);
	}
	
	/*根据传进来的查询最近7天的记录*/
	public List<WXUserRecord> getallsevenday(String key){
		
		return wXUserRecordDao.getallwxusercord2(key);
	}
	
	/*更据传进来的key查询最近30天的记录*/
	public List<WXUserRecord> getallthirtylist(String key){
		
		return wXUserRecordDao.getallwxusercord3(key);
	}
	/*更据传进来的key 开始时间，结束时间 查询记录*/
	public List<WXUserRecord> gettimelist(Date start,Date end,String key ){
		
		return wXUserRecordDao.getallwxusercord4(start, end, key);
	}
	
	
	/*查询商家当天的点击记录*/
	public List<Object> getmerchantlist(){
		return wXUserRecordDao.getallmerchant1();
	}
	
	/*查询商家近7天的点击记录*/
	public List<Object> getmerchantlist2(){
		
		return wXUserRecordDao.getallmerchant2();
	}
	
	
	/*查询商家最近30天的点击记录*/
	
	public List<Object> getmerchantlist3(){
		
		return wXUserRecordDao.getallmerchant3();
	}
	
	
	/*查询商户所有的点击量*/
      public List<Object> getmerchantlist4(){
		
		return wXUserRecordDao.getallmerchant();
	}
      /*更据传入的开始时间和结束时间查询	*/
      public List<Object> getmerchantlist5(Date start,Date end){
  		
  		return wXUserRecordDao.getallmerchant4(start, end);
  	}
      /*更据传入的商家名称查询	*/
      public List<Object> getmerchantlist6(String key){
    		
    		return wXUserRecordDao.getallmerchant5(key);
    	}
    /*  根据传入的时间和商家名查询*/
      public List<Object> getmerchantlist7(Date start,Date end,String key){
  		
  		return wXUserRecordDao.getallmerchant6(start, end, key);
  	}
      
      
 /* =========对点击活动的处理============*/
  /*  查询当天的点击活动记录 */
    public List<Object> getactivitylist(){
    	return wXUserRecordDao.getallactivity1();
    }
   
  /*查询最近7天的活动记录  */
    public List<Object> getactivitylist1(){
    	return wXUserRecordDao.getallactivity2();
    }
    
   /* 查询最近30天的活动记录*/
   public List<Object> getactivitylist2(){
	   return wXUserRecordDao.getallactivity3();
   }
    
   /* 查询所有的活动点击记录*/
   public List<Object> getactivitylist3(){
	   return wXUserRecordDao.getallactivity4();
   }
      
  /* 根据活动名称查询点击记录*/
   public List<Object> getactivitylist4(String name){
	   return wXUserRecordDao.getallactivity5(name);
   }
   
  /* 根据开始和结束时间查询*/
   public List<Object> getactivitylist5(Date start,Date end){
	   return wXUserRecordDao.getallactivity6(start, end);
   }
  
   /*根据开始时间结束时间和活动名称组合查询*/
   public List<Object> getactivitylist6(Date start,Date end,String name){
	   return wXUserRecordDao.getallactivity7(start, end, name);
   }
   
}
