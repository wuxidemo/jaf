package com.yjy.web.api;

import java.io.File;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.http.client.methods.HttpPost;
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
import com.yjy.entity.Inrecord;
import com.yjy.entity.Inuser;
import com.yjy.entity.User;
import com.yjy.service.ImportuserService;
import com.yjy.service.InrecordService;
import com.yjy.utils.StuService;
import com.yjy.utils.Util;



@Controller
@RequestMapping(value="/imoup")
public class WXImportuserController {
	@Autowired
	private ImportuserService importuserService;
	
	@Autowired
	private InrecordService inrecordService; 
	  
	/*
	@RequestMapping(value = "/ord5")
	public String kak() {
		return "text/upfile1";
	}*/
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	@RequestMapping(method = RequestMethod.GET)
	public String getshow(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		searchParams = Util.changeEncoding(searchParams);
		Page<Inuser> nums = importuserService.getList(searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("impos", nums);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		return "text/upfile1";
	}
	    /**
	     * 跳转导入页面
	     * @return
	     */
	  @RequestMapping(value="/outipot")
	  public String getshow1(){
		return"text/ipot";
	}
	
	/**
     * 文件上传导入库
     * @param request
     * @param file
     * @return
     */
	@RequestMapping(value = "imfile")
	@ResponseBody
	public  Map<String, Object> upfile(
			HttpServletRequest request,
			@RequestParam(value = "fileToUpload", required = false) MultipartFile file) {
		  Map<String, Object> map = new HashMap<String, Object>();  
		try {
			
            String filename=file.getOriginalFilename();//获取上传文件的名称  
            String crip=request.getRemoteAddr();//获取客户端的IP地址
            User user=(User) request.getSession().getAttribute("user");
            Long orid=user.getId();//获得当前用户的id;
            String username=user.getName();//获取当前用户名;
            if(inrecordService.getre(filename)!=null){
            	map.put("msg", 0);
            	
            }else{
            
			HSSFWorkbook wookbook = new HSSFWorkbook(file.getInputStream());
			HSSFSheet sheet = wookbook.getSheetAt(0);
			// 获取到Excel文件中的所有行数­
			int rows =sheet.getPhysicalNumberOfRows();        
			// 遍历行­
			/*importuserService.deleteAll();*/
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
								DecimalFormat df=new DecimalFormat("#");
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
					Inuser entity = new Inuser();
					String cardnum=val[1];
					/*String type=val[4];*/
					/*String a=type.substring(1);*/
					/*List<Inuser> inuserList = importuserService.findbycardum(cardnum);*/
					Inuser inuser=importuserService.findbyname(cardnum);
					if(inuser==null){
						entity.setName(val[0].trim());
						entity.setPhone(val[2].toString().trim());
						entity.setCardnum(val[1].trim());
						entity.setPoint(Integer.parseInt(val[3]));
						entity.setState(0);
						entity.setCreatetime(new Date());
						importuserService.ADD(entity);
					}else if(inuser!=null&&size==4){
						entity.setName(val[0].trim());
						entity.setPhone(val[2].toString().trim());
						entity.setCardnum(val[1].trim());
						entity.setOpenid(inuser.getOpenid());
						int point1=inuser.getPoint();
						entity.setPoint(Integer.parseInt(val[3])+point1);
						entity.setState(1);
						entity.setCreatetime(new Date());
						importuserService.dell(cardnum);
						importuserService.ADD(entity);
					}else if(inuser!=null&&size!=4){
						entity.setName(val[0].trim());
						entity.setPhone(val[2].toString().trim());
						entity.setCardnum(val[1].trim());
						int point1=inuser.getPoint();
						entity.setPoint(Integer.parseInt(val[3])-point1);
						entity.setState(1);
						entity.setCreatetime(new Date());
						importuserService.dell(cardnum);
						importuserService.ADD(entity);
					}
					/*if (inuserList!=null && inuserList.size() > 0) {
						entity.setName(val[0]);
						entity.setPhone(val[1]+"");
						entity.setCardnum(val[2]);
						entity.setPoint(Integer.parseInt(val[3]));
						entity.setState(0);
						entity.setCreatetime(new Date());
						entity.setType("-");
						importuserService.ADD(entity);
					}else{
					
					entity.setName(val[0]);
					entity.setPhone(val[1]);
					entity.setCardnum(val[2]);
					entity.setPoint(Integer.parseInt(val[3]));
					entity.setState(0);
					entity.setCreatetime(new Date());
					entity.setType("+");
					importuserService.ADD(entity);
					}*/
				}
			}
			Inrecord inred=new Inrecord();
			   inred.setRecord(filename);
			   inred.setCreateip(crip);
			   inred.setCreatetime(new Date());
			   inred.setCreatorid(orid);
			   inred.setName(username);
			   inrecordService.mysave(inred);
			   map.put("msg", 1);
			   
			   
			    //将文件保存至服务器上的指定目录下
			   String pbasepath=request.getSession().getServletContext().getRealPath("/");  //获取文件的跟目录
				String mypath=pbasepath+File.separator+"upload"+File.separator+"excel";
				File newmypath=new File(mypath);
				if(!newmypath.exists()){
					newmypath.mkdirs();
				}
			    String newpath=newmypath.getPath()+File.separator+filename;
	            file.transferTo(new File(newpath));
            }
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return map;
	}
	
