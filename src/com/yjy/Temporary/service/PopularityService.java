package com.yjy.Temporary.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.Popularity;

public interface PopularityService {
	public Popularity getByOpenid(String openid);

	/**
	 * 
	 * 查询排名
	 * 
	 * @author lyf
	 * @date 2015年10月17日 上午10:19:56
	 * @param count
	 * @return
	 */
	public int getRankByOpenid(int count, Date time);

	/**
	 * 
	 * 前十
	 * 
	 * @author lyf
	 * @date 2015年10月17日 上午10:31:57
	 * @return 0昵称1头像URL2分数3openid
	 */
	public List<Object[]> getTop10By();

	/**
	 * 
	 * 判断用户是否已经帮人分享过
	 * 
	 * @author lyf
	 * @date 2015年10月17日 上午10:55:35
	 * @param openid
	 * @return
	 */
	public boolean Judge(String openid);

	/**
	 * 
	 * 增加人气值 10分
	 * 
	 * @author lyf
	 * @date 2015年10月17日 下午12:47:45
	 * @param toopenid
	 * @param fromopenid
	 */
	public boolean add1Score(String toopenid, String fromopenid);

	/**
	 * 
	 * 增加人气值 3分
	 * 
	 * @author lyf
	 * @date 2015年10月17日 下午12:47:45
	 * @param toopenid
	 * @param fromopenid
	 */
	public String add2Score(String toopenid, String fromopenid);

	public Page<Popularity> getPopularity(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public List<Popularity> getTop2();

	public int get500Count();

	public Popularity get(Long id);

	public List<Popularity> get500();

	public Popularity save(Popularity p);

	public int get1000Count();

	public List<Popularity> get1000();
}
