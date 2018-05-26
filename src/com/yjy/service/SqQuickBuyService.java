package com.yjy.service;

import java.util.List;

import com.yjy.entity.Sq_QuickBuy;

public interface SqQuickBuyService {
	
	public Sq_QuickBuy save(Sq_QuickBuy sq_QuickBuy);
	
	public Sq_QuickBuy get(Long id);
	
	public void delete(Long id);
	
	public List<Sq_QuickBuy> getSq_QuickBuyList();
	
	public List<Sq_QuickBuy> getOnlineQuickBuyList();
	
	public void updateState();
	
}
