package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.WXMerchant;

public interface WXMerchantService {
	/**
	 * 
	 * 分页查询
	 * 
	 * @author lyf
	 * @date 2015年10月14日 下午2:00:19
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<WXMerchant> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);

	/**
	 * 
	 * 刷新卡券子商户
	 * 
	 * @author lyf
	 * @date 2015年10月14日 下午2:00:35
	 */
	public void RefreshWXMER();

	/**
	 * 
	 * 查询或新建卡券子商户
	 * 
	 * @author lyf
	 * @date 2015年10月14日 下午7:24:50
	 * @param merid
	 * @return
	 */
	public WXMerchant getWXMOrNew(Long merid);

	public List<WXMerchant> getAll();
}
