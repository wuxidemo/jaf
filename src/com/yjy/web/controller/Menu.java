package com.yjy.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yjy.entity.Resource;
import com.yjy.entity.Role;
import com.yjy.entity.User;
import com.yjy.service.LoginInfoService;
import com.yjy.service.ResourceService;
import com.yjy.service.UserService;

@Controller
@RequestMapping(value = "/menu")
public class Menu {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ResourceService resourceService;
	
	@Autowired
	private LoginInfoService loginInfoService;

	/** 
	 * 获取菜单列表
	 * @author zhangmengmeng
	 * @date 2015-4-20 上午10:08:58
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET)
	public String menu(HttpServletRequest request,Model model) {
		
		// 根据登陆用户role查询资源
		
		List<Map<Resource, List<Resource>>> mapList = new ArrayList<Map<Resource,List<Resource>>>();
		
//		List<Map.Entry<Resource,List<Resource>>> mappingList = null; 
		
//		Map<Resource, List<Resource>> map = new HashMap<Resource, List<Resource>>();
		
		
		
		/*Map<Resource, List<Resource>> map = new TreeMap<Resource, List<Resource>>(new Comparator<Resource>(){

			@Override
			public int compare(Resource o1, Resource o2) {
				// TODO Auto-generated method stub
				if(o1.getSorts() >= o2.getSorts()) {
					return 1;
				}
				return 0;
			}
			
		});*/
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		Role role = user.getRole();
		
		if(role == null) {
			model.addAttribute("message", "你的账号暂时无法登陆，请联系管理员寻求解决！");
			return "account/login";
		}
		
		if(session.getAttribute("menuList") != null) {
			return "default";
		}
		
		
		List<Resource> resList = resourceService.findByRoleId(role.getId());
		
		if(resList != null && resList.size() > 0) {
			List<Long> idList = new ArrayList<Long>();
			
			for(Resource res : resList) {
				if(res != null) {
					Resource pRes = res.getResource();
					if(pRes == null) {
						idList.add(res.getId());
					}else{
						if(idList.contains(pRes.getId())) {
							continue;
						}else{
							idList.add(pRes.getId());
						}
					}
				}
			}
			
			List<Long> sortedList = resourceService.getSortedList(idList);
			//System.out.println(sortedList);
			
			for(Long pid : sortedList) {
				Resource pRes = new Resource();
				pRes = resourceService.get(pid);
				//System.out.println(pRes.getName());
				List<Resource> subResList = resourceService.findSubResources(pid,role.getId());
				Map<Resource, List<Resource>> map = new HashMap<Resource, List<Resource>>();
				map.put(pRes, subResList);
				mapList.add(map);
			}
			
			/*mappingList = new ArrayList<Map.Entry<Resource, List<Resource>>>(map.entrySet());
			
		    Collections.sort(mappingList, new Comparator<Map.Entry<Resource,List<Resource>>>(){ 
			   public int compare(Map.Entry<Resource,List<Resource>> mapping1,Map.Entry<Resource,List<Resource>> mapping2){
				   if(mapping1.getKey().getSorts() >= mapping2.getKey().getSorts()){
					   return 1;
				   }
				   return 0; 
			   } 
			  }); */
			
			/*for(Resource re : map.keySet()) {
				System.out.println(re.getName());
				List<Resource> reList = map.get(re);
				if(reList.size()>0) {
					for(Resource r : reList) {
						System.out.println("+++"+r.getName());
					}
				}
			}*/
			
			//model.addAttribute("data", map);
			
			session.setAttribute("access", resList);
			
			session.setAttribute("menuList", mapList);
			
		}
		return "default";
	}
}
