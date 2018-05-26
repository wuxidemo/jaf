package com.yjy.Temporary.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Temporary.ACTConfig;
import com.yjy.Temporary.entity.PopularityRecord;
import com.yjy.Temporary.repository.PopularityRecordDao;
import com.yjy.Temporary.repository.WinningRecordDao;
import com.yjy.Temporary.service.ActService;
import com.yjy.Temporary.service.PopularityRecordService;
import com.yjy.Temporary.service.PopularityService;

@Component
@Transactional
public class ActServiceImpl implements ActService {
	@Autowired
	WinningRecordDao winningRecordDao;

	public String getRQZState() {
		return winningRecordDao.getValueByKey("rqzhdState");
	}

	public void refreshRQZState() {
		ACTConfig.rqzhdState = winningRecordDao.getValueByKey("rqzhdState");
	}

	public boolean isRQZ() {
		return ACTConfig.rqzhdState.equals("1") && new Date().compareTo(ACTConfig.rqzhdEndtime) < 0;
	}

	public void stopRQZ() {
		ACTConfig.rqzhdState = "0";
		winningRecordDao.updateValue("rqzhdState", "0");
	}

	public String getGZFXState() {
		return winningRecordDao.getValueByKey("gzfxhdstate");
	}

	public void refreshGZFXState() {
		ACTConfig.gzfxhdstate = winningRecordDao.getValueByKey("gzfxhdstate");
	}

	public boolean isGZFX() {
		return ACTConfig.gzfxhdstate.equals("1") && new Date().compareTo(ACTConfig.gzfxhdEndtime) < 0;
	}

	public void stopGZFX() {
		ACTConfig.gzfxhdstate = "0";
		winningRecordDao.updateValue("gzfxhdstate", "0");
	}

	public String getQCCJState() {
		return winningRecordDao.getValueByKey("qccjhdstate");
	}

	public void refreshQCCJState() {
		ACTConfig.qccjhdstate = winningRecordDao.getValueByKey("qccjhdstate");
	}

	public boolean isQCCJ() {
		return ACTConfig.qccjhdstate.equals("1") && new Date().compareTo(ACTConfig.qccjhdEndtime) < 0;
	}

	public void stopQCCJ() {
		ACTConfig.qccjhdstate = "0";
		winningRecordDao.updateValue("qccjhdstate", "0");
	}
}
