package com.yjy.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.IntegralRecord;

public interface IntegralRecordService {

	
	
	/**
	 * 
	 *  分页查询
	 * @author gaolongfei
	 * @date 2015年4月24日 下午2:25:03
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<IntegralRecord> getList(Map<String, Object> searchParams, int pageNumber,
			int pageSize, String sortType) ;

	
	public void SaveOrUpdate(IntegralRecord ir);

	public List<IntegralRecord> getListByOpenid(String openid) ;

	public List<IntegralRecord> getListByCardnum(String cardnum) ;

	/**
	 * 
	 * 获取时间段数据 (积分 卡号 时间 名字 电话)
	 * 
	 * @author luyf
	 * @date 2015年7月30日 上午11:30:44
	 * @param s
	 * @param e
	 * @return
	 */
	public List<Object[]> getSumList(Date s, Date e) ;

	/**
	 * 
	 * 获取昨天数据 (积分 卡号 时间 名字 电话)
	 * 
	 * @author luyf
	 * @date 2015年7月30日 上午11:30:27
	 * @return
	 */
	public List<Object[]> getYesterdayList() ;
}
