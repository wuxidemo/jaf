/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.yjy.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.RebateForFirst;

public interface RebateForFirstDao extends
		PagingAndSortingRepository<RebateForFirst, Long>,
		JpaSpecificationExecutor<RebateForFirst> {

}
