<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>卡卷核销</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<%@ include file="../quote.jsp"%>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script src="${ctx}/static/mt/media/js/form-components.js"></script>
</head>
  <script>
  
  jQuery(document).ready(function(){
	
	initDate();
	/* $("#datepicker1").datepicker({
		dateFormat : 'yyyy mm dd',
		rtl : App.isRTL()
	}); */
});

function initDate() {

    if (jQuery().datepicker) {
        $(".date-picker").datepicker({
            rtl : App.isRTL()
        });
    }
}
     function  formsubmit(){
    	 /* if($("#mername").val()==null||$.trim($("#mername").val())==''){
    		 window.parent.showAlert("请输入商户名称!");
 			$(this).focus();
 			return false;
    	 }else if($("#startDate").val()==null||$.trim($("#startDate").val())==''){
 			window.parent.showAlert("请选择使用时间!");
			$(this).focus();
			return false;
		} */
    	 $("#formid").submit();
     }
     
     
     function resetAll(){
     	$("#mername").val('');
     	$("#startDate").val('');
     	$("#datepicker1").val("");
     }
     
     function  forimp(){
    	 var date=getMap($("#formid").serialize());
         url="${ctx}//actcardrecord/imp?"+$("#formid").serialize();
            window.open(url,"_blank"); 
     }
  </script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;"> 核销记录查询
			</h3>
		</div>
	</div>

	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>数据查询
			</div>
		</div>

		<div class="portlet-body" style="padding-top: 25px;">
			<form class="form-horizontal" action="${ctx}/actcardrecord" method="post" id="formid">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%;text-align: left;"><label
							style="float: left; line-height: 32px;">商户名称：</label> <input
							type="text" id="mername" class="" name="search_LIKE_mername"
							value="${LIKE_mername}" style="width: 40%; height: 32px; float: left;">
						</td>

						<td
							style="width: 33%; vertical-align: middle; padding-left: 30px;">
							<span>使用开始时间：</span>
							<div class="input-append date date-picker" data-date=""
								data-date-format="yyyy-mm-dd" data-date-viewmode="years">
								<input class="m-wrap m-ctrl-medium date-picker" id="startDate"
									name="search_GTE_usedate" readonly size="16" type="text"
									value="${GTE_usedate}" style="height:20px; width: 155px;" /><span
									class="add-on"><i class="icon-calendar"></i></span>
							</div>
						</td>
                           
                       <%--   <td style="width: 33%;"><label class="control-label"
							style="float: left; width: 100px">到</label><input type="text"
							id="datepicker1" name="search_LTE_usedate" maxlength="20"
							readonly="readonly"
							style="float: left; width:155px; height:25px;" class=""
							value="${LTE_usedate}"></td> --%>
							
							<td style="width: 33%; vertical-align: middle;">
						<span >使用结束时间：</span>
						 <div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
					          <input class="m-wrap m-ctrl-medium date-picker" id="datepicker1" name="search_LTE_usedate" readonly size="16" type="text" value="${LTE_usedate}" style="height:20px;width: 155px;"/><span class="add-on"><i class="icon-calendar"></i></span>
				          </div>
					</td>
                         
                         </tr> 
                          <tr>
                           <td style="width: 33%">
                              <label class="control-label"
							style="float: left; width:70px">状态：</label><select class=""
							id="mytype" style="width:44%; height:35px;"
							name="search_EQ_state">
							   <option value="0">--请选择--</option>
							   <option value="1"
									<c:if test="${EQ_state==1}" > selected="selected" </c:if>>正常</option>
								<option value="2"
									<c:if test="${EQ_state==2}" > selected="selected" </c:if>>已使用</option>
								<option value="3"
									<c:if test="${EQ_state==3}" > selected="selected" </c:if>>过期</option>
							</select>
                            </td>
                           <td style="width: 33%"></td>
						<td style="width: 33%"><label class="control-label"style="width: 100px"></label>
							<button type="button" class="btn blue" id="search_btn"
								onclick="formsubmit()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="search_btn"
								onclick="resetAll()">重置</button>
						    <button class="btn red" id="search_btn1" onclick="forimp()">
						                                                    导出记录
						    </button>
								</td>
						
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	 <div  class="portlet box grey">
	    <div class="portlet-title">
          <div class="caption">
            <i class="icon-globe"></i>列表
          </div>
          </div>
          
          <div class="portlet-body">
               <table id="contentTable"class="table table-striped table-bordered table-hover">
                  <thead>
                      <tr>
                         <th style="width: 7%; text-align: center;">序号</th>
                         <th style="width: 7%; text-align: center;">抵用券面值</th>
                          <th style="width: 10%; text-align: center;">昵称</th>
                           <th style="width: 10%; text-align: center;">获奖时间</th>
                         <th style="width: 10%; text-align: center;">商户名称</th>
                        <th style="width: 10%; text-align: center;">使用时间</th>
                         <th style="width: 10%; text-align: center;">状态</th>
                        
                        <!--  7 <th style="width: 10%; text-align: center;">抽奖记录ID</th> -->
                        
                          <!-- <th style="width: 7%; text-align: center;">商户ID</th> -->
                      </tr>
                  </thead>
                  <tbody>
                       <c:forEach items="${actcardrecordlist.content}" var="actcardrecord"  varStatus="status">
                          <tr>
                         <td style="text-align: center;">${status.count}</td> 
                          
                         <td style="text-align: center;">${actcardrecord.name}</td> 
                         
                           <td style="text-align: center;">${actcardrecord.nickname}</td> 
                          
                           <td style="text-align: center;">${fn:substring(actcardrecord.wintime,0,10)}</td> 
                          
                         <td style="text-align: center;">${actcardrecord.mername}</td> 
                          
                          <td style="text-align: center;">${fn:substring(actcardrecord.usedate,0,16)}</td> 
                          
                         <td style="text-align: center;">
                             <c:if test="${actcardrecord.state==1}">正常</c:if>
                             <c:if test="${actcardrecord.state==2}">使用</c:if>
                             <c:if test="${actcardrecord.state==3}">过期</c:if>
                          </td> 
                          
                       
                          
                       <%--  7  <td style="text-align: center;">${actcardrecord.trid}</td>  --%>
                          
                         
                         </tr>  
                       </c:forEach>
                       <c:if test="${actcardrecordlist.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="8" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
                  </tbody>
               </table>
               
               <tags:pagination page="${actcardrecordlist}" paginationSize="5" />
          </div>
          
          
	 </div>
	
</body>
</html>