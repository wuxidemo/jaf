package com.yjy.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.WXUser;
import com.yjy.entity.WXUserRecord;

public interface WXUserRecordService {

	public WXUserRecord save(WXUserRecord wr);
	
	/*根据传进来的key查找总记录*/
	public List<WXUserRecord> getallrecord(String key);
	
	/*更据传进来的key查询当天的记录*/
	public List<WXUserRecord> getallrecordday(String key);
	
	/*根据传进来的查询最近7天的记录*/
	public List<WXUserRecord> getallsevenday(String key);
	
	/*更据传进来的key查询最近30天的记录*/
	public List<WXUserRecord> getallthirtylist(String key);
	
	/*更据传进来的key 开始时间，结束时间 查询记录*/
	public List<WXUserRecord> gettimelist(Date start,Date end,String key );
	
	
	
	/*查询商家当天的点击记录*/
	public List<Object> getmerchantlist();
	
	/*查询商家近7天的点击记录*/
	public List<Object> getmerchantlist2();
	
	
    /*查询商家最近30天的点击记录*/
	public List<Object> getmerchantlist3();
	
	/*查询商户所有的点击量*/
    public List<Object> getmerchantlist4();
    
    /*更据传入的开始时间和结束时间查询	*/
    public List<Object> getmerchantlist5(Date start,Date end);
    
    /*更据传入的商家名称查询	*/
    public List<Object> getmerchantlist6(String key);
    
    /*  根据传入的时间和商家名查询*/
    public List<Object> getmerchantlist7(Date start,Date end,String key);
    
    
    
    
  /* ==========活动处理查询============= */
    /*  查询当天的点击活动记录 */
    public List<Object> getactivitylist();
    
    
    /*查询最近7天的活动记录  */
    public List<Object> getactivitylist1();
    
    
    /* 查询最近30天的活动记录*/
    public List<Object> getactivitylist2();
    
    /* 查询所有的活动点击记录*/
    public List<Object> getactivitylist3();
    
    
    /* 根据活动名称查询点击记录*/
    public List<Object> getactivitylist4(String name);
    
    
    /* 根据开始和结束时间查询*/
    public List<Object> getactivitylist5(Date start,Date end);
    
    
    /*根据开始时间结束时间和活动名称组合查询*/
    public List<Object> getactivitylist6(Date start,Date end,String name);
}
