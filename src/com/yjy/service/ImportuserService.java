package com.yjy.service;

import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Inuser;

public interface ImportuserService {


	public Page<Inuser> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);


	public Inuser ADD(Inuser num);

	public ResultSet find();

	public void deleteAll();

	/**
	 * 根据卡号查找用户
	 * 
	 * @return
	 */
	public List<Inuser> findbycardum(String cardnum);
	/**
	 * 根据卡号查找单独用户
	 * 
	 * @return
	 */
	public Inuser findbyname(String cardnum);
	/** 
	 * 根据用户输入的姓名和卡号来查找数据是否存在
	 * @author yigang
	 * @date 2015年7月31日 下午2:19:01
	 * @param name
	 * @param cardnum
	 * @return
	 */
	public List<Inuser> findByNameAndCardNumber(String name, String cardnum);
	
	/** 
	 * 根据openid来查找用户是否绑定过银行卡
	 * @author yigang
	 * @date 2015年7月31日 下午2:18:36
	 * @param openid
	 * @return
	 */
	public boolean isBindCard(String openid);

	public Inuser update(Inuser inuser);

	public Inuser get(Long id);

	/**
	 * 
	 * 减去所用积分
	 * 
	 * @author luyf
	 * @date 2015年7月27日 下午2:14:49
	 * @param id
	 * @param count
	 */
	public void updatePoint(Long id, int count) ;

	/**
	 * 
	 * 根据openid查询积分够的绑定银行卡
	 * 
	 * @author luyf
	 * @date 2015年7月27日 下午4:10:31
	 * @param openid
	 * @return
	 */
	public List<Inuser> getUseListByOpenid(String openid);
	
	public void dell(String cardnum);
}
