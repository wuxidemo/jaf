package com.yjy.Act.NewYear.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Act.NewYear.dao.MyProductDao;
import com.yjy.Act.NewYear.entity.Like;
import com.yjy.Act.NewYear.entity.Product;
import com.yjy.Act.NewYear.repository.LikeDao;
import com.yjy.Act.NewYear.repository.ProductDao;
import com.yjy.Act.NewYear.service.ProductService;
import com.yjy.utils.Util;

@Component
@Transactional
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private MyProductDao myProductDao;
	
	@Autowired
	private LikeDao likeDao;

	/* 分页列表展示 */
	public Page<Product> getList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Product> spec = Util.buildSpecification(searchParams,
				Product.class);
		return productDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public List<Object> findbyall(String openid, String date1, int collegestate) {

		return productDao.getbyall(openid, date1, collegestate);
	}

	/**
	 * openid判断数据库是否有数据
	 * 
	 */
	public Map<String, Object> findbyone(String openid) {
		Map<String, Object> result = new HashMap<String, Object>();
		Product pro = productDao.findbyone(openid);
		if (pro == null) {
			result.put("result", 0);
		} else {
			result.put("result", 1);
		}

		return result;
	}

	/**
	 * save保存
	 */

	public Product save1(Product product) {

		return productDao.save(product);
	}

	/**
	 * 根据id查找
	 */
	public Product find(Long id) {
		return productDao.findOne(id);
	}

	/* 根据openid查找 */

	public Product findbyopenid(String openid) {
		return productDao.findbyone(openid);
	}

	/* 删除 */
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			List<Like> likelist = likeDao.getLikeByProid(Long.valueOf(i));
			if(likelist != null && likelist.size() > 0) {
				for(Like like : likelist) {
					likeDao.delete(like.getId());
				}
			}
			productDao.delete(Long.parseLong(i));
		}
		return true;
	}

	/* 查找所有状态为1de */
	public List<Product> findProductByState(int state) {
		return productDao.findProductByState(state);
	}

	/* 查找参与活动的总人数 */
	public int findbysum() {
		return productDao.findsum();
	}
	
	@Override
	public Page<Object[]> getProList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(myProductDao.getProData(searchParams, pageNumber, pageSize, order), pageRequest,
				myProductDao.getProCountByParam(searchParams));
	}

	@Override
	public List<Object[]> getTopThreeWinner(int collegestate) {
		// TODO Auto-generated method stub
		return productDao.getTopThreeWinner(collegestate);
	}

	@Override
	public List<Product> findProductByStateAndCollege(int state, int college) {
		// TODO Auto-generated method stub
		return productDao.findProductByStateAndCollege(state, college);
	}

	
	/************************下面是江南大学和太湖学院的ProductService方法*******************************/
	@Override
	public Page<Object[]> getJDProList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(myProductDao.getJDProData(searchParams, pageNumber, pageSize, order), pageRequest,
				myProductDao.getJDProCountByParam(searchParams));
	}

	@Override
	public Page<Object[]> getTHProList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(myProductDao.getTHProData(searchParams, pageNumber, pageSize, order), pageRequest,
				myProductDao.getJDProCountByParam(searchParams));
	}
	/****************************************************************************************/
	
}
