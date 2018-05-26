package com.yjy.web.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.yjy.entity.Community;
import com.yjy.entity.Sq_Propertyfee;
import com.yjy.entity.User;
import com.yjy.service.CommunityService;
import com.yjy.service.Sq_PropertyfeeService;

/**
 * 类Sq_PropertyfeeController.java的实现描述：物业缴费
 * @author liping
 *
 */
@Controller
@RequestMapping(value="/sqpropertyfee")
public class Sq_PropertyfeeController {

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("title", "标题");
	}
	@Autowired
	private Sq_PropertyfeeService sq_PropertyfeeService;
	@Autowired
	private CommunityService communityService;
	/**
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping()
	@ResponseBody
	private Page<Sq_Propertyfee> SqPropertyfeeList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "pagesize", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "createtime") String sortType, Model model,
			HttpServletRequest request){
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		if (searchParams.containsKey("LIKE_householder")) {
			String householder = (String) searchParams.get("LIKE_householder");
			if (householder == null || "".equals(householder.trim())) {
				searchParams.remove("LIKE_householder");
			} else {
				searchParams.put("LIKE_householder", householder.trim());
				model.addAttribute("LIKE_householder", householder.trim());
			}
		}
		if (searchParams.containsKey("LIKE_telephone")) {
			String telephone = (String) searchParams.get("LIKE_telephone");
			if (telephone == null || "".equals(telephone.trim())) {
				searchParams.remove("LIKE_telephone");
			} else {
				searchParams.put("LIKE_telephone", telephone.trim());
				model.addAttribute("LIKE_telephone", telephone.trim());
			}
		}	
		
		User u = (User) request.getSession().getAttribute("user");//根据用户进行社区选择
		Community c=u.getCommunity();
		if(c!=null){
			searchParams.put("EQ_community.id", c.getId());
		}else{
			if (searchParams.containsKey("EQ_community.id")) {
				String district = (String) searchParams.get("EQ_community.id");
				if (district == "-1" || "-1".equals(district.trim())) {
					searchParams.remove("EQ_community.id");
				}else{
					model.addAttribute("EQ_community.id", district);
				}
			}
		}
		Page<Sq_Propertyfee> sqpropertyfee=sq_PropertyfeeService.getSqPropertyfee(searchParams, pageNumber, pageSize, sortType);
		return sqpropertyfee;
	}
	/**
	 * 后台跳转到物业缴费
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="jumpsqpropertyfee")
	public String saveparam(Model model, HttpServletRequest request) {
		User u = (User) request.getSession().getAttribute("user");//根据用户进行社区选择
		Community c=u.getCommunity();
		if(c!=null){
			model.addAttribute("comm", c);
		}else{
			List<Community> commlist=communityService.getCommunityList();
			model.addAttribute("commlist", commlist);
		}
		return "wuye/sqpropertyfee";
	}
	
	/**
     * 文件上传导入库
     * @param request
     * @param file
     * @return
     */
	@RequestMapping(value = "imfile")
	@ResponseBody
	public  Map<String, Object> upfile(HttpServletRequest request,@RequestParam(value = "fileToUpload", required = false) MultipartFile file) {
		
		  Map<String, Object> map = new HashMap<String, Object>();  
		  User u = (User) request.getSession().getAttribute("user");//根据用户进行社区选择
		  Community c=u.getCommunity();
		  int judeg=1;
		try {
            String filename=file.getOriginalFilename();//获取上传文件的名称  
            String crip=request.getRemoteAddr();//获取客户端的IP地址
            User user=(User) request.getSession().getAttribute("user");
            Long orid=user.getId();//获得当前用户的id;
            String username=user.getName();//获取当前用户名;
         /* if(inrecordService.getre(filename)!=null){
            	map.put("msg", 0);
            }else {*/
			HSSFWorkbook wookbook = new HSSFWorkbook(file.getInputStream());
			HSSFSheet sheet = wookbook.getSheetAt(0);
			// 获取到Excel文件中的所有行数­
			int rows =sheet.getPhysicalNumberOfRows();        
			//判断excel表中是否有小数点多于两位的小数
			for (int i = 1; i < rows; i++) {
				HSSFRow row = sheet.getRow(i);
				if (row != null) {
					int cells = row.getPhysicalNumberOfCells();
					for (int j = 0; j < cells; j++) {
						HSSFCell cell = row.getCell(j);
						if (cell != null) {
							switch (cell.getCellType()) {
							case HSSFCell.CELL_TYPE_NUMERIC:
								cell.getNumericCellValue();
								String s=String.valueOf(cell.getNumericCellValue());
								if(s.indexOf("E")==-1){
									int position=s.length()-s.indexOf(".")-1;
									if(position>2){
										judeg=0;
									}
								}
								break;
							default:
								break;
							}
						}
					}
				}		
			}
			if(judeg==0){
				map.put("msg",0);
			}else{

				for (int i = 1; i < rows; i++) {
					// 读取左上端单元格­
					HSSFRow row = sheet.getRow(i);
					// 行不为空
					if (row != null) {
						// 获取到Excel文件中的所有的列
						int cells = row.getPhysicalNumberOfCells();
						String value = "";
						
						// 遍历列
						for (int j = 0; j < cells; j++) {
							// 获取到列的值
							HSSFCell cell = row.getCell(j);
							if (cell != null) {
								switch (cell.getCellType()) {
								case HSSFCell.CELL_TYPE_FORMULA:
									break;
								case HSSFCell.CELL_TYPE_NUMERIC:
									DecimalFormat df=new DecimalFormat("#.##");
									value +=df.format(cell.getNumericCellValue()) + ",";
									break;
								case HSSFCell.CELL_TYPE_STRING:
									value += cell.getStringCellValue() + ",";
									break;
								default:
									value += "0";
									break;
								}
							}
						}
						String[] val = value.split(",");
						int size=val.length;
						Sq_Propertyfee s=new Sq_Propertyfee();
	                       if(size>0){
							s.setBuild(val[0].trim());
							s.setNumber(val[1].trim());
							s.setHouseholder(val[2].trim());
							s.setTelephone(val[3].trim());
							Float fee = Float.valueOf(val[4].trim())*100;
							s.setFee((int)fee.floatValue());
							s.setState(0);
							s.setCommunity(c);
						    s.setCreatetime(new Date());
							sq_PropertyfeeService.save(s);
	                       }
					}		
				}
				map.put("msg", 1);
			}
			    //将文件保存至服务器上的指定目录下
			   String pbasepath=request.getSession().getServletContext().getRealPath("/");  //获取文件的跟目录
				String mypath=pbasepath+File.separator+"upload"+File.separator+"excel";
				File newmypath=new File(mypath);
				if(!newmypath.exists()){
					newmypath.mkdirs();
				}
			    String newpath=newmypath.getPath()+File.separator+filename;
	            file.transferTo(new File(newpath));
           /* }*/
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 根据ids删除对象
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCommunity(@RequestParam(value = "ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result =sq_PropertyfeeService.delete(ids);
		if (result) {
			map.put("result", true);
			map.put("msg", "删除成功");
		} else {
			map.put("result", false);
			map.put("msg", "删除失败");
		}
		return map;
	}
	
    /**
     * 跳转导入页面
     * @return
     */
  @RequestMapping(value="/jumpdata")
  public String getshow1(){
	return"wuye/ipotdata";
}
}
