package com.yjy.web.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.service.MercommentService;

/**
 * 类MercommentController.java的实现描述：操作评论
 * @author liping
 *
 */
@Controller
@RequestMapping(value="/mercomment")
public class MercommentController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}
	
	@Autowired
	private MercommentService mercommentService;
	/*@Autowired
	private CommunityService communityService;*/
	
	@RequestMapping()
	@ResponseBody
	private Page<Object[]> MercommentList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "pagesize", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "createtime") String sortType, Model model,
			ServletRequest request){
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		if (searchParams.containsKey("LIKE_realname")) {//昵称查询
			String realName = (String) searchParams.get("LIKE_realname");
			if (realName == null || "".equals(realName.trim())) {
				searchParams.remove("LIKE_realname");
			} else {
				searchParams.put("LIKE_realname", realName.trim());
				model.addAttribute("LIKE_realname", realName.trim());
			}
		}
		
		if (searchParams.containsKey("EQ_startscore")) {//最小分数
			String value = (String) searchParams.get("EQ_startscore");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("EQ_startscore");
			} else {
				searchParams.put("EQ_startscore", value.trim());
				model.addAttribute("EQ_startscore", value);
			}
		}
		if (searchParams.containsKey("EQ_endscore")) {//最大分数
			String value = (String) searchParams.get("EQ_endscore");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("EQ_endscore");
			} else {
				searchParams.put("EQ_endscore", value.trim());
				model.addAttribute("EQ_endscore", value);
			}
		}
		
		if (searchParams.containsKey("EQ_urls")) {//图片
			String district = (String) searchParams.get("EQ_urls");
			if (district == "-1" || "-1".equals(district.trim())) {
				searchParams.remove("EQ_urls");
			}else {
				searchParams.put("EQ_urls", district.trim());
				model.addAttribute("EQ_urls", district);
			}
		}
		
		if (searchParams.containsKey("EQ_starttime")) {//开始时间
			String value = (String) searchParams.get("EQ_starttime");
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("EQ_starttime");
			} else {
				searchParams.put("EQ_starttime", value.trim());
				model.addAttribute("EQ_starttime", value);
			}
		}
		if (searchParams.containsKey("EQ_endtime")) {//结束时间
			String value = (String) searchParams.get("EQ_endtime");
			String valuesdf = "";
			if (value == null || "".equals(value.trim())) {
				searchParams.remove("EQ_endtime");
			} else {
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
					Date enddate = sdf.parse(value);
					Calendar cal = Calendar.getInstance();
					cal.setTime(enddate);
					cal.add(Calendar.HOUR, +24);
					valuesdf = sdf.format(cal.getTime());
				} catch (ParseException e) {
					e.printStackTrace();
				}
				searchParams.put("EQ_endtime", valuesdf.trim());
				model.addAttribute("EQ_endtime", value);
			}
		}
		Page<Object[]> Mercomment = mercommentService.getMercommentList(searchParams, pageNumber, pageSize, sortType);
		return Mercomment;
	}
	/**
	 * 跳转到指定页面,前的验证，如果有数据就跳转，无数据就不跳转
	 * 
	 */
	@RequestMapping(value = "mercommenturl")
	@ResponseBody
	public Map<String,Object> tourl(@RequestParam(value = "merid", required = false) Long merid, Model model,ServletRequest request) {
		
		Map<String,Object> map=new HashMap<String, Object>();
			List<Object[]>list=mercommentService.getMercomment(merid);
		if(list.size()>0&&!list.isEmpty()){
			map.put("result",true);
		}else{
			map.put("result",false);
		}
		return map;
	}
	/**
	 * 跳转到指定页面
	 */
	@RequestMapping(value = "url")
	public  String url(@RequestParam(value = "merid", required = false) Long merid, Model model,ServletRequest request) {
		
			List<Object[]>list=mercommentService.getMercomment(merid);
			model.addAttribute("mer", list.get(0));//0商户名1总评分（0.0000）2评论次数3评论人数
			model.addAttribute("merid", merid);
		return "mercomment/mercommentlist";
	}
	/**
	 * 加载分页
	 * @param LIKE_realname
	 * @param EQ_startscore
	 * @param EQ_endscore
	 * @param EQ_urls
	 * @param EQ_starttime
	 * @param EQ_endtime
	 * @param start
	 * @param size
	 * @return
	 */
	@RequestMapping(value="list",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getListByParam(@RequestParam(value = "LIKE_realname", required = false) String LIKE_realname,
			@RequestParam(value = "EQ_startscore", required = false) Integer EQ_startscore,
			@RequestParam(value = "EQ_endscore", required = false) Integer EQ_endscore,
			@RequestParam(value = "EQ_urls", required = false) Integer EQ_urls,
			@RequestParam(value = "EQ_starttime", required = false) String EQ_starttime,
			@RequestParam(value = "EQ_endtime", required = false) String EQ_endtime,
			@RequestParam(value = "merid", required = false) Long merid,
			@RequestParam(value = "start")Integer start,@RequestParam(value = "size") Integer size){
		Map<String,Object> map=new HashMap<String, Object>();
		Map<String,Object> searchParams=new HashMap<String,Object>();
		if (merid != null) {
			searchParams.put("merid", merid);
		}else{
			searchParams.remove("merid");
		}
		if (LIKE_realname != null && !"".equals(LIKE_realname.trim()) && !"null".equals(LIKE_realname.trim())) {
			searchParams.put("LIKE_realname", LIKE_realname.trim());
		}else{
			searchParams.remove("LIKE_realname");
		}
		if (EQ_startscore !=-1) {
			searchParams.put("EQ_startscore", EQ_startscore);
		}else{
			searchParams.remove("EQ_startscore");
		}
		if (EQ_endscore !=-1) {
			searchParams.put("EQ_endscore", EQ_endscore);
		}else{
			searchParams.remove("EQ_endscore");
		}
		if (EQ_urls !=-1) {
			searchParams.put("EQ_urls", EQ_urls);
		}else{
			searchParams.remove("EQ_urls");
		}
		if (EQ_starttime != null && !"".equals(EQ_starttime.trim()) && !"null".equals(EQ_starttime.trim())) {
			searchParams.put("EQ_starttime", EQ_starttime.trim());
		}else{
			searchParams.remove("EQ_starttime");
		}
		
		if (EQ_endtime != null && !"".equals(EQ_endtime.trim()) && !"null".equals(EQ_endtime.trim())) {
			String valuesdf = "";
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
				Date enddate = sdf.parse(EQ_endtime);
				Calendar cal = Calendar.getInstance();
				cal.setTime(enddate);
				cal.add(Calendar.HOUR, +24);
				valuesdf = sdf.format(cal.getTime());
			} catch (ParseException e) {
				e.printStackTrace();
			}
			searchParams.put("EQ_endtime", valuesdf.trim());
		}else{
			searchParams.remove("EQ_endtime");
		}

		List<Object[]> list=mercommentService.getMercommentListDataByParam(searchParams, start, size);
		if(list!=null && list.size()>0){
			map.put("result", "1");
			map.put("data", list);
		}else{
			map.put("result", "0");
			map.put("msg", "暂无数据");
		}
		return map;
	}
	
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> delete(@RequestParam(value = "ids", required = false) String id){
		Map<String,Object> map=new HashMap<String, Object>();
		boolean mercommentdel=mercommentService.delete(id);
		if(mercommentdel){
			System.out.println("wodebiaoji");
			map.put("result", true);
		}else{
			map.put("result", false);
		}
		return map;
	}
}
