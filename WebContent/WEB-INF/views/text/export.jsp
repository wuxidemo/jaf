<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
 <% 

String a = "";
if(request.getParameter("search_GTE_starttime")!=null){
	a=new String(request.getParameter("search_GTE_createtime").getBytes("ISO-8859-1"),"UTF-8");  
}

String b = "";
if(request.getParameter("search_LTE_starttime")!=null){
	b=new String(request.getParameter("search_LTE_createtime").getBytes("ISO-8859-1"),"UTF-8"); 
 }
 %>


<html>
<head>
<title>积分兑换记录</title>

	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css"/>
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
	<script src="${ctx}/static/mt/media/js/form-components.js"></script>

</head>
<script>

jQuery(document).ready(function(){
	
	initDate();
});

function initDate() {

    if (jQuery().datepicker) {
        $(".date-picker").datepicker({
            rtl : App.isRTL()
        });
    }
}


    function resetAll(){
    	$("#startDate").val('');
    	$("#endDate").val('');
    }
    
    function outfile(){
 	   window.parent.showConfirm("确认导出默认文件位置为    D://inuser.xls",suDisable);
    }
    function suDisable(){
 	   var url="${ctx}/imoup/oufile";
 	   window.location.href = url;
    }
    
    function outfile1(){
    	var startdate = $("#startDate").val();
    	var enddate = $("#endDate").val();            
    	
    	window.location.href ="${ctx}/export/oufile3?d1="+startdate+"&d2="+enddate;
    }
      function formsubmit(){
    	  if($("#startDate").val()==null||$.trim($("#startDate").val())==''){
    			window.parent.showAlert("请选择开始时间!");
    			$(this).focus();
    			return false;
    		} else if($("#endDate").val()==null||$.trim($("#endDate").val())==''){
    			window.parent.showAlert("请选择结束时间!");
    			$(this).focus();
    			return false;
    		}
    	  $("#formid").submit();
      }
</script>
<body>
  <div class="row-fluid">
   <div class="span12">
     <h3 class="page-title">
       <img src="${ctx}/static/images/xtgl.png"style="vertical-align:text-bottom;">
       积分兑换记录
     </h3>
   </div>
</div>
   <div class="portlet box grey"style="margin-bottom:0px;height:auto;">
      <div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>数据查询
			</div>
		</div> 
		
	<div class="portlet-body"style="padding-top:25px;">
        <form class="form-horizontal" action="${ctx}/export" id="formid"method="POST">
            <table style="width: 100%">
                <tr>
                  <td style="width: 33%; vertical-align: middle; padding-left:30px;">
						<span>开始时间：</span>
						<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
					          <input class="m-wrap m-ctrl-medium date-picker" id="startDate" name="search_GTE_createtime" readonly size="16" type="text" value="${a}" style="height:34px;width: 155px;"/><span class="add-on"><i class="icon-calendar"></i></span>
				         </div>
					</td>
	                       <td style="width: 33%; vertical-align: middle;">
						<span >结束时间：</span>
						 <div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
					          <input class="m-wrap m-ctrl-medium date-picker" id="endDate" name="search_LTE_createtime" readonly size="16" type="text" value="${b}" style="height:34px;width: 155px;"/><span class="add-on"><i class="icon-calendar"></i></span>
				          </div>
					</td>
					
					<%-- <td >
						<label class="control-label">开始时间：</label>
						<div class="controls">
					      <div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
					          <input class="m-wrap m-ctrl-medium date-picker" id="startDate" name="search_GTE_createtime" readonly size="16" type="text" value="${a}" style="height:20px;width: 155px;"/><span class="add-on"><i class="icon-calendar"></i></span>
				          </div>
				         </div>
					</td>
	                       <td >
						<label class="control-label">结束时间：</label>
						<div class="controls">
					      <div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
					          <input class="m-wrap m-ctrl-medium date-picker" id="endDate" name="search_LTE_createtime" readonly size="16" type="text" value="${b}" style="height:20px;width: 155px;"/><span class="add-on"><i class="icon-calendar"></i></span>
				          </div>
				         </div>
					</td> --%>
					
            
				<td>
					<label class="control-label"></label>
                     <button type="button" class="btn blue" id="search_btn"onclick="formsubmit()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
                    <!--   <button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp; -->
				     <button type="button" class="btn" id="search_btn" onclick="resetAll()">重置</button>
                </td>
              </tr>
          </table>
        </form>
   </div> 	
   </div>
   <div class="portlet box grey">
    <div class="portlet-title">
          <div class="caption">
            <i class="icon-globe"></i>列表
          </div>
         <div class="actions">
          <a href="javascript:;" class="btn blue"onclick="outfile1()"><i class=""></i>导出</a>
          <%--  <a href="${ctx}/export/oufile1" class="btn blue""><i class=""></i>导出</a> --%>
           <a href="${ctx}/export/oufile2" class="btn red"><i class=""></i>导出昨天</a>      
         </div>
        </div>
        
        <div class="portlet-body">
        <div class="row-fluid" style="font-size: 20px;">汇总结果</div>
        <div class="row-fluid"
				style="margin-top: 10px; margin-left: 50px; margin-bottom: 10px;">领用数量：${totalcount}
				&nbsp;&nbsp;&nbsp;领用总额（元）：${totalprice/100.0}&nbsp;&nbsp;&nbsp;领用总积分：${totaljf}
				&nbsp;&nbsp;&nbsp;使用数量：${usecount}&nbsp;&nbsp;&nbsp;使用卡券总额（元）：${useprice}
				</div>
            <table id="sample_1"
				class="table table-striped table-bordered table-hover">
			 <thead>
                <tr>
                   <th style="width: 10%">序号</th>
                   <th style="width: 15%">名字</th>
                   <th style="width: 10%">积分</th>
                   <th style="width: 10%">卡号</th>
                   <th style="width: 10%">名称</th>
                   <th style="width: 15%">时间</th>
                  
                   
                </tr>
             </thead>
             <tbody>
                  <c:forEach items="${IntegralRecords.content}" var="IntegralRecord" varStatus="status">
                    <tr>
                     <td>${status.count}</td>
                     
                       <td>${IntegralRecord.name}</td>   
                     
                        <td>${IntegralRecord.count}</td> 
                      
                        <td>${IntegralRecord.cardnum}</td> 
                       
                         <td>${IntegralRecord.cardname}</td>    
               
                         <td>${IntegralRecord.createtime}</td>
                      </tr>
                 </c:forEach>
                 <c:if test="${IntegralRecords.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="8" style="text-align: center;">后台暂无记录</td>
						</tr>
					</c:if>
             </tbody>
			</table>
			 <tags:pagination page="${IntegralRecords}" paginationSize="5"/>
        </div>
   </div>
</body>
</html>