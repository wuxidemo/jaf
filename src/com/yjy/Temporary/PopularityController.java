package com.yjy.Temporary;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.Temporary.entity.Popularity;
import com.yjy.Temporary.entity.ShareRecord;
import com.yjy.Temporary.entity.ShareRedbagRecord;
import com.yjy.Temporary.entity.TicketRecord;
import com.yjy.Temporary.entity.WinningRecord;
import com.yjy.Temporary.service.ActService;
import com.yjy.Temporary.service.PopularityService;
import com.yjy.Temporary.service.ShareRecordService;
import com.yjy.Temporary.service.ShareRedbagRecordService;
import com.yjy.Temporary.service.TicketRecordService;
import com.yjy.Temporary.service.WinningRecordService;
import com.yjy.entity.Activity;
import com.yjy.service.WeChatAccountService;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;

@Controller
@RequestMapping(value = "/popularity")
public class PopularityController {
	@Autowired
	PopularityService popularityService;
	@Autowired
	WinningRecordService winningRecordService;
	@Autowired
	ActService actService;
	@Autowired
	WeChatAccountService weChatAccountService;
	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}

	@RequestMapping
	public String list(@RequestParam(value = "page", defaultValue = "1", required = false) int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE, required = false) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto", required = false) String sortType, Model model,
			ServletRequest request) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		Page<Popularity> srs = popularityService.getPopularity(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("srs", srs);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("token", WXManage.WCA.getAccesstoken());
		// 将搜索条件编码成字符串，用于排序，分页的URL
		return "temporary/popularitylist";
	}

	@RequestMapping(value = "pwinform")
	public String winform(Model model) {
		List<Popularity> lp = popularityService.getTop2();
		if (lp.size() == 2) {
			model.addAttribute("p1", lp.get(0));
			model.addAttribute("p2", lp.get(1));
		} else if (lp.size() == 1) {
			model.addAttribute("p1", lp.get(0));
		}
		int pls = 0;
		for (Popularity p : lp) {
			if (p.getState() == null) {
				pls++;
			}
		}
		int count1000 = popularityService.get1000Count();
		model.addAttribute("count1000", count1000 - pls);
		model.addAttribute("count", popularityService.get500Count() - (count1000 - pls) - pls);
		return "temporary/pwinform";
	}

	@RequestMapping(value = "sendwin")
	@ResponseBody
	public String sendwindata(@RequestParam(value = "sort") int sort,
			@RequestParam(value = "id", required = false) Long id) {
		Date now = new Date();
		if (sort == 1) {
			Popularity p = popularityService.get(id);
			WinningRecord wr = new WinningRecord();
			wr.setCreatetime(new Date());
			wr.setName(p.getName());
			wr.setOpenid(p.getOpenid());
			wr.setState(1);
			wr.setTkid(id);
			wr.setType("rqzhd");
			wr.setWinname(1);
			wr.setWintime(now);
			winningRecordService.save(wr);
			WXManage.SendOnePicMsg(weChatAccountService.getAccesstoken(), p.getOpenid(), "恭喜您中奖了",
					"感谢您参加“金阿福e服务”平台“疯狂双11”的“拼人气赢iPhone”活动。恭喜您获得第一名，奖品为“iPhone6S Plus(64G)”1部。奖品将在7日内送到你手中！无锡农村商业银行携手度维科技为你提供智慧的服务!",
					SysConfig.BASEURL + "/wxurl/redirect?url=wxact/poresult",
					SysConfig.BASEURL + "/static/11act/images/getwin.jpg");
			p.setState(1);
			popularityService.save(p);
		} else if (sort == 2) {
			Popularity p = popularityService.get(id);
			WinningRecord wr = new WinningRecord();
			wr.setCreatetime(new Date());
			wr.setName(p.getName());
			wr.setOpenid(p.getOpenid());
			wr.setState(1);
			wr.setTkid(id);
			wr.setType("rqzhd");
			wr.setWinname(2);
			wr.setWintime(now);
			winningRecordService.save(wr);
			WXManage.SendOnePicMsg(weChatAccountService.getAccesstoken(), p.getOpenid(), "恭喜您中奖了",
					"感谢您参加“金阿福e服务”平台“疯狂双11”的“拼人气赢iPhone”活动。恭喜您获得第二名，奖品为“iPhone6(64G)”1部。奖品将在7日内送到你手中！无锡农村商业银行携手度维科技为你提供智慧的服务!",
					SysConfig.BASEURL + "/wxurl/redirect?url=wxact/poresult",
					SysConfig.BASEURL + "/static/11act/images/getwin.jpg");
			p.setState(1);
			popularityService.save(p);
		} else if (sort == 3) {
			List<Popularity> lp = popularityService.get1000();
			for (Popularity p : lp) {
				WinningRecord wr = new WinningRecord();
				wr.setCreatetime(new Date());
				wr.setName(p.getName());
				wr.setOpenid(p.getOpenid());
				wr.setState(1);
				wr.setTkid(id);
				wr.setType("rqzhd");
				wr.setWinname(3);
				wr.setWintime(now);
				winningRecordService.save(wr);
				WXManage.SendOnePicMsg(weChatAccountService.getAccesstoken(), p.getOpenid(), "恭喜您中奖了",
						"感谢您参加“金阿福e服务”平台“疯狂双11”的“拼人气赢iPhone”活动，恭喜您获得20元话费奖励！请在3日内填写手机号码，过期作废。话费将在7日内到帐。。无锡农村商业银行携手度维科技为你提供智慧的服务!",
						SysConfig.BASEURL + "/wxurl/redirect?url=wxact/poresult",
						SysConfig.BASEURL + "/static/11act/images/getwin.jpg");
				p.setState(1);
				popularityService.save(p);
			}
		} else if (sort == 4) {
			List<Popularity> lp = popularityService.get500();
			for (Popularity p : lp) {
				WinningRecord wr = new WinningRecord();
				wr.setCreatetime(new Date());
				wr.setName(p.getName());
				wr.setOpenid(p.getOpenid());
				wr.setState(1);
				wr.setTkid(id);
				wr.setType("rqzhd");
				wr.setWinname(4);
				wr.setWintime(now);
				winningRecordService.save(wr);
				WXManage.SendOnePicMsg(weChatAccountService.getAccesstoken(), p.getOpenid(), "恭喜您中奖了",
						"感谢您参加“金阿福e服务”平台“疯狂双11”的“拼人气赢iPhone”活动，恭喜您获得10元话费奖励！请在3日内填写手机号码，过期作废。话费将在7日内到帐.无锡农村商业银行携手度维科技为你提供智慧的服务!",
						SysConfig.BASEURL + "/wxurl/redirect?url=wxact/poresult",
						SysConfig.BASEURL + "/static/11act/images/getwin.jpg");
				p.setState(1);
				popularityService.save(p);
			}
		}
		return "1";
	}

	@RequestMapping(value = "stop")
	@ResponseBody
	public String stop() {
		actService.stopRQZ();
		return "1";
	}
}
