package com.yjy.Temporary.service;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.Actcardrecord;
import com.yjy.Temporary.entity.tmphb;

import java.util.List;
import java.util.Map;

import com.yjy.entity.Merchant;

public interface tmphbService {
	public tmphb save(tmphb t);

	public List<tmphb> getList();
}
