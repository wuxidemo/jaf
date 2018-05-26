package com.yjy.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Rebate;
import com.yjy.repository.RebateDao;

@Component
@Transactional
public class RebateService {

	@Autowired
	RebateDao rebateDao;

	public List<Rebate> getUseRebate(Date now) {
		return rebateDao.getUseRebate(now);
	}

	public List<Rebate> getListPage(int pageIndex, int pageSize) {
		return rebateDao.getListPage((pageIndex - 1) * pageSize, pageSize);
	}

	public int getAllcount() {
		return rebateDao.getAllcount();
	}

	public Rebate get(Long id) {
		return rebateDao.findOne(id);
	}

	/**
	 * 
	 * 更新返利红包状态
	 * 
	 * @author lyf
	 * @date 2015年6月19日 下午2:13:38
	 * @param id
	 * @param state
	 */
	public void updatestate(Long id, int state) {
		rebateDao.updatestate(id, state);
	}

	/**
	 * 
	 * 更新首次红包状态
	 * 
	 * @author lyf
	 * @date 2015年6月19日 下午2:13:53
	 * @param id
	 * @param state
	 */
	public void updatefstate(Long id, int state) {
		rebateDao.updatefstate(id, state);
	}

	public Rebate save(Rebate r) {
		return rebateDao.save(r);
	}

	/**
	 * 
	 * 查询时间段内 时间重合的记录个数
	 * 
	 * @author lyf
	 * @date 2015年6月19日 下午2:14:16
	 * @param s
	 * @param e
	 * @return
	 */
	public int getTimeCount(Date s, Date e) {
		return rebateDao.getTimeCount(s, e);
	}

	/**
	 * 
	 * 更新过期返利红包
	 * 
	 * @author lyf
	 * @date 2015年6月23日 上午9:40:32
	 */
	public void updateUnuse() {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			now = sdf.parse(sdf.format(now));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		rebateDao.updateUnuse(now);
	}

	/**
	 * 
	 * 查询当前是否有返利活动
	 * 
	 * @author lyf
	 * @date 2015年6月23日 下午2:42:17
	 * @return
	 */
	public int getUseRebate() {
		List<Rebate> lr = rebateDao.getUseRebate(new Date());
		if (lr.size() == 1) {
			return 1;
		} else
			return 0;
	}

	public List<Rebate> findAllRebates() {
		return rebateDao.findAllRebates();
	}
}
