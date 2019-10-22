<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<%@include file="../include/side.jsp"%>

<script src="/resources/js/upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>

<!-- Main content -->
<style type="text/css">
.popup {
	position: absolute;
}

.back {
	background-color: gray;
	opacity: 0.5;
	width: 100%;
	height: 300%;
	overflow: hidden;
	z-index: 1101;
}

.front {
	z-index: 1110;
	opacity: 1;
	boarder: 1px;
	margin: auto;
}

.show {
	position: relative;
	max-width: 1200px;
	max-height: 800px;
	overflow: auto;
}
</style>
<div class='popup back' style="display: none;"></div>

<div id="popup_front" class='popup front' style="display: none;">
	<img id="popup_img">
</div>


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
						<h3 class="box-title">Read Board</h3>
					</div>
					<!-- /.box-header -->
					<form role='form' action="modifyPage" method="post">
						<input type="hidden" name='bNo' value='${boardVO.bNo }'>
						<input type="hidden" name='page' value='${cri.page }'>
						<input type="hidden" name='perPageNum' value='${cri.perPageNum }'>
						<input type="hidden" name='searchType' value='${cri.searchType }'>
						<input type="hidden" name='keyword' value='${cri.keyword }'>
					</form>
					
					<div class="box-body">
						<div class="box-body">
							<div class="form-group">
								<label for="inputTitle" class="col-sm-2 control-label">Title</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="title"
										value="${boardVO.title }" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="inputContent" class="col-sm-2 control-label">Content</label>
								<div class="col-sm-10">
									<textarea class="form-control" rows="3" name="content"
										readonly="readonly">${boardVO.content }</textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="inputWriter" class="col-sm-2 control-label">Writer</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="writer"
										value="${boardVO.writer }" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="inputRegDate" class="col-sm-2 control-label">Register Date</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="writer"
										value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regDate}" />"
										readonly="readonly">
								</div>
							</div>
						</div>
					</div>

					<ul class="mailbox-attachments clearfix uploadedList"></ul>
					<div class="box-footer">
						<c:if test="${login.uId == boardVO.writer }">
						<button type="submit" class="btn btn-warning" id="modifyBtn">Modify</button>
						<button type="submit" class="btn btn-danger" id="removeBtn">REMOVE</button>
						</c:if>
						<button type="submit" class="btn btn-primary" id="goListBtn">GO	LIST</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-md-12">

				<div class="box box-success">
					<div class="box-header">
						<h3 class="box-title">ADD NEW REPLY</h3>
					</div>
					<c:if test="${not empty login }">
					<div class="box-body">
						<label for="exampleInputEmail1">Writer</label> <input
							class="form-control" type="text" placeholder="USER ID" value="${login.uId}" readonly="readonly"
							id="newReplyWriter"> <label for="exampleInputEmail1">Reply
							Text</label> <input class="form-control" type="text"
							placeholder="REPLY TEXT" id="newReplyText">

					</div>
					<!-- /.box-body -->

					<div class="box-footer">
						<button type="button" class="btn btn-primary" id="replyAddBtn">ADD
							REPLY</button>
					</div>
					</c:if>
					<c:if test="${empty login }">
						<div class="box-body">
						    <div><a href="/user/login" >Login Please</a></div>
						</div>
					
					</c:if>
				</div>


				<!-- The time line -->
				<ul class="timeline">
					<!-- timeline time label -->
					<li class="time-label" id="repliesDiv">
						<span class="bg-green">	Replies List
							<small id="replyCntSmall">[${boardVO.replyCnt}]</small> 
						</span>
					</li>
				</ul>

				<div class='text-center'>
					<ul id="pagination" class="pagination pagination-sm no-margin ">

					</ul>
				</div>

			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->

		<!-- Modal -->
		<div id="modifyModal" class="modal modal-primary fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body" data-rno>
						<p>
							<input type="text" id="replyText" class="form-control">
						</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
						<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

	</section>
	<!-- /.content -->

<script id="templateAttach" type="text/x-handlebars-template">
<li data-src='{{fullName}}'>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</span>
  </div>
</li>                
</script>

