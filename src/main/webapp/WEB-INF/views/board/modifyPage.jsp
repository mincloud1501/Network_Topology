<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="<c:url value='/resources/dist/img/user2-160x160.jpg' />"  class="img-circle"	alt="User Image">
			</div>
			<div class="pull-left info">
				<p>Alexander Pierce</p>
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
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
			<li class="treeview"><a href="#"> <i class="fa fa-dashboard"></i>
					<span>Dashboard</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="../../index.html"><i class="fa fa-circle-o"></i>
							Dashboard v1</a></li>
					<li><a href="../../index2.html"><i class="fa fa-circle-o"></i>
							Dashboard v2</a></li>
				</ul></li>
			<li class="treeview"><a href="#"> <i class="fa fa-files-o"></i>
					<span>Layout Options</span> <span class="pull-right-container">
						<span class="label label-primary pull-right">4</span>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="../layout/top-nav.html"><i
							class="fa fa-circle-o"></i> Top Navigation</a></li>
					<li><a href="../layout/boxed.html"><i
							class="fa fa-circle-o"></i> Boxed</a></li>
					<li><a href="../layout/fixed.html"><i
							class="fa fa-circle-o"></i> Fixed</a></li>
					<li><a href="../layout/collapsed-sidebar.html"><i
							class="fa fa-circle-o"></i> Collapsed Sidebar</a></li>
				</ul></li>
			<li><a href="../widgets.html"> <i class="fa fa-th"></i> <span>Widgets</span>
					<span class="pull-right-container"> <small
						class="label pull-right bg-green">new</small>
				</span>
			</a></li>
			<li class="treeview"><a href="#"> <i class="fa fa-pie-chart"></i>
					<span>Charts</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="../charts/chartjs.html"><i
							class="fa fa-circle-o"></i> ChartJS</a></li>
					<li><a href="../charts/morris.html"><i
							class="fa fa-circle-o"></i> Morris</a></li>
					<li><a href="../charts/flot.html"><i
							class="fa fa-circle-o"></i> Flot</a></li>
					<li><a href="../charts/inline.html"><i
							class="fa fa-circle-o"></i> Inline charts</a></li>
				</ul></li>
			<li class="treeview"><a href="#"> <i class="fa fa-laptop"></i>
					<span>UI Elements</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="../UI/general.html"><i class="fa fa-circle-o"></i>
							General</a></li>
					<li><a href="../UI/icons.html"><i class="fa fa-circle-o"></i>
							Icons</a></li>
					<li><a href="../UI/buttons.html"><i class="fa fa-circle-o"></i>
							Buttons</a></li>
					<li><a href="../UI/sliders.html"><i class="fa fa-circle-o"></i>
							Sliders</a></li>
					<li><a href="../UI/timeline.html"><i
							class="fa fa-circle-o"></i> Timeline</a></li>
					<li><a href="../UI/modals.html"><i class="fa fa-circle-o"></i>
							Modals</a></li>
				</ul></li>
			<li class="treeview active"><a href="#"> <i
					class="fa fa-edit"></i> <span>Forms</span> <span
					class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="<c:url value='/board/register' />"><i class="fa fa-circle-o"></i>
							General Elements</a></li>
					<li class="active"><a href="<c:url value='/board/listAll' />"><i
							class="fa fa-circle-o"></i> Advanced Elements</a></li>
					<li><a href=""><i class="fa fa-circle-o"></i>
							Editors</a></li>
				</ul></li>
			<li class="treeview"><a href="#"> <i class="fa fa-table"></i>
					<span>Tables</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span>
			</a>
				<ul class="treeview-menu">
					<li><a href="../tables/simple.html"><i
							class="fa fa-circle-o"></i> Simple tables</a></li>
					<li><a href="../tables/data.html"><i
							class="fa fa-circle-o"></i> Data tables</a></li>
				</ul></li>
			<li><a href="../calendar.html"> <i class="fa fa-calendar"></i>
					<span>Calendar</span> <span class="pull-right-container"> <small
						class="label pull-right bg-red">3</small> <small
						class="label pull-right bg-blue">17</small>
				</span>
			</a></li>
			<li><a href="../mailbox/mailbox.html"> <i
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
					<li><a href="../examples/invoice.html"><i
							class="fa fa-circle-o"></i> Invoice</a></li>
					<li><a href="../examples/profile.html"><i
							class="fa fa-circle-o"></i> Profile</a></li>
					<li><a href="../examples/login.html"><i
							class="fa fa-circle-o"></i> Login</a></li>
					<li><a href="../examples/register.html"><i
							class="fa fa-circle-o"></i> Register</a></li>
					<li><a href="../examples/lockscreen.html"><i
							class="fa fa-circle-o"></i> Lockscreen</a></li>
					<li><a href="../examples/404.html"><i
							class="fa fa-circle-o"></i> 404 Error</a></li>
					<li><a href="../examples/500.html"><i
							class="fa fa-circle-o"></i> 500 Error</a></li>
					<li><a href="../examples/blank.html"><i
							class="fa fa-circle-o"></i> Blank Page</a></li>
					<li><a href="../examples/pace.html"><i
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
			<li><a href="https://adminlte.io/docs"><i class="fa fa-book"></i>
					<span>Documentation</span></a></li>
			<li class="header">LABELS</li>
			<li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
			<li><a href="#"><i class="fa fa-circle-o text-yellow"></i> <span>Warning</span></a></li>
			<li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			General Form Elements <small>Preview</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#">Forms</a></li>
			<li class="active">General Elements</li>
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<!-- right column -->
			<div class="col-md-12">
				<!-- Horizontal Form -->
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Modify Board</h3>
					</div>
					<!-- /.box-header -->
					<!-- form start -->
					<form role="form" action='modifyPage' class="form-horizontal" method="post">
					<input type="hidden" name="page" value="${cri.page }">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
						<div class="box-body">
							<div class="form-group">
								<label for="inputBno" class="col-sm-2 control-label">BNO</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="bNo"
										value="${boardVO.bNo }" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="inputTitle" class="col-sm-2 control-label">Title</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="title"
										value="${boardVO.title }">
								</div>
							</div>
							<div class="form-group">
								<label for="inputContent" class="col-sm-2 control-label">Content</label>
								<div class="col-sm-10">
									<textarea class="form-control" rows="3" name="content">${boardVO.content }</textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="inputWriter" class="col-sm-2 control-label">Writer</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="writer"
										value="${boardVO.writer }">
								</div>
							</div>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
							<button type="button" class="btn btn-warning">Cancel</button>
							<button type="button" class="btn btn-primary pull-right">Save</button>
						</div>
						<!-- /.box-footer -->
					</form>
				</div>
			</div>
		</div>
		<!-- /.row -->
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<%@include file="../include/footer.jsp"%>
<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		console.log(formObj);
		$(".btn-warning").on("click", function() {
			self.location="/board/listPage?page=${cri.page}&perPageNum=${cri.perPageNum}";
		});
		$(".btn-primary").on("click", function() {
			formObj.submit();
		});
	});
</script>