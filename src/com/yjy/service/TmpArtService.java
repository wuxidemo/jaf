package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Activity;
import com.yjy.entity.TmpArt;

public interface TmpArtService {

	public TmpArt save(TmpArt ta);

	public TmpArt get(Long id);
}
