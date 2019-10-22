<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
<%@include file="../include/side.jsp"%>


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
					<input type="hidden" name="searchType" value="${cri.searchType }">
					<input type="hidden" name="keyword" value="${cri.keyword }">
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
			self.location="/sboard/list?page=${cri.page}&perPageNum=${cri.perPageNum}"+"&searchType=${cri.searchType}&keyword="+encodeURIComponent("${cri.keyword}");
		});
		$(".btn-primary").on("click", function() {
			formObj.submit();
		});
	});
</script>