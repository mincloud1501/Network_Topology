<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!-- iCheck -->
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8" />

<link rel="apple-touch-icon" sizes="76x76" href="/resources/dist/img/skb.ico">
<link rel="icon" type="image/png" href="/resources/dist/img/skb.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Login Page - by minCloud</title>

<meta name='viewport' content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no">

<!--     Fonts and icons     
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />-->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- CSS Files -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.login.css"/>
<link rel="stylesheet" href="/resources/bootstrap/css/now-ui-kit.css"/>

<!-- Sweet Alert -->
<link rel="stylesheet" href="/resources/dist/css/sweetalert.css"/>
    
</head>

<script>
	var result = '${result}';
	if (result == "false") {
		window.onload=function() {
			onClickAutoCloseAlert();
		}
	}
		
</script>


<body class="login-page sidebar-collapse" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-primary fixed-top navbar-transparent " color-on-scroll="400">
        <div class="container">
            <div class="dropdown button-dropdown">
                <a href="#pablo" class="dropdown-toggle" id="navbarDropdown" data-toggle="dropdown">
                    <span class="button-bar"></span>
                    <span class="button-bar"></span>
                    <span class="button-bar"></span>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-header">Dropdown header</a>
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <a class="dropdown-item" href="#">Something else here</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Separated link</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">One more separated link</a>
                </div>
            </div>
            <div class="navbar-translate">
                <a class="navbar-brand" href="#" data-toggle="tooltip" title="Designed by minCloud Coded by minCloud" data-placement="bottom">
                	<span class="badge badge-success" data-toggle="modal" data-target="#myModal">공지사항</span>
                </a>
                                                
                <button class="navbar-toggler navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-bar bar1"></span>
                    <span class="navbar-toggler-bar bar2"></span>
                    <span class="navbar-toggler-bar bar3"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse justify-content-end" data-nav-image="/resources/dist/img/blurred-image-1.jpg">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" rel="tooltip" title="Home" data-placement="bottom" href="#">
                        	<span class="badge badge-success">Home</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" rel="tooltip" title="FAQ Board" data-placement="bottom">
                        	<span class="badge badge-success" data-toggle="modal" data-target="#myModal1">FAQ</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" rel="tooltip" title="Follow us on Twitter" data-placement="bottom" href="https://twitter.com/" target="_blank">
                            <i class="fa fa-twitter-square"></i>
                            <p class="d-lg-none d-xl-none">Twitter</p>
                         </a>
                        
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" rel="tooltip" title="Like us on Facebook" data-placement="bottom" href="https://www.facebook.com/" target="_blank">
                            <i class="fa fa-facebook-square"></i>
                            <p class="d-lg-none d-xl-none">Facebook</p>
                        </a>
                        
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" rel="tooltip" title="Follow us on Instagram" data-placement="bottom" href="https://www.instagram.com/" target="_blank">
                            <i class="fa fa-instagram"></i>
                            <p class="d-lg-none d-xl-none">Instagram</p>
                        </a>                        
                    </li>
                </div>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->

    <div class="page-header" filter-color="gray">
        <div class="page-header-image" style="background-image:url('/resources/dist/img/1.jpg')"></div>
        <div class="container">
            <div class="col-md-4 content-center">
                <div class="card card-login card-plain">
                    
                    <form action="<c:url value='/user/loginPost'/>" method="post">
                        <div class="header header-primary text-center">
                            <div class="logo-container">
                                <img src="/resources/dist/img/skb_logo.png" alt="">
                            </div>
                        </div>
                        <div class="content">
                            <div class="input-group form-group-no-border input-lg">
                                <span class="input-group-addon">
                                	<i class="fa fa-user"></i>
                                </span>
                                <input type="text" class="form-control" id="uId" name="uId" placeholder="USER ID" maxlength="16" required>
                            </div>
                            <div class="input-group form-group-no-border input-lg">
                                <span class="input-group-addon">
                                    <i class="fa fa-expeditedssl"></i>
                                </span>
                                <input type="password" class="form-control" name="uPw" placeholder="Password" maxlength="16" required>
                            </div>
                        </div>
                        <div class="footer text-center">
                        	<button type="submit" class="btn btn-primary btn-round btn-lg btn-block" onclick="document.getElementById('id01').style.display='block'">
                        	Log In </button>
                        </div>
                        <div class="pull-left">
                            <h6>
							<label> <input type="checkbox" name="useCookie"> 아이디 저장
							</label>
                            </h6>
                        </div>
                        <div class="pull-right">
                            <h6>
                            <a href="#">비밀번호 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                            <a href="#"	class="text-center">계정신청</a>
                            </h6>
                        </div>
                    </form>
                </div>
            </div>
        </div>

         <footer class="footer">
            <div class="container">
                <nav>
                    <ul>
                        <li>
                            <a href="#">
                                Infra솔루션팀
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                About Us
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                Blog
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                Get License
                            </a>
                        </li>
                    </ul>
                </nav>
                <div class="copyright">
                    &copy;
                    <script>
                        document.write(new Date().getFullYear())
                    </script>, Designed by
                    <a href="mailto:mincloud@sk.com" target="_blank">minCloud</a>. Coded by
                    <a href="mailto:mincloud@sk.com" target="_blank">minCloud</a>.&nbsp;|&nbsp;
                    <a href="http://www.skbroadband.com/footer/Page.do?retUrl=/footer/PrivacyStatement" target="_blank">
                    	개인정보처리방침
                    </a>
                </div>
            </div>
        </footer>
    </div>
</body>

<!-- Sart Modal -->
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">공지사항</h4>
      </div>
      <div class="modal-body">
        <p>공지드립니다.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal modal-success fade" id="myModal1" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        &times;</button>
        <h4 class="modal-title">FAQ</h4>
      </div>
      <div class="modal-body">
        <p>로그인 후 사용하세요</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!--  End Modal -->

<!--   Core JS Files   -->
<script src="/resources/plugins/jquery/jquery.login.js"></script>
<script src="/resources/bootstrap/js/popper.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.login.js"></script>

<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="/resources/plugins/bootstrap-switch/bootstrap-switch.js"></script>

<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
<script src="/resources/bootstrap/js/nouislider.min.js"></script>


<!--  Plugin for the DatePicker, full documentation here: https://github.com/uxsolutions/bootstrap-datepicker -->
<script src="/resources/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>

<!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
<script src="/resources/bootstrap/js/now-ui-kit.js"></script>
<script src="/resources/bootstrap/js/jquery-backstretch.login.js"></script>

<!-- Share Library etc -->
<script src="/resources/plugins/jquery/jquery.sharrre.js"></script>

<!-- Sweet Alert -->
<script src="/resources/dist/js/sweetalert.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        // the body of this function is in assets/js/now-ui-kit.js
        nowuiKit.initSliders();
    });

    function scrollToDownload() {

        if ($('.section-download').length != 0) {
            $("html, body").animate({
                scrollTop: $('.section-download').offset().top
            }, 1000);
        }
    }

    function onClickWarnAlert() {
    	swal({ 
    		title: "Warnning!", text: "Login Failure!\n ID 또는 Password를 확인하세요", type: "warning", confirmButtonText: "확인"
    	});
    }

    function onClickAutoCloseAlert() {
    	swal({
    		title: "Login Failure!",
    		text: "ID 또는 Password를 확인하세요",
    		timer: 1500,
    		showConfirmButton: false
    	});
    }
</script>

</html>