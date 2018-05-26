package com.yjy.service.impl;

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

import com.yjy.entity.MerchantDevice;
import com.yjy.repository.MerchantDeviceDao;
import com.yjy.service.MerchantDeviceService;
import com.yjy.utils.Util;

@Component
//类中所有public函数都纳入事务管理的标识.
@Transactional
public class MerchantDeviceServiceImpl implements MerchantDeviceService{
	
	@Autowired
	private MerchantDeviceDao merchantDeviceDao;
	
	public Page<MerchantDevice> getMerchantDevices(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<MerchantDevice> spec = Util.buildSpecification(searchParams,
				MerchantDevice.class);
		return merchantDeviceDao.findAll(spec, pageRequest);
	}

	public MerchantDevice save(MerchantDevice merchantDevice) {
		return merchantDeviceDao.save(merchantDevice);
	}

	public void delete(Long id) {
		merchantDeviceDao.delete(id);
	}

	public MerchantDevice get(Long id) {
		return merchantDeviceDao.findOne(id);
	}
	
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.ASC, "id");
		} else if ("name".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} 

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}
	
	public List<MerchantDevice> getAllMerchantDevice(String mername) {
		
		if(mername == null || mername.trim().equals("")) {
			return merchantDeviceDao.getAllMerchantDevice();
		}else{
			Map<String, Object> searchParams = new HashMap<String, Object>();
			searchParams.put("LIKE_merchant.name", mername);
			Specification<MerchantDevice> spec = Util.buildSpecification(searchParams,
					MerchantDevice.class);
			return merchantDeviceDao.findAll(spec);
		}
		
		
	}
	
	public List<MerchantDevice> getMerchantDeviceListByDeviceid(String deviceid) {
		return merchantDeviceDao.getMerchantDeviceListByDeviceid(deviceid);
	}
	
	public List<MerchantDevice> getMerchantDeviceListByMerchantid(Long merchantid) {
		return merchantDeviceDao.getMerchantDeviceListByMerchantid(merchantid);
	}
	
}
