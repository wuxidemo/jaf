package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Mercomment;

/**
 * 类MercommentService.java的实现描述：Mercomment下的增删查改操作
 * @author liping
 *
 */
public interface MercommentService {

	public Page<Object[]> getMercommentList(Map<String, Object> params,int pageNumber, int pageSize, String sortType);
	
	/**
	 * 根据id查询对象
	 * @param id
	 * @return
	 */
	public Mercomment  getMercommentByid(Long id);
	/**
	 * 添加
	 * @param m
	 * @return
	 */
	public Mercomment save(Mercomment m);
	/**
	 * 删除
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);
	/**
	 * 加载分页查询
	 * @param params
	 * @param start
	 * @param siz
	 * @return
	 */
	public List<Object[]> getMercommentListDataByParam(Map<String,Object> searchParams,int start,int size);
	/**
	 * 根据merid查询商户，评论信息
	 * @param merid
	 * @return
	 */
	public List<Object[]> getMercomment(Long merid);
	
	/**
	 * 获取前三个商户评价信息
	 */
	public List<Object[]> getPartMercommentList(Map<String,Object> searchParams);
	
	/**
	 * 我的订单 加载分页
	 * @param params
	 * @return
	 */
	public List<Object[]> getMyPayOrderByOpenid(Map<String,Object> params,int start,int size);
	
	
	/**
	 * 根据商家的id来查找该商家评分的平均值
	 * @param merid
	 * @return
	 */
	public Float getAvgScoreByMerid(Long merid);
	/**
	 * 根据订单编号，查询评价
	 * @param orderid
	 * @return
	 */
	public List<Mercomment> getMercommentByOrderid(Long orderid);
}
