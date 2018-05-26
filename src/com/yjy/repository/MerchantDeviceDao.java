package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.MerchantDevice;

public interface MerchantDeviceDao extends PagingAndSortingRepository<MerchantDevice, Long>,
JpaSpecificationExecutor<MerchantDevice> {

	@Query(nativeQuery=true,value="select * from merchantdevice")
	List<MerchantDevice> getAllMerchantDevice();
	
	@Query(nativeQuery=true,value="select * from merchantdevice where deviceid=?1")
	List<MerchantDevice> getMerchantDeviceListByDeviceid(String deviceid);
	
	@Query(nativeQuery=true,value="select * from merchantdevice where merchantid=?1")
	List<MerchantDevice> getMerchantDeviceListByMerchantid(Long merchantid);
	
}
