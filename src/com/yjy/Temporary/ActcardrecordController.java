package com.yjy.Temporary;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.ParseException;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;

import com.yjy.Temporary.entity.Actcardrecord;
import com.yjy.Temporary.entity.tmphb;
import com.yjy.Temporary.service.ActcardrecordService;
import com.yjy.Temporary.service.tmphbService;
import com.yjy.entity.Inrecord;
import com.yjy.entity.Merchant;
import com.yjy.entity.User;
import com.yjy.entity.WeChatAccount;
import com.yjy.service.InrecordService;
import com.yjy.utils.Util;
import com.yjy.wechat.WXManage;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Controller
@RequestMapping(value = "/actcardrecord")
public class ActcardrecordController {
	@Autowired

	private ActcardrecordService actcardrecordService;

	@Autowired
	private InrecordService inrecordService;

	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();

	static {
		sortTypes.put("auto", "自动");
	}

	@Autowired
	tmphbService tmphbService;

	@RequestMapping()
	public String getcord(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = (String) searchParams.get(key);
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value.trim());
					model.addAttribute(key.replace(".", "_"), value);
				}
			}
		}
		if (searchParams.containsKey("LIKE_mername")) {
			String mername = (String) searchParams.get("LIKE_mername");
			if (mername == null || "".equals(mername.trim())) {
				searchParams.remove("LIKE_mername");
			} else {
				searchParams.put("LIKE_mername", mername.trim());
				model.addAttribute("LIKE_mername", mername);
			}
		}

		if (searchParams.containsKey("GTE_usedate")) {
			String usedate = ((String) searchParams.get("GTE_usedate")).trim();

			if (usedate.equals("null") || usedate.equals("")) {
				searchParams.remove("GTE_usedate");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(usedate);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				/*
				 * Calendar calendar = Calendar.getInstance();
				 * calendar.setTime(date);
				 */
				searchParams.put("GTE_usedate", date);
			}
		}

		if (searchParams.containsKey("LTE_usedate")) {
			String endDate = ((String) searchParams.get("LTE_usedate")).trim();
			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_usedate");
			} else {
				Date date1 = new Date();
				try {
					date1 = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date1);
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_usedate", calendar.getTime());
			}
		}

		/*
		 * if(searchParams.containsKey("EQ_state")){ String mername = (String)
		 * searchParams.get("EQ_state"); if(mername == null ||
		 * "".equals(mername.trim())){ searchParams.remove("LIKE_mername");
		 * }else{ searchParams.put("LIKE_mername", mername.trim());
		 * model.addAttribute("LIKE_mername", mername); }
		 * 
		 * }
		 */

		if (searchParams.containsKey("EQ_state")) {
			if (searchParams.get("EQ_state").toString().equals("0")) {
				searchParams.remove("EQ_state");
			}
		}

		Page<Actcardrecord> actcardrecordlist = actcardrecordService.getList(searchParams, pageNumber, pageSize,
				sortType);
		model.addAttribute("actcardrecordlist", actcardrecordlist);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);

		if (searchParams.containsKey("LTE_usedate")) {

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.setTime((Date) searchParams.get("LTE_usedate"));
			calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - 1);
			String str = sdf.format(calendar.getTime());
			searchParams.put("LTE_usedate", str);
		}

		if (searchParams.containsKey("GTE_usedate")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchParams.put("GTE_usedate", sdf.format(searchParams.get("GTE_usedate")));
		}

		return "temporary/actcardrecord";
	}

	/* 查询下载 */
	@RequestMapping(value = "/imp")
	public void getMyList6(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		if (!searchParams.isEmpty()) {
			for (String key : searchParams.keySet()) {
				String value = (String) searchParams.get(key);
				if (value != null && !value.equals("") && !value.equals("null")) {
					searchParams.put(key, value.trim());
					model.addAttribute(key.replace(".", "_"), value);
				}
			}
		}

		if (searchParams.containsKey("LIKE_mername")) {
			String mername = (String) searchParams.get("LIKE_mername");
			if (mername == null || "".equals(mername.trim())) {
				searchParams.remove("LIKE_mername");
			} else {
				searchParams.put("LIKE_mername", mername.trim());
				model.addAttribute("LIKE_mername", mername);
			}
		}

		if (searchParams.containsKey("GTE_usedate")) {
			String usedate = ((String) searchParams.get("GTE_usedate")).trim();

			if (usedate.equals("null") || usedate.equals("")) {
				searchParams.remove("GTE_usedate");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(usedate);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				/*
				 * Calendar calendar = Calendar.getInstance();
				 * calendar.setTime(date);
				 */
				searchParams.put("GTE_usedate", date);
			}
			model.addAttribute("a", usedate);
		}

		if (searchParams.containsKey("LTE_usedate")) {
			String endDate = ((String) searchParams.get("LTE_usedate")).trim();
			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_usedate");
			} else {
				Date date1 = new Date();
				try {
					date1 = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date1);
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_usedate", calendar.getTime());
				model.addAttribute("b", endDate);
			}
		}

		/*
		 * if(searchParams.containsKey("EQ_state")){ String mername = (String)
		 * searchParams.get("EQ_state"); if(mername == null ||
		 * "".equals(mername.trim())){ searchParams.remove("LIKE_mername");
		 * }else{ searchParams.put("LIKE_mername", mername.trim());
		 * model.addAttribute("LIKE_mername", mername); }
		 * 
		 * }
		 */

		if (searchParams.containsKey("EQ_state")) {
			if (searchParams.get("EQ_state").toString().equals("0")) {
				searchParams.remove("EQ_state");
			}
		}

		List<Actcardrecord> actcardrecordlist = actcardrecordService.getDownRecord(searchParams);

		try {
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String pbasepath = request.getSession().getServletContext().getRealPath("/"); // 获取文件的跟目录
			String filename = sdf.format(d) + ".xls";
			String mypath = pbasepath + "downloadDYJ" + File.separator + "excelKJ";
			File file = new File(mypath);
			if (!file.exists()) {
				file.mkdirs();
			}

			WritableWorkbook wwb = null;// 创建可以写入的工作簿
			File filepath = new File(file.getPath() + File.separator + filename);
			if (!filepath.exists()) {
				filepath.createNewFile();
			}

			wwb = Workbook.createWorkbook(filepath);// 以fileName为文件名来创建一个Workbook
			WritableSheet ws = wwb.createSheet("Shee1", 0); // 创建工作表
			// 要插入到excel表格的行号，默认从0开始
			/* ws.mergeCells(0, 0, 5, 0); */
			Label labelId = new Label(0, 0, "序号");
			Label labelno1 = new Label(1, 0, "编号");
			Label labelno2 = new Label(2, 0, "使用商户");
			Label labelno3 = new Label(3, 0, "使用时间");
			Label labelno4 = new Label(4, 0, "昵称");
			Label labelno5 = new Label(5, 0, "获奖时间");
			Label labelno6 = new Label(6, 0, "抵用券");
			ws.addCell(labelId);
			ws.addCell(labelno1);
			ws.addCell(labelno2);
			ws.addCell(labelno3);
			ws.addCell(labelno4);
			ws.addCell(labelno5);
			ws.addCell(labelno6);
			for (int i = 0; i < actcardrecordlist.size(); i++) {
				Label labelId_i = new Label(0, i + 1, i + 1 + "");
				Label labelno1_i = new Label(1, i + 1, actcardrecordlist.get(i).getCode());

				Label labelno2_i = new Label(2, i + 1, actcardrecordlist.get(i).getMername());

				Label labelno3_i = null;
				if (actcardrecordlist.get(i).getUsedate() != null) {
					labelno3_i = new Label(3, i + 1, actcardrecordlist.get(i).getUsedate() + "");
				} else {
					labelno3_i = new Label(3, i + 1, "");
				}

				Label labelno4_i = new Label(4, i + 1, actcardrecordlist.get(i).getNickname());

				Label labelno5_i = null;
				if (actcardrecordlist.get(i).getWintime() != null) {
					labelno5_i = new Label(5, i + 1, actcardrecordlist.get(i).getWintime() + "");
				} else {
					labelno5_i = new Label(5, i + 1, "");
				}
				Label labelno6_i = new Label(6, i + 1, actcardrecordlist.get(i).getName());
				ws.addCell(labelId_i);
				ws.addCell(labelno1_i);
				ws.addCell(labelno2_i);
				ws.addCell(labelno3_i);
				ws.addCell(labelno4_i);
				ws.addCell(labelno5_i);
				ws.addCell(labelno6_i);
			}
			wwb.write();
			wwb.close();

			// 文件下载
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-Disposition", "attachment;fileName=" + filename);

			InputStream inputstream = new FileInputStream(filepath);
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputstream.read(b)) > 0) {
				os.write(b, 0, length);
			}
			// 关闭下载
			os.close();
			inputstream.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	// 商户核销查看
	@RequestMapping(value = "/mycar")
	public String getbymcar(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		searchParams = Util.changeEncoding(searchParams);
		User user = (User) request.getSession().getAttribute("user");
		Merchant mer = user.getMerchant();
		if (mer != null) {
			searchParams.put("EQ_merid", mer.getId());
		}

		if (searchParams.containsKey("GTE_usedate")) {
			String usedate = ((String) searchParams.get("GTE_usedate")).trim();

			if (usedate.equals("null") || usedate.equals("")) {
				searchParams.remove("GTE_usedate");
			} else {
				Date date = new Date();
				try {
					date = new SimpleDateFormat("yyyy-MM-dd").parse(usedate);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				searchParams.put("GTE_usedate", date);
			}
			model.addAttribute("a", usedate);
		}

		if (searchParams.containsKey("LTE_usedate")) {
			String endDate = ((String) searchParams.get("LTE_usedate")).trim();
			if (endDate.equals("null") || endDate.equals("")) {
				searchParams.remove("LTE_usedate");
			} else {
				Date date1 = new Date();
				try {
					date1 = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date1);
				calendar.add(Calendar.DATE, 1);
				searchParams.put("LTE_usedate", calendar.getTime());
				model.addAttribute("b", endDate);
			}
		}

		if (searchParams.containsKey("EQ_state")) {
			if (searchParams.get("EQ_state").toString().equals("0")) {
				searchParams.remove("EQ_state");
			}
		}

		Page<Actcardrecord> actcardrecordlist1 = actcardrecordService.getList(searchParams, pageNumber, pageSize,
				sortType);
		model.addAttribute("actcardrecordlist", actcardrecordlist1);
		model.addAttribute("sortType", sortType);
		model.addAttribute("sortTypes", sortTypes);

		if (searchParams.containsKey("LTE_usedate")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.setTime((Date) searchParams.get("LTE_usedate"));
			calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - 1);
			String str = sdf.format(calendar.getTime());
			searchParams.put("LTE_usedate", str);
		}

		if (searchParams.containsKey("GTE_usedate")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchParams.put("GTE_usedate", sdf.format(searchParams.get("GTE_usedate")));
		}

		return "temporary/mactcardrecord";
	}

	@RequestMapping(value = "imfile")
	@ResponseBody
	public Map<String, Object> upfile(HttpServletRequest request,
			@RequestParam(value = "fileToUpload", required = false) MultipartFile file) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> jhlist = new ArrayList<String>();
		try {
			String filename = file.getOriginalFilename();// 获取文件上传的名称
			String crip = request.getRemoteAddr();// 获取客户端的IP地址
			User user = (User) request.getSession().getAttribute("user");
			Long orid = user.getId();// 获得当前用户的id;
			String username = user.getName();// 获取当前用户名
			if (inrecordService.getre(filename) != null) {
				map.put("msg", 0);

			} else {
				HSSFWorkbook wookbook = new HSSFWorkbook(file.getInputStream());
				HSSFSheet sheet = wookbook.getSheetAt(0);
				// 获取excel文件中所有的行数
				int rows = sheet.getPhysicalNumberOfRows();
				String[][] datas = new String[rows][3];
				// 遍历行
				for (int i = 0; i < rows; i++) {
					// 读取左上端单元格
					HSSFRow row = sheet.getRow(i);
					// 行不为空
					if (row != null) {
						// 获取到Excel文件中的所有的列
						int cells = row.getPhysicalNumberOfCells();

						// 遍历列
						for (int j = 0; j < 3; j++) {
							String value = "";
							// 获取到列的值
							HSSFCell cell = row.getCell(j);
							if (cell != null) {
								switch (cell.getCellType()) {
								case HSSFCell.CELL_TYPE_FORMULA:
									break;
								case HSSFCell.CELL_TYPE_NUMERIC:
									DecimalFormat df = new DecimalFormat("#");
									value += df.format(cell.getNumericCellValue()) + "";
									break;
								case HSSFCell.CELL_TYPE_STRING:
									value += cell.getStringCellValue() + "";
									break;
								default:
									value += "0";
									break;
								}
							}
							datas[i][j] = value;
						}
						/* String[] val = value.split(","); */
						/* int size=val.length; */
						// String val = value;
						// jhlist.add(val);
					}
				}
				System.out.println();
				Date now = new Date();
				for (int i = 0; i < datas.length; i++) {
					tmphb t = new tmphb();
					t.setNickname(datas[i][0]);
					t.setCreatetime(now);
					t.setOpenid(datas[i][1]);
					t.setPrice(Integer.parseInt(datas[i][2]));
					t.setState(1);
					tmphbService.save(t);
				}
				// map.put("list",jhlist);
				// Inrecord inred=new Inrecord();
				// inred.setRecord(filename);
				// inred.setCreateip(crip);
				// inred.setCreatetime(new Date());
				// inred.setCreatorid(orid);
				// inred.setName(username);
				// inrecordService.mysave(inred);
				// map.put("msg", 1);

				// 将文件保存至服务器上的指定目录下
				String pbasepath = request.getSession().getServletContext().getRealPath("/"); // 获取文件的跟目录
				String mypath = pbasepath + File.separator + "upload" + File.separator + "excel";
				File newmypath = new File(mypath);
				if (!newmypath.exists()) {
					newmypath.mkdirs();
				}
				String newpath = newmypath.getPath() + File.separator + filename;
				file.transferTo(new File(newpath));
			}
		} catch (FileNotFoundException e) {
			// TODO: handle exception
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}

	@RequestMapping(value = "im")
	public String getby() {
		return "temporary/impo";
	}

	@RequestMapping(value = "sendbg")
	@ResponseBody
	public String sendbg() {
		List<tmphb> lt = tmphbService.getList();
		WeChatAccount w = new WeChatAccount();
		w.setApikey("hillsun123456789yijiayi987654321");
		w.setAccesstoken(
				"hzQOZ9v8gu9_srFmXGXzHBN4t0vgdIbtARkgBb1uL-agMY3YHgghMGufklWJvhe1O7-nD0-vmlFgplCk4Q3XfttOV7BtmjctX2Quc5S1kHcBVOjAIAEYR");
		w.setAppid("wxf5b9abfb1c7d734d");
		w.setMcid("1267639601");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date now = new Date();
		for (tmphb t : lt) {
			String billno = w.getMcid() + sdf.format(now) + Util.getRandomNumber(10);
			if (WXManage.sendPrize(w, t.getOpenid(), t.getPrice() * 100, "感谢您参加\"金阿福e服务\"答题活动，因话费无法充值，现以红包形式发放，请查收!",
					"无", "金阿福e服务", "金阿福e服务", "金阿福e服务双11活动", billno)) {
				t.setBillno(billno);
				t.setState(2);
			} else {
				t.setState(3);
			}
			tmphbService.save(t);
		}
		return "1";
	}
}
