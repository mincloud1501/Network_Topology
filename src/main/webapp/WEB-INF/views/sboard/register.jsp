<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<style>
.fileDrop {
	width: 100%;
	height: 200px;
	border: 1px dotted blue;
}

small {
	margin-left: 3px;
	font-weight: bold;
	color: gray;
}
</style>

<%@include file="../include/header.jsp"%>
<%@include file="../include/side.jsp"%>

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
			<div class="col-md-12">
				<!-- Horizontal Form -->
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Register Board</h3>
					</div>
					<!-- /.box-header -->
					<!-- form start -->
				<form id='registerForm' role="form" method="post">
						<div class="box-body">
							<div class="form-group">
								<label for="inputTitle" class="col-sm-2 control-label">Title</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="title"
										placeholder="Enter Title">
								</div>
							</div>
							<div class="form-group">
								<label for="inputContent" class="col-sm-2 control-label">Content</label>
								<div class="col-sm-10">
									<textarea class="form-control" rows="3" name="content"
										placeholder="Enter Content ..."></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="inputWriter" class="col-sm-2 control-label">Writer</label>
								<div class="col-sm-10">
								<!--************************************************************************************************-->
									<input type="text" class="form-control" name="writer" value="${login.uId }" readonly="readonly">
								<!--************************************************************************************************-->
								</div>
							</div>
							<div class="form-group">
								<label for="inputFile" class="col-sm-2 control-label">File DROP Here</label>
								<div class="col-sm-10">
									<div class='fileDrop'>
										<div class='uploadedList'></div>
									</div>									
								</div>
							</div>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
							<div>
								<hr>
							</div>
							
							<ul class="mailbox-attachments clearfix uploadedList"></ul>
							
							<button type="submit" class="btn btn-default">Cancel</button>
							<button type="submit" class="btn btn-info pull-right">Submit</button>

							<!-- /.box-footer -->
						</div>
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
 
<script id="template" type="text/x-handlebars-template">
<li>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" 
     class="btn btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</span>
  </div>
</li>                
</script>    


<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="http://www.fsfoo.com/js/vendor/handlebars-1.0.rc.2.js"></script>
<script type="text/javascript" src="/resources/js/upload.js"></script>

<script>

var template = Handlebars.compile($("#template").html());

$(".fileDrop").on("dragenter dragover", function(event){
	event.preventDefault();
});


$(".fileDrop").on("drop", function(event){
	
	event.preventDefault();

	var files = event.originalEvent.dataTransfer.files;
	var file = files[0];

	//console.log(file);
	
	var formData = new FormData();
	formData.append("file", file);	

	$.ajax({
		  url: '/uploadAjax',
		  data: formData,
		  dataType:'text',
		  processData: false,
		  contentType: false,
		  type: 'POST',
		  
		  success: function(data){

			var fileInfo = getFileInfo(data);
			var html = template(fileInfo);
			  
			$(".uploadedList").append(html);
		  }
		});	
});

$(".uploadedList").on("click", "small", function(event){

     var that = $(this);
   
     $.ajax({
       url:"deleteFile", 
       type:"post",
       data: {fileName:$(this).attr("data-src")},
       dataType:"text",
       success:function(result){
	       if(result == 'deleted') {
    	       that.parent("div").remove();
	       }
	   }
     });
});

$("#registerForm").submit(function(event){
	event.preventDefault();
	
	var that = $(this);
	var str ="";
	
	$(".uploadedList .delbtn").each(function(index){
		 str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href") +"'> ";
	});
	
	that.append(str);

	that.get(0).submit();
});

</script>