	/**
     * 导入卡号跟新库中的卡号
     * @return
     */
	@RequestMapping(value="cardnumber")
	public Map<String,Object> getmap(HttpServletRequest request,
			@RequestParam(value = "fileToUpload", required = false) MultipartFile file){
		    Map<String, Object> map = new HashMap<String, Object>();
		try {
			String filename=file.getOriginalFilename();//获取上传文件的名称  
            String crip=request.getRemoteAddr();//获取客户端的IP地址
            User user=(User) request.getSession().getAttribute("user");
            Long orid=user.getId();//获得当前用户的id;
            String username=user.getName();//获取当前用户名;
            if(inrecordService.getre(filename)!=null){
            	map.put("msg", 0);
            }else{
            	HSSFWorkbook wookbook = new HSSFWorkbook(file.getInputStream());
    			HSSFSheet sheet = wookbook.getSheet("Sheet1");
    			// 获取到Excel文件中的所有行数­
    			int rows =sheet.getPhysicalNumberOfRows();        
    			// 遍历行­
    			/*importuserService.deleteAll();*/
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
    								DecimalFormat df=new DecimalFormat("#");
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
    				String cardnum1=val[0];
    				String cardnum2=val[1];
    				Inuser entity = new Inuser();
    				Inuser inuser=importuserService.findbyname(cardnum1);
    				inuser.setCardnum(cardnum2.trim());
    				importuserService.ADD(entity);
             }
    			}
    			
    			Inrecord inred=new Inrecord();
 			   inred.setRecord(filename);
 			   inred.setCreateip(crip);
 			   inred.setCreatetime(new Date());
 			   inred.setCreatorid(orid);
 			   inred.setName(username);
 			   inrecordService.mysave(inred);
 			   map.put("msg", 1);
 			   
 			  //将文件保存至服务器上的指定目录下
			   String pbasepath=request.getSession().getServletContext().getRealPath("/");  //获取文件的跟目录
				String mypath=pbasepath+File.separator+"upload"+File.separator+"excel";
				File newmypath=new File(mypath);
				if(!newmypath.exists()){
					newmypath.mkdirs();
				}
			    String newpath=newmypath.getPath()+File.separator+filename;
	            file.transferTo(new File(newpath));
            }
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}
    
	
	
	/**
	 * 导出到excel表
	 * @param model
	 */
	@RequestMapping(value="/oufile")
	public String getcreate4(Model model) {
		
		try {
			WritableWorkbook wwb = null; //创建可以写入的工作簿
			String fileName = "D://inuser.xls";
			File file = new File(fileName);
			if (!file.exists()) {
				file.createNewFile();
			}
			wwb = Workbook.createWorkbook(file);// 以fileName为文件名来创建一个Workbook

			WritableSheet ws = wwb.createSheet("Shee1", 0); // 创建工作表
			// 查询数据库中所有的数据
			List<Inuser> list = StuService.getAllByDb();
			// 要插入到excel表格的行号，默认从0开始
			Label labelId = new Label(0, 0, "id");
			Label labelno1 = new Label(1, 0, "name");
			Label labelno2 = new Label(2, 0, "phone");
			Label labelno3 = new Label(3, 0, "cardnum");
			Label labelno4 = new Label(4, 0, "point");
	/*		Label labelno5 = new Label(5, 0, "no5");*/
			ws.addCell(labelId);
			ws.addCell(labelno1);
			ws.addCell(labelno2);
			ws.addCell(labelno3);
			ws.addCell(labelno4);
		/*	ws.addCell(labelno5);*/
			for (int i = 0; i < list.size(); i++) {
				Label labelId_i = new Label(0, i + 1, i+1+ "");
				Label labelno1_i = new Label(1, i + 1, list.get(i).getName());
				Label labelno2_i = new Label(2, i + 1, list.get(i).getPhone());
				Label labelno3_i = new Label(3, i + 1, list.get(i).getCardnum());
				Label labelno4_i = new Label(4, i + 1, list.get(i).getPoint()+"");
				/*Label labelno5_i = new Label(5, i + 1, list.get(i).getNo5());*/
				ws.addCell(labelId_i);
				ws.addCell(labelno1_i);
				ws.addCell(labelno2_i);
				ws.addCell(labelno3_i);
				ws.addCell(labelno4_i);
			/*	ws.addCell(labelno5_i);*/
			}
			wwb.write();
			wwb.close();
		} catch (Exception e){
			// TODO: handle exception
			e.printStackTrace();
		}
		return"redirect:/imoup";

	}
	 
	
}
  