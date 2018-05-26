
package com.yjy.service;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Merchant;

public interface MerchantService {

	public Page<Merchant> getMerchants(Map<String, Object> searchParams, int pageNumber,
			int pageSize, String sortType);


	public Merchant save(Merchant merchant);
	public void delete(Long id) ;


	public Merchant get(Long id);
	
	public int getRecommendedNum();
	
	public List<Merchant> getAllMerchant();
	
	public List<Merchant> getMerchantByNameOrGroupid(String mername, String groupid);
	
	public List<Merchant> getRecommend() ;
	
	public Merchant getMerchantByPoi_id(String poi_id) ;
	public List<Merchant> getOtherMerchantListByPoi_ids(String poiids);
	
	public void setState(String idstrs);
	
	
	/*根据商圈id找到他所有的商户*/
	public List<Merchant>getbymerlisst(int id);
	
                   /*   根据商圈id找到其所在商圈的卡卷*/
	 public List<Object> getcarlist(int bus,String date);
}
