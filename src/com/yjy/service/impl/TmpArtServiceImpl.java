package com.yjy.service.impl;

import java.util.Calendar;

import java.util.Date;
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

import com.yjy.entity.Activity;
import com.yjy.entity.TmpArt;
import com.yjy.repository.ActivityDao;
import com.yjy.repository.TmpArtDao;
import com.yjy.service.ActivityService;
import com.yjy.service.TmpArtService;
import com.yjy.utils.Util;

@Component
@Transactional
public class TmpArtServiceImpl implements TmpArtService {

	@Autowired
	private TmpArtDao tmpArtDao;

	public TmpArt save(TmpArt ta) {
		return tmpArtDao.save(ta);
	}

	public TmpArt get(Long id) {
		return tmpArtDao.findOne(id);
	}
}
