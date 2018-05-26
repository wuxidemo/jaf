package com.yjy.web.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Classify;
import com.yjy.entity.User;
import com.yjy.service.ClassifyService;

/**
 * 类ClassifyController.java的实现描述：操作商圈
 * @author liping
 *
 */
@Controller
@RequestMapping(value="/classify")
public class ClassifyController {
     /*  private static final String PAGE_SIZE="10";*/
       private static Map<String,String> sortTypes=Maps.newLinkedHashMap();
       static{
    	   sortTypes.put("auto","自动");
    	   sortTypes.put("title","标题");
       }
       @Autowired
       private ClassifyService classifyService;
       /**
        * 获取类别列表
        * @param pageNumber
        * @param pageSize
        * @param sortType
        * @param model
        * @param request
        * @return
        */
/*       @RequestMapping()
       private String getClassifyList(
    		   @RequestParam(value="page",defaultValue="1")int pageNumber,
    		   @RequestParam(value="page.size",defaultValue=PAGE_SIZE)int pageSize,
    		   @RequestParam(value="sortType",defaultValue="auto")String sortType,
    		   Model model,ServletRequest request){
    	   Map<String,Object> searchParams=Servlets.getParametersStartingWith(request, "search_");
    	   if(searchParams.containsKey("LIKE_name")){
    		   String realName=(String) searchParams.get("LIKE_name");
    		   if(realName==null||"".equals(realName.trim())){
    			   searchParams.remove("LIKE_name");
    		   }else{
    			   searchParams.put("LIKE_name",realName.trim());
    			   model.addAttribute("LIKE_name",realName.trim());
    		   }
    	   }
    	   if(searchParams.containsKey("EQ_categoryValue.id")){
    		   String district=(String) searchParams.get("EQ_categoryValue.id");
    		   if(district=="-1"||"-1".equals(district.trim())){
    			   searchParams.remove("EQ_categoryValue.id");
    		   }
    	   }
    	   Page<Classify> classify=classifyService.getClassifyList(searchParams, pageNumber, pageSize, sortType);
    	   List<Classify> classifys=classifyService.getList();
    	   model.addAttribute("classify",classify);
    	   model.addAttribute("classifys",classifys);
    	   model.addAttribute("sortType", sortType);
    	   model.addAttribute("sortypes", sortTypes);
    	   //将搜索条件编码成字符串，用于排序，分页的URL
    	   model.addAttribute("searchParams",Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
    	   return "classify/classlist";
       }*/
       
       
       /**
        * 无分页的类别集合
        */
       @RequestMapping()
       private String getClassifyList(Model model, ServletRequest request){
    	   List<Classify> classify=new ArrayList<Classify>();
    	   List<Classify> classifys=new ArrayList<Classify>();
    	   List<Classify> classify1=new ArrayList<Classify>();
    	   Map<String,Object> searchParams=Servlets.getParametersStartingWith(request, "search_");
    	   if(searchParams.containsKey("LIKE_name")){
    		   String realName=(String) searchParams.get("LIKE_name");
    		   System.out.println(realName);
    		   classify1=classifyService.getList("");
    		   classify=classifyService.getList(realName);
    		   classifys=classifyService.getListPid(realName);	
    		   if(classify.isEmpty()&&!classifys.isEmpty()){
    			   for(int i=0;i<classifys.size();i++){
        			   Long id=classifys.get(i).getPid();
        			   classify.addAll(classifyService.findClassifyByid(id));
        		   }  
    		   }
    		   
    	   }else{
    		   classify1=classifyService.getList("");
    		   classify=classify1;
    		   classifys=classifyService.getListPid("");
    	   }
    	   
    	   model.addAttribute("classify",classify);
    	   model.addAttribute("classifys",classifys);
    	   model.addAttribute("classify1",classify1);
    	   return "classify/classlist";
       }
       
