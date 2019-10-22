<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<body>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="<c:url value='/resources/dist/img/user01.jpg' />" class="img-circle"
					alt="User Image">
			</div>
			<div class="pull-left info">
				<p>${login.uId}</p>
				<a href="/user/login"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>
		<!-- search form -->
		<form action="#" method="get" class="sidebar-form">
			<div class="input-group">
				<input type="text" name="q" class="form-control"
					placeholder="Search..."> <span class="input-group-btn">
					<button type="submit" name="search" id="search-btn"
						class="btn btn-flat">
						<i class="fa fa-search"></i>
					</button>
				</span>
			</div>
		</form>
		<!-- /.search form -->
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">MAIN NAVIGATION</li>
			<li class="active treeview"><a href="#"> <i
					class="fa fa-dashboard"></i> <span>Dashboard</span> <span
					class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li class="active"><a href="/dashboard/index1"><i
							class="fa fa-circle-o"></i> Dashboard v1</a></li>
					<li><a href="/dashboard/index2"><i class="fa fa-circle-o"></i>
							Dashboard v2</a></li>
				</ul></li>
			<li class="treeview"><a href="#"> <i class="fa fa-files-o"></i>
					<span>Layout Options</span> <span class="pull-right-container">
						<span class="label label-primary pull-right">4</span>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="pages/layout/top-nav.html"><i
							class="fa fa-circle-o"></i> Top Navigation</a></li>
					<li><a href="pages/layout/boxed.html"><i
							class="fa fa-circle-o"></i> Boxed</a></li>
					<li><a href="pages/layout/fixed.html"><i
							class="fa fa-circle-o"></i> Fixed</a></li>
					<li><a href="pages/layout/collapsed-sidebar.html"><i
							class="fa fa-circle-o"></i> Collapsed Sidebar</a></li>
				</ul></li>
			<li><a href="/sboard/list"> <i class="fa fa-th"></i> <span>Q&A</span>
					<span class="pull-right-container">
						<small class="label pull-right bg-green">new</small>
					</span>
			</a></li>
			<li class="treeview"><a href="#"> <i class="fa fa-pie-chart"></i>
					<span>Topology</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="pages/charts/topology" target="_blank"><i
							class="fa fa-circle-o"></i> Topology1</a></li>
					<li><a href="pages/charts/topology2" target="_blank"><i
							class="fa fa-circle-o"></i> Topology2</a></li>
					<li><a href="pages/charts/topology3" target="_blank"><i
							class="fa fa-circle-o"></i> Topology3</a></li>
					<li><a href="pages/charts/topology4" target="_blank"><i
							class="fa fa-circle-o"></i> Topology4</a></li>
					<li><a href="pages/charts/topology5" target="_blank"><i
							class="fa fa-circle-o"></i> Topology5</a></li>
					<li><a href="pages/charts/topology6" target="_blank"><i
							class="fa fa-circle-o"></i> Topology6(JSON)</a></li>
				</ul></li>
			<li class="treeview"><a href="#"> <i class="fa fa-laptop"></i>
					<span>UI Elements</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="pages/UI/general.html"><i
							class="fa fa-circle-o"></i> General</a></li>
					<li><a href="pages/UI/icons.html"><i
							class="fa fa-circle-o"></i> Icons</a></li>
					<li><a href="pages/UI/buttons.html"><i
							class="fa fa-circle-o"></i> Buttons</a></li>
					<li><a href="pages/UI/sliders.html"><i
							class="fa fa-circle-o"></i> Sliders</a></li>
					<li><a href="pages/UI/timeline.html"><i
							class="fa fa-circle-o"></i> Timeline</a></li>
					<li><a href="pages/UI/modals.html"><i
							class="fa fa-circle-o"></i> Modals</a></li>
				</ul></li>
			<li class="treeview"><a href="#"> <i class="fa fa-edit"></i>
					<span>Forms</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="<c:url value='/board/register' />"><i
							class="fa fa-circle-o"></i> General Elements</a></li>
					<li><a href="<c:url value='/board/listAll' />"><i
							class="fa fa-circle-o"></i> Advanced Elements</a></li>
					<li><a href="<c:url value='/board/modify' />"><i
							class="fa fa-circle-o"></i> Editors</a></li>
				</ul></li>
			<li class="treeview"><a href="#"> <i class="fa fa-table"></i>
					<span>Tables</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="/pages/tables/simple"><i
							class="fa fa-circle-o"></i> Simple tables</a></li>
					<li><a href="/pages/tables/data"><i
							class="fa fa-circle-o"></i> Data tables</a></li>
				</ul></li>
			<li><a href="/pages/calendar"> <i class="fa fa-calendar"></i>
					<span>Calendar</span> <span class="pull-right-container"> <small
						class="label pull-right bg-red">3</small> <small
						class="label pull-right bg-blue">17</small>
				</span>
			</a></li>
			<li><a href="mailto:mincloud@sk.com"> <i
					class="fa fa-envelope"></i> <span>Mailbox</span> <span
					class="pull-right-container"> <small
						class="label pull-right bg-yellow">12</small> <small
						class="label pull-right bg-green">16</small> <small
						class="label pull-right bg-red">5</small>
				</span>
			</a></li>
			<li class="treeview"><a href="#"> <i class="fa fa-folder"></i>
					<span>Examples</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="pages/examples/invoice.html"><i
							class="fa fa-circle-o"></i> Invoice</a></li>
					<li><a href="pages/examples/profile.html"><i
							class="fa fa-circle-o"></i> Profile</a></li>
					<li><a href="pages/examples/login.html"><i
							class="fa fa-circle-o"></i> Login</a></li>
					<li><a href="pages/examples/register.html"><i
							class="fa fa-circle-o"></i> Register</a></li>
					<li><a href="pages/examples/lockscreen.html"><i
							class="fa fa-circle-o"></i> Lockscreen</a></li>
					<li><a href="pages/examples/404.html"><i
							class="fa fa-circle-o"></i> 404 Error</a></li>
					<li><a href="pages/examples/500.html"><i
							class="fa fa-circle-o"></i> 500 Error</a></li>
					<li><a href="pages/examples/blank.html"><i
							class="fa fa-circle-o"></i> Blank Page</a></li>
					<li><a href="pages/examples/pace.html"><i
							class="fa fa-circle-o"></i> Pace Page</a></li>
				</ul></li>
			<li class="treeview"><a href="#"> <i class="fa fa-share"></i>
					<span>Multilevel</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
					<li class="treeview"><a href="#"><i class="fa fa-circle-o"></i>
							Level One <span class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="#"><i class="fa fa-circle-o"></i> Level Two</a></li>
							<li class="treeview"><a href="#"><i
									class="fa fa-circle-o"></i> Level Two <span
									class="pull-right-container"> <i
										class="fa fa-angle-left pull-right"></i>
								</span> </a>
								<ul class="treeview-menu">
									<li><a href="#"><i class="fa fa-circle-o"></i> Level
											Three</a></li>
									<li><a href="#"><i class="fa fa-circle-o"></i> Level
											Three</a></li>
								</ul></li>
						</ul></li>
					<li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
				</ul></li>
			<li><a href="/pages/treeview" data-toggle="modal" data-target="#modal-default"><i class="fa fa-book"></i>
					<span>Tree Sample</span></a></li>
			<li class="header">LABELS</li>
			<li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
			<li><a href="#"><i class="fa fa-circle-o text-yellow"></i> <span>Warning</span></a></li>
			<li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>
</body>

<!-- Sart Modal -->
<div class="modal fade" id="modal-default">
   <div class="modal-dialog modal-lg">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">Default Modal</h4>
       </div>
       <div class="modal-body">
         <p>One fine body&hellip;</p>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
         <button type="button" class="btn btn-primary">Save changes</button>
       </div>
     </div>
  </div>
</div>
<!--  End Modal -->

</html>