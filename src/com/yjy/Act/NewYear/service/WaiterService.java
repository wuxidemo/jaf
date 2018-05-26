package com.yjy.Act.NewYear.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Act.NewYear.entity.Waiter;


public interface WaiterService {
	
	public Page<Object[]> getWaiterList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public Waiter findByOpenid(String openid);
	
	//根据openid查找
	public Waiter findbyopenid(String openid);
	
	//保存
	public  Waiter save1(Waiter waiter);

	
	public Waiter find(Long id);
	
	public boolean delete(String ids);
	
	/*查找前50名*/
	public List<Object> findbyall(String openid, String date1);
	
	public List<Waiter> findByState(int state);
	
	public List<Object[]> getWinnerList();
	
	public int getAllWaiterCount();
	
	public List<Object[]> getTop50WinList();

	public List<Object[]> getChosenList(String openid, String datestr);
}
