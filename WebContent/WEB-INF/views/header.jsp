<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.yjy.entity.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	User user = (User)request.getSession().getAttribute("user");
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<div class="header navbar navbar-inverse navbar-fixed-top" >
		<div class="navbar-inner" style="background-image:url('${ctx}/static/images/wz/zy2.jpg') !important;height:46px;">
			<div class="container-fluid">
				<a class="" href="${ctx}">
					<img src="${ctx}/static/images/zy2.png" alt="logo" />
				</a>
				<a href="javascript:;" class="btn-navbar collapsed" data-toggle="collapse" data-target=".nav-collapse">
					<img src="${ctx}/static/mt/media/image/menu-toggler.png" alt="" />
				</a>          
				<ul class="nav pull-right">
					
					
					<li class="dropdown user" style="margin-top: 5px;margin-right:20px;">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
							<%-- <img alt="" src="${ctx}/static/mt/media/image/avatar1_small.jpg" /> --%>
							<span class="username">当前版本:<span style="color: rgb(86, 86, 53);font-size:1.2em;">&nbsp;&nbsp;&nbsp;beta0.5</span> </span>
						</a>
					</li>
					 
					<%
						if(user.getRole() != null) {
							if(user.getRole().getId() != 2){
					%>
					<!-- 
					<li class="dropdown" id="header_task_bar" style="margin-top: 2px;">
						<a href="#" class="dropdown-toggle" style="padding: 10px 7px;" data-toggle="dropdown">
							<i class="icon-envelope"></i>
							<span id="warmnum" class="badge"></span>
						</a>
						<ul id="warmul" class="dropdown-menu extended notification">
							<li>
								<a href="#">
									<span style="color:green;font-size:1.2em;">&emsp;&emsp;暂无最新的通知公告！</span>
									<span class="time"></span>
								</a>
							</li>
						</ul>
					</li>
							 -->	
					<%			
							}
						}
					%>
					<!-- 
					<li class="dropdown" id="phonebox" style="margin-top: 2px;display: none">
						<a href="#" class="dropdown-toggle" style="padding: 10px 7px;" data-toggle="dropdown">
						<img id="phoneboximg" alt="" src="${ctx}/static/images/phoneboxdown.png" style="width: 20px;height: 20px;margin-top: -5px;">
							<span id="warmnum" class="badge" ></span>
						</a>
					</li>
					 -->
					<li class="dropdown user" style="margin-top: 5px;">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<%-- <img alt="" src="${ctx}/static/mt/media/image/avatar1_small.jpg" /> --%>
							<span class="username">欢迎您:<span ><%=user.getRealname() %></span> </span>
							<i class="icon-angle-down"></i>
						</a>
						<ul class="dropdown-menu">
							<li><a href="${ctx}/logout"><i class="icon-key"></i> 退出</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>