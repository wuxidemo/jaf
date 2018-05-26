package com.yjy.Temporary.service;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.Actcardrecord;

import java.util.List;
import java.util.Map;

import com.yjy.entity.Merchant;

public interface ActcardrecordService {

	Page<Actcardrecord> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);

	public List<Actcardrecord> getDownRecord(Map<String, Object> searchParams);

	public Map<String, Object> useWECard(String code, Merchant mer);

	public Actcardrecord save(Actcardrecord ar);

	public List<Actcardrecord> getListByOpenidAct(String openid, String type);

	public String getUrl(String openid, String type, Long wrid);

	public List<Actcardrecord> getListByOpenidAct2(String openid, String type);

	public int getCountByTrid(Long trid);

	public List<Actcardrecord> getMerUsedRecord(String time, Long merid);
}
