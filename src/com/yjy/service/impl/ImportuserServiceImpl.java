package com.yjy.service.impl;

import java.sql.ResultSet;
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

import com.yjy.entity.Inuser;
import com.yjy.repository.ImportuserDao;
import com.yjy.service.ImportuserService;
import com.yjy.utils.Util;

@Component
@Transactional
public class ImportuserServiceImpl implements ImportuserService{

	@Autowired
	private ImportuserDao importuserDao;

	public Page<Inuser> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Inuser> spec = Util.buildSpecification(searchParams, Inuser.class);
		return importuserDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} /*
			 * else if("schoolorwork".equals(sortType)){ sort=new
			 * Sort(Direction.DESC,"schoolorwork"); }
			 */
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public Inuser ADD(Inuser num) {
		return importuserDao.save(num);
	}

	public ResultSet find() {
		return (ResultSet) importuserDao.findAll();
	}

	public void deleteAll() {
		importuserDao.deleteAll();
	}

	/**
	 * 根据卡号查找用户
	 * 
	 * @return
	 */
	public List<Inuser> findbycardum(String cardnum) {
		return importuserDao.findBycardnum(cardnum);
	}
	/**
	 * 根据卡号查找单独用户
	 * 
	 * @return
	 */
	public Inuser findbyname(String cardnum) {
		return importuserDao.findByname(cardnum);
	}
	/** 
	 * 根据用户输入的姓名和卡号来查找数据是否存在
	 * @author yigang
	 * @date 2015年7月31日 下午2:19:01
	 * @param name
	 * @param cardnum
	 * @return
	 */
	public List<Inuser> findByNameAndCardNumber(String name, String cardnum) {
		return importuserDao.findByNameAndCardNumber(name, cardnum);
	}
	
	/** 
	 * 根据openid来查找用户是否绑定过银行卡
	 * @author yigang
	 * @date 2015年7月31日 下午2:18:36
	 * @param openid
	 * @return
	 */
	public boolean isBindCard(String openid) {
		int count = importuserDao.getCountByOpenid(openid);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public Inuser update(Inuser inuser) {
		return importuserDao.save(inuser);
	}

	public Inuser get(Long id) {
		return importuserDao.findOne(id);
	}

	/**
	 * 
	 * 减去所用积分
	 * 
	 * @author luyf
	 * @date 2015年7月27日 下午2:14:49
	 * @param id
	 * @param count
	 */
	public void updatePoint(Long id, int count) {
		importuserDao.updatePoint(id, count);
	}

	/**
	 * 
	 * 根据openid查询积分够的绑定银行卡
	 * 
	 * @author luyf
	 * @date 2015年7月27日 下午4:10:31
	 * @param openid
	 * @return
	 */
	public List<Inuser> getUseListByOpenid(String openid) {
		return importuserDao.getUseListByOpenid(openid);
	}
	
	public void dell(String cardnum){
		importuserDao.delet(cardnum);
	}
}