<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rNo}}>
<i class="fa fa-comments bg-blue"></i>
 <div class="timeline-item" >
  <span class="time">
    <i class="fa fa-clock-o"></i>{{prettifyDate regDate}}
  </span>
  <h3 class="timeline-header"><strong>{{rNo}}</strong> -{{replyer}}</h3>
  <div class="timeline-body">{{replyText}} </div>
   	<div class="timeline-footer">
								{{#eqReplyer replyer }}
                  <a class="btn btn-primary btn-xs" 
									data-toggle="modal" data-target="#modifyModal">Modify</a>
								{{/eqReplyer}}
							  </div>
	            </div>			
           </li>
{{/each}}
</script>


</div>
<%@include file="../include/footer.jsp"%>
<!-- /.content-wrapper -->

<script>
Handlebars.registerHelper("eqReplyer", function(replyer, block) {
	var accum = '';
	if (replyer == '${login.uId}') {
		accum += block.fn();
	}
	return accum;
});

Handlebars.registerHelper("prettifyDate", function(timeValue) {
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth() + 1;
	var date = dateObj.getDate();
	return year + "/" + month + "/" + date;
});

function printData(replyArr, target, templateObject) {

	var template = Handlebars.compile(templateObject.html());
	var html = template(replyArr);

	$(".replyLi").remove();
	target.after(html);
}

var bNo = ${boardVO.bNo};

var replyPage = 1;

function getPage(pageInfo) {

	$.getJSON(pageInfo, function(data) {

		printData(data.list, $("#repliesDiv"), $('#template'));
		printPaging(data.pageMaker, $(".pagination"));

		$("#modifyModal").modal('hide');
		$("#replyCntSmall").html("[ " + data.pageMaker.totalCount +" ]");

	});
}

function printPaging(pageMaker, target) {

	var str = "";

	if (pageMaker.prev) {
		str += "<li><a href='" + (pageMaker.startPage - 1)
				+ "'> << </a></li>";
	}

	for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
		var strClass = pageMaker.cri.page == i ? 'class=active' : '';
		str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
	}

	if (pageMaker.next) {
		str += "<li><a href='" + (pageMaker.endPage + 1)
				+ "'> >> </a></li>";
	}

	target.html(str);
};

$("#repliesDiv").on("click", function() {

	if ($(".timeline li").length > 1) {
		return;
	}

	getPage("/replies/" + bNo + "/1");

});


$(".pagination").on("click", "li a", function(event){
	
	event.preventDefault();
	
	replyPage = $(this).attr("href");
	
	getPage("/replies/"+bNo+"/"+replyPage);
	
});


$("#replyAddBtn").on("click",function(){
	 
	 var replyerObj = $("#newReplyWriter");
	 var replytextObj = $("#newReplyText");
	 var replyer = replyerObj.val();
	 var replyText = replytextObj.val();
	
	  
	  $.ajax({
			type:'post',
			url:'/replies/',
			headers: { 
			      "Content-Type": "application/json",
			      "X-HTTP-Method-Override": "POST" },
			dataType:'text',
			data: JSON.stringify({bNo:bNo, replyer:replyer, replyText:replyText}),
			success:function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("등록 되었습니다.");
					replyPage = 1;
					getPage("/replies/"+bNo+"/"+replyPage );
					replyerObj.val("");
					replytextObj.val("");
				}
		}});
});


$(".timeline").on("click", ".replyLi", function(event){
	
	var reply = $(this);
	
	$("#replyText").val(reply.find('.timeline-body').text());
	$(".modal-title").html(reply.attr("data-rno"));
	
});


$("#replyModBtn").on("click",function(){
	  
	  var rNo = $(".modal-title").html();
	  var replyText = $("#replyText").val();
	  
	  $.ajax({
			type:'put',
			url:'/replies/'+rNo,
			headers: { 
			      "Content-Type": "application/json",
			      "X-HTTP-Method-Override": "PUT" },
			data:JSON.stringify({replyText:replyText}), 
			dataType:'text', 
			success:function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("수정 되었습니다.");
					getPage("/replies/"+bNo+"/"+replyPage );
				}
		}});
});

$("#replyDelBtn").on("click",function(){
	  
	  var rNo = $(".modal-title").html();
	  var replyText = $("#replyText").val();
	  
	  $.ajax({
			type:'delete',
			url:'/replies/'+rNo,
			headers: { 
			      "Content-Type": "application/json",
			      "X-HTTP-Method-Override": "DELETE" },
			dataType:'text', 
			success:function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("삭제 되었습니다.");
					getPage("/replies/"+bNo+"/"+replyPage );
				}
		}});
});
</script>

<script>
	$(document).ready(
			function() {

				var formObj = $("form[role='form']");

				console.log(formObj);

				$("#modifyBtn").on("click", function() {
					formObj.attr("action", "/sboard/modifyPage");
					formObj.attr("method", "get");
					formObj.submit();
				});

				$("#removeBtn").on("click", function() {

					var replyCnt = $("#replycntSmall").html();

					if (replyCnt > 0) {
						alert("댓글이 달린 게시물을 삭제할 수 없습니다.");
						return;
					}

					var arr = [];
					$(".uploadedList li").each(function(index) {
						arr.push($(this).attr("data-src"));
					});

					if (arr.length > 0) {
						$.post("/deleteAllFiles", {
							files : arr
						}, function() {

						});
					}

					formObj.attr("action", "/sboard/removePage");
					formObj.submit();
				});

				$("#goListBtn ").on("click", function() {
					formObj.attr("method", "get");
					formObj.attr("action", "/sboard/list");
					formObj.submit();
				});

				var bNo = ${boardVO.bNo};
				var template = Handlebars.compile($("#templateAttach").html());

				$.getJSON("/sboard/getAttach/" + bNo, function(list) {
					$(list).each(function() {

						var fileInfo = getFileInfo(this);

						var html = template(fileInfo);

						$(".uploadedList").append(html);

					});
				});

				$(".uploadedList").on("click", ".mailbox-attachment-info a",
						function(event) {

							var fileLink = $(this).attr("href");

							if (checkImageType(fileLink)) {

								event.preventDefault();

								var imgTag = $("#popup_img");
								imgTag.attr("src", fileLink);

								console.log(imgTag.attr("src"));

								$(".popup").show('slow');
								imgTag.addClass("show");
							}
						});

				$("#popup_img").on("click", function() {
					$(".popup").hide('slow');

				});

			});
</script>