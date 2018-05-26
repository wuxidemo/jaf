package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Order;

public interface OrderDao extends PagingAndSortingRepository<Order, Long>,
		JpaSpecificationExecutor<Order> {
	@Query(value = "from Order where code=?1")
	Order getByCode(String code);

	@Query(value = "from Order where cwxcode=?1")
	Order getByCWXCode(String code);

	@Query(value = " from Order where payopenid=?1 order by createtime desc")
	List<Order> getOrderByOpenid(String openid);
	
}
