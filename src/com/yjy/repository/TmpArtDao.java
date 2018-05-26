package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Activity;
import com.yjy.entity.TmpArt;

public interface TmpArtDao extends PagingAndSortingRepository<TmpArt, Long>,
		JpaSpecificationExecutor<TmpArt> {
}
