package com.yjy.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Apply;

/**
 * 类ApplyService.java的实现描述：Apply的Service层
 * 
 * @author wutao 2015年6月23日 下午1:47:25
 */
public interface ApplyService {

	/**
	 * 获取所有的Apply列表
	 * 
	 * @author wutao
	 * @date 2015年6月23日 下午2:17:41
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Apply> getApply(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) ;


	public Apply get(Long id);

	public Apply update(Apply d) ;

	public void delete(Long id) ;

	public int getCountByServerType(Long sid) ;

	public Apply getApplyByOpenid(String openid) ;
}
