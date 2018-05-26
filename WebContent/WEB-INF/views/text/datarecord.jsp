<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>导入记录</title>
<%@ include file="../quote.jsp"%>
<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<body>
    <div class="row-fluid">
      <div class="span12">
         <h3 class="page-title">
          <img src="${ctx}/static/images/xtgl.png"style="vertical-align:text-bottom;">数据导入
         </h3>
      </div>
    </div>
    <div class="portlet box grey">
      <div class="portlet-title">
          <div class="caption">
            <i class="icon-globe"></i>列表
          </div>
         <div class="actions">
         <a href="${ctx}/imoup/outipot" class="btn blue"><i class=""></i>导入数据</a> 
          <%--  <a href="${ctx}/imoup" class="btn red"><i class=""></i>刷新</a>       --%>
         </div>
        </div>
        
        <div  class="portlet-body">
            <table id="sample_1"
				class="table table-striped table-bordered table-hover">
			  <thead>
			     <tr>
			       <th style="width: 10%">序号</th>
			       <th style="width: 15%">文件名</th>
			       <th style="width: 30%">用户ip</th>
			       <th style="width: 30%">操作时间</th>
			       <th style="width: 15%">用户名</th>
			     </tr>
			  </thead>
			  <tbody>
			       <c:forEach items="${datarecords.content}" var="datarecord" varStatus="status">
			           <tr>
			             <td>${status.count}</td>
			              <td>${datarecord.record}</td>
			               <td>${datarecord.createip}</td>
			                <td>${datarecord.createtime}</td>
			                 <td>${datarecord.name}</td>
			           </tr>
			        </c:forEach>
			         <c:if test="${datarecords.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="8" style="text-align: center;">暂无数据录入记录</td>
						</tr>
					</c:if>
			  </tbody>
			</table>
			<tags:pagination page="${datarecords}" paginationSize="3"/>
        </div>
    </div>
</body>
</html>