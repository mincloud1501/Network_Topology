<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
<%@include file="../include/side.jsp"%>

<!-- DataTables -->
<link rel="stylesheet" href="../../resources/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">

<script>
	var result = '${msg}';
	if (result == "SUCCESS")
		alert('처리가 완료되었습니다.');
</script>

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
			<div class="col-xs-12">
			
				<!-- Horizontal Form -->
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">List All Page</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<div class="form-inline">
							<select name="searchType" class="form-control">
								<option value="n"
									<c:out value="${cri.searchType==null?'selected':'' }"/>>-----------</option>
								<option value="t"
									<c:out value="${cri.searchType eq 't'?'selected':'' }"/>>Title</option>
								<option value="c"
									<c:out value="${cri.searchType eq 'c'?'selected':'' }"/>>Content</option>
								<option value="w"
									<c:out value="${cri.searchType eq 'w'?'selected':'' }"/>>Writer</option>
								<option value="tc"
									<c:out value="${cri.searchType eq 'tc'?'selected':'' }"/>>Title OR Content</option>
								<option value="cw"
									<c:out value="${cri.searchType eq 'cw'?'selected':'' }"/>>Content OR Writer</option>
								<option value="tcw"
									<c:out value="${cri.searchType eq 'tcw'?'selected':'' }"/>>Title OR Content OR Writer</option>
							</select> <input type="text" name='keyword' id="keywordInput" class="form-control" value='${cri.keyword }'>
							<button id='searchBtn' class="btn btn-info">Search</button>
							<button id='newBtn' class="btn btn-primary">New Board</button>
						</div>

						<div>
							<table id="example1" class="table table-bordered table-striped">
								<tr>
									<th style="width: 10px;">BNO</th>
									<th>TITLE</th>
									<th>WRITER</th>
									<th>REGDATE</th>
									<th style="width: 40px;">VIEWCNT</th>
								</tr>
								<c:forEach items="${list }" var="boardVO">
									<tr>
										<td>${boardVO.bNo }</td>
										<td><a
											href="<c:url value='/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page)}&bNo=${boardVO.bNo}' />">${boardVO.title }<strong>[${boardVO.replyCnt }]</strong></a></td>
										<td>${boardVO.writer }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${boardVO.regDate}" /></td>
										<td><span class="badge bg-red">${boardVO.viewCnt }</span></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					
					<div class="box-footer">
						<div class="text-center">
							<ul class="pagination">
								<c:if test="${pageMaker.prev}">
									<li class="page-item "><a class="page-link"
										href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }"
										tabindex="-1">&laquo;</a></li>
								</c:if>
								<c:if test="${not pageMaker.prev}">
									<li class="page-item disabled"><a class="page-link"
										href="#" tabindex="-1">&laquo;</a></li>
								</c:if>
								<c:forEach begin="${pageMaker.startPage }"
									end="${pageMaker.endPage }" var='idx'>
									<li
										<c:out value="${pageMaker.cri.page == idx?'class =active page-item':'class =page-item' }"/>><a
										class="page-link" href="list${pageMaker.makeSearch(idx)}">${idx }</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li class="page-item"><a class="page-link"
										href="list${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
								</c:if>
								<c:if test="${not pageMaker.next || pageMaker.endPage <= 0}">
									<li class="page-itemv disabled"><a class="page-link"
										href="#">&raquo;</a></li>
								</c:if>
							</ul>
						</div>
					</div>
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
	$(document).ready(
			function() {

				$('#searchBtn').on(
						"click",
						function(event) {

							self.location = "list"
									+ '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + encodeURIComponent($('#keywordInput').val());
						});

				$('#newBtn').on("click", function(evt) {

					self.location = "register";

				});

			});
</script>

<!-- DataTables -->
<script src="../../resources/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="../../resources/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>

<!-- page script -->
<script>
  $(function () {
    $('#example1').DataTable()
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false
    })
  })
</script>