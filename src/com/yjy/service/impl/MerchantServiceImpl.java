
package com.yjy.service.impl;
import java.util.ArrayList;
import java.util.HashMap;
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

import com.yjy.entity.Merchant;
import com.yjy.repository.MerchantDao;
import com.yjy.service.MerchantService;
import com.yjy.utils.Util;

@Component
//类中所有public函数都纳入事务管理的标识.
@Transactional
public class MerchantServiceImpl implements MerchantService{
	
	@Autowired
	private MerchantDao merchantDao;

	public Page<Merchant> getMerchants(Map<String, Object> searchParams, int pageNumber,
			int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Merchant> spec = Util.buildSpecification(searchParams,
				Merchant.class);
		return merchantDao.findAll(spec, pageRequest);
	}


	public Merchant save(Merchant merchant) {
		return merchantDao.save(merchant);
	}

	public void delete(Long id) {
		merchantDao.delete(id);
	}

	/**
	 * 分页排序
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.ASC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public Merchant get(Long id) {
		return merchantDao.findOne(id);
	}
	
	public int getRecommendedNum() {
		return merchantDao.getRecommendedNum();
	}
	
	public List<Merchant> getAllMerchant() {
		return merchantDao.getAllMerchant();
	}
	
	public List<Merchant> getMerchantByNameOrGroupid(String mername, String groupid){
		Map<String, Object> map = new HashMap<String, Object>();
		if(mername != null && !mername.trim().equals("")) {
			map.put("LIKE_name", mername.trim());
		}
		
		if(groupid != null && !groupid.trim().equals("") && !groupid.trim().equals("0")) {
			map.put("EQ_business.id", groupid.trim());
		}
		
		map.put("EQ_state", 1);
		
		Specification<Merchant> spec = Util.buildSpecification(map,
				Merchant.class);
		
		return merchantDao.findAll(spec);
	}
	
	public List<Merchant> getRecommend() {
		return merchantDao.getRecommend();
	}
	
	public Merchant getMerchantByPoi_id(String poi_id) {
		List<Merchant> merlist = merchantDao.getMerchantByPoi_id(poi_id);
		if(merlist != null && merlist.size() > 0) {
			return merlist.get(0);
		}
		return null;
	}
	
	public List<Merchant> getOtherMerchantListByPoi_ids(String poiids) {
		return merchantDao.getOtherMerchantListByPoi_ids(poiids);
	}


	@Override
	public void setState(String idstrs) {
		// TODO Auto-generated method stub
		List<Integer> yesid = new ArrayList<Integer>();
		
		String[] idarr = idstrs.split(",");
		for(String oneid : idarr) {
			System.out.println(oneid);
			yesid.add(Integer.valueOf(oneid));
		}
		
		List<Integer> allid = merchantDao.findAllmerId();
		for(Integer in : allid) {
			System.out.println(in);
		}
		
		if(allid != null && allid.size() > 0) {
			allid.removeAll(yesid);
			System.out.println(allid);
			
			for(Integer its : allid) {
				merchantDao.setState(its.toString());
				merchantDao.disableUser(its.toString());
			}
			
		}
	}
	
	
	/*  根据传过来的商圈查找其所有的商户*/
	public List<Merchant>getbymerlisst(int id){
		return merchantDao.getOtherMerchantList(id);
	}

  /* 根据传过的商圈id和时间查找所有的有效卡券*/
     public List<Object> getcarlist(int bus,String date){
    	 return merchantDao.getcarList(bus, date);
     }
}
