package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Sq_PensionApply;

public interface Sq_PensionApplyService {
	/**
	 * 查询分页方法
	 * 
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Sq_PensionApply> getPensionApplyList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	/**
	 * 保存
	 * 
	 * @param pensionApply
	 * @return
	 */
	public Sq_PensionApply save(Sq_PensionApply pensionApply);

	/**
	 * 删除单个
	 * 
	 * @param id
	 */
	public void delete(Long id);

	/**
	 * 批量删除
	 * 
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);

	/**
	 * 修改
	 * 
	 * @param pensionApply
	 * @return
	 */
	public Sq_PensionApply update(Sq_PensionApply pensionApply);

	/**
	 * 查找
	 * 
	 * @param id
	 * @return
	 */
	public Sq_PensionApply get(Long id);

	/**
	 * 根据openid查询
	 * 
	 * @param openid
	 * @return
	 */
	public Sq_PensionApply getPensionApplyByOpenid(String openid);
	/**
	 * 根据openid和sqactid查询结果
	 * @param sqactid
	 * @param openid
	 * @return
	 */
	public List<Sq_PensionApply> getPenActListByOpenAndAct(Long sqactid,String openid);
	/**
	 * 根据活动id获取申请记录
	 * @param sqactid
	 * @return
	 */
	public List<Sq_PensionApply> getPenActListBySqactid(Long sqactid);
}
