package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MyMercommentDao;
import com.yjy.entity.Mercomment;
import com.yjy.repository.MercommentDao;
import com.yjy.service.MercommentService;
/**
 * @author lenovo
 *
 */
@Component
@Transactional
public class MercommentServiceImpl implements MercommentService {

	@Autowired
	private MercommentDao mercommentDao;
	@Autowired
	private MyMercommentDao myMercommentDao;
	@Override
	public Page<Object[]> getMercommentList(Map<String, Object> params, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest=buildPageRequest(pageNumber,pageSize,sortType);
		String order="";
		if ("auto".equals(sortType)) {
			order = "id DESC";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<>(myMercommentDao.getMercommentData(params, pageNumber, pageSize, order),pageRequest,myMercommentDao.getMercommentCount(params));
	}
	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort=null;
		if("auto".equals(sortType)){
			sort=new Sort(Direction.DESC,"id");
		}else  if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber-1, pageSize,sort);
	}
	@Override
	public Mercomment getMercommentByid(Long id) {
		return mercommentDao.getMercommentById(id);
	}
	@Override
	public Mercomment save(Mercomment m) {
		return mercommentDao.save(m);
	}
	@Override
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			mercommentDao.delete(Long.parseLong(i));
		}
		return true;
	}
	/*加载分页*/
	@Override
	public List<Object[]> getMercommentListDataByParam(Map<String, Object> searchParams, int start, int size) {
		// TODO Auto-generated method stub
		return myMercommentDao.getMercommentListData(searchParams, start, size);
	}
	//根据merid查询商户，评论信息
	@Override
	public List<Object[]> getMercomment(Long merid) {
		// TODO Auto-generated method stub
		return myMercommentDao.getMercommentListData(merid);
	}
	/**
	 * 获取前三个客户评价信息
	 */
	@Override
	public List<Object[]> getPartMercommentList(Map<String, Object> searchParams) {
		return myMercommentDao.getMercommentList(searchParams);
	}

	
	/**
	 * 我的订单 加载分页
	 * @param params
	 * @return
	 */
	@Override
	public List<Object[]> getMyPayOrderByOpenid(Map<String, Object> params, int start, int size) {
		// TODO Auto-generated method stub
		return myMercommentDao.getMyPayOrderByOpenid(params, start, size);
	}
	
	
	/**
	 * 根据商家的id来查找该商家评分的平均值
	 */
	@Override
	public Float getAvgScoreByMerid(Long merid) {
		// TODO Auto-generated method stub
		return mercommentDao.getAvgScoreByMerid(merid);
	}
	@Override
	public List<Mercomment> getMercommentByOrderid(Long orderid) {
		return mercommentDao.getMercommentByOrderid(orderid);
	}
}
