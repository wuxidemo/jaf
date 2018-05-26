package com.yjy.Act.NewYear.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Act.NewYear.entity.Product;

public interface ProductService {

	public Page<Product> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	/**
	 * 获取前50个
	 * @return
	 */
	public List<Object> findbyall(String openid,String date1,int collegestate );
	
	
	
	public Map<String, Object> findbyone(String openid);
	
	public Product save1(Product product);
	
	public Product find(Long id);
	
	public Product findbyopenid(String openid);
	
	public boolean delete(String ids);
	
	public List<Product> findProductByState(int state);
	
	public List<Product> findProductByStateAndCollege(int state, int college);
	
	public int  findbysum();
	
	public Page<Object[]> getProList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public List<Object[]> getTopThreeWinner(int collegestate);
	
	
	/************************下面是江南大学和太湖学院的ProductService方法*******************************/
	public Page<Object[]> getJDProList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public Page<Object[]> getTHProList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	/***************************************************************************************/
	
	
}
