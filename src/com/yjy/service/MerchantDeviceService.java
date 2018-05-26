package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.MerchantDevice;

public interface MerchantDeviceService {
	
	
	public Page<MerchantDevice> getMerchantDevices(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType);

	public MerchantDevice save(MerchantDevice merchantDevice);

	public void delete(Long id);

	public MerchantDevice get(Long id) ;
	
	
	public List<MerchantDevice> getAllMerchantDevice(String mername);
	
	public List<MerchantDevice> getMerchantDeviceListByDeviceid(String deviceid) ;
	
	public List<MerchantDevice> getMerchantDeviceListByMerchantid(Long merchantid);
}