       /**
        * 删除类
        * @param ids
        * @return
        */
       @RequestMapping(value="/delete",method=RequestMethod.POST)
       @ResponseBody
       public Map<String,Object> deleteclassify(
    		   @RequestParam(value="ids")String ids){
    	   System.out.println(ids);
    	   Map<String,Object> map=new HashMap<String,Object>();
    	   boolean result=classifyService.delete(ids);
    	   boolean result1=classifyService.deleteByPid(ids);
    	   if(result&&result1){
    		   map.put("result",true);
    		   map.put("msg","删除成功");
    	   }else{
    		   map.put("result",false);
    		   map.put("msg","删除失败");
    	   }
    	   return map;
       }
       /**
        * 判断类是否存在
        * @param id
        * @param name
        * @return
        */
       @RequestMapping(value="/checkclassify",method=RequestMethod.POST)
       @ResponseBody
       public Map<String,Object> checkclassify(
    		   @RequestParam(value="id")Long id,
    		   @RequestParam(value="name")String name){
    	   Map<String,Object> map=new HashMap<String,Object>();
    	   List<Classify> classify=classifyService.getClassifyByValue(name);
    	   if(classify.size()==0){
    		   map.put("result",true);
    	   }else if(classify.get(0).getId().equals(id)){
    		   map.put("result", true);
    	   }else{
    		   map.put("result", false);
    		   map.put("msg","类别名称已存在！");
    	   }
    	   return map;
       }
       /**
        * 新增类的值
        * @param classify
        * @param redirectAttributes
        * @param request
        * @return
        */
       @RequestMapping(value="/create",method=RequestMethod.POST)
       public String create(@Valid Classify classify
    		   ,@RequestParam(value="pid")String pid,
    	       RedirectAttributes redirectAttributes,HttpServletRequest request){
    	   classify.setCreatetime(new Date());
    	   User user=(User) request.getSession().getAttribute("user");
    	   classify.setUser(user);
    	   classifyService.SaveOrUpdate(classify);
    	   redirectAttributes.addFlashAttribute("message","更新成功");
    	   return "redirect:/classify";
       }
      /**
       * 根据选中的父类判断子类
       * @param ids
       * @return
       */
       @RequestMapping(value="/checkbox",method=RequestMethod.POST)
       @ResponseBody
       public Map<String,Object> checkbox(
    		   @RequestParam(value="ids")String ids){
    	   List<Classify> classify=new ArrayList<Classify>();
    	   Map<String,Object> map=new HashMap<String,Object>();
    	   System.out.println(ids);
   		   String[] id=ids.split("\\|");
   		   for(int i=0;i<id.length;i++){
   		   classify=classifyService.getClassifyListByPid(Long.parseLong(id[i]));
   		   }
    	   if(classify.size()==0){
    		   map.put("result",true);
    	   }else{ 
    		   map.put("list", classify);
    		   map.put("result", false);
    	   }
    	   return map;
       }
       
       @RequestMapping(value="/getsubbypid",method=RequestMethod.POST)
       @ResponseBody
       public Map<String,Object> getSubClassifyByPid(@RequestParam(value="pid") Long pid){
    	   Map<String,Object> map=new HashMap<String,Object>();
    	   List<Classify> subclass = classifyService.getClassifyListByPid(pid);
    	   if(subclass != null && subclass.size() > 0) {
    		   map.put("result", "1");
    		   map.put("data", subclass);
   		   }else{
   			   map.put("result", "0");
   			   map.put("msg", "暂无数据");
   		   }
    	   return map;
       }
       
       @RequestMapping(value="/getallsubclassify",method=RequestMethod.POST)
       @ResponseBody
       public Map<String,Object> getAllSubClassify(){
    	   Map<String,Object> map=new HashMap<String,Object>();
    	   List<Classify> subclass = classifyService.getAllSubClassify();
    	   if(subclass != null && subclass.size() > 0) {
    		   map.put("result", "1");
    		   map.put("data", subclass);
   		   }else{
   			   map.put("result", "0");
   			   map.put("msg", "暂无数据");
   		   }
    	   return map;
       }
       
       
}
