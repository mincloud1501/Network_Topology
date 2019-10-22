<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<title>HTML5 Test Page</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <!--  <link rel="stylesheet" href="./css/loginStyle.css"> -->
  <link rel="stylesheet" href="./css/myStyle1.css"> 
  <link rel="stylesheet" href="./css/bootstrap-select.min.css">
  
  <script src="./js/myjs1.js"></script>
  <script src="./js/bootstrap-select.min.js"></script>
  <script src="./js/angular.min.js"></script>
  <script src="https://www.w3schools.com/appml/2.0.3/appml.js"></script>
 
</head>


<body>

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="#">About</a>
  <a href="#">Services</a>
  <a href="#">Clients</a>
  <a href="#">Contact</a>
</div>

<header>
	<h3>Welcome to HTML5 Test World!</h3>
</header>

<div class="container">

  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-success btn-lg" id="myBtn">Login</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> Login</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form">
            <div class="form-group">
              <label for="usrname"><span class="glyphicon glyphicon-user"></span> Username</label>
              <input type="text" class="form-control" id="usrname" placeholder="Enter email">
            </div>
            <div class="form-group">
              <label for="psw"><span class="glyphicon glyphicon-eye-open"></span> Password</label>
              <input type="text" class="form-control" id="psw" placeholder="Enter password">
            </div>
            <div class="checkbox">
              <label><input type="checkbox" value="" checked>Remember me</label>
            </div>
              <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> Login</button>
          </form>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
          <p>Not a member? <a href="#">Sign Up</a></p>
          <p>Forgot <a href="#">Password?</a></p>
        </div>
      </div>
      
    </div>
  </div> 
</div>
	
<nav>

<div class="topnav" id="myTopnav">	    
  <a style="font-size:20px;cursor:pointer"onclick="openNav()">&#9776;</a>
  <a href="#home">Java</a>
  <a href="#news">C Language</a>
  <a href="#contact">Javascript</a>
  <a href="http://mrdoob.com/projects/chromeexperiments/ball-pool" target=_blank>Canvas Examples</a>
  <a href="http://www.soen.kr/html5/canvas/space.html" target=_blank>Game</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>

</nav>
	
<section>
<h2>Section 영역</h2>

<article>
<h3>Table 영역 (jQuery + JSON)</h3>

<input id="myInput" type="text" placeholder="Search..">
<br><br>

<table appml-data="./json/customers.json">

	<tr>
  		<th>Customer</th>
  		<th>City</th>
  		<th>Country</th>
	</tr>

	<tbody id="myTable">
		<tr appml-repeat="records">
  			<td>{{CustomerName}}</td>
  			<td>{{City}}</td>
  			<td>{{Country}}</td>
		</tr>
	</tbody>
</table>

</article>

<article>
<h3 id="select-boxes-with-optgroups">Select 영역 (bootstrap)</h3>
<br>

<div id="optgroup"></div>

<div class="bs-docs-example">
  <div class="form-group">
    <select class="selectpicker" multiple data-actions-box="true" data-live-search="true">
      <option data-subtext="French's">Mustard</option>
      <option data-subtext="Heinz">Ketchup</option>
      <option data-subtext="Sweet">Relish</option>
      <option data-subtext="Miracle Whip">Mayonnaise</option>
      <option data-divider="true"></option>
      <option data-subtext="Honey">Barbecue Sauce</option>
      <option data-subtext="Ranch">Salad Dressing</option>
      <option data-subtext="Sweet & Spicy">Tabasco</option>
      <option data-subtext="Chunky">Salsa</option>
    </select>
  </div> 
</div>

</article>

<article>
<h3>AngularJS 영역</h3>
<br>
<form ng-app="" name="myForm">
    Email:
    <input type="email" name="myAddress" ng-model="text">
    <span ng-show="myForm.myAddress.$error.email">Not a valid e-mail address</span>
</form>

<br>
</article>

<article>
<h3>AJAX 영역 (with XML)</h3>

<div class="container">
<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal1">Get XML</button>

<!-- Modal -->
<div id="myModal1" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">AJAX Test</h4>
      </div>
      
      <div class="modal-body">
      	<button type="button" onclick="loadDoc()" id="getXML">Get my CD collection</button>
        <table id="demo"></table>
     
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  	</div>
	</div>
</div>

<br>

</article>

<article>
<h3>Canvas 영역</h3>

<table>
  <tr>
    <td><canvas id="canvas" width="150" height="150"></canvas></td>
    <td>Change the <code>miterLimit</code> by entering a new value below and clicking the redraw button.<br><br>
      <form onsubmit="return draw();">
        <label>Miter limit</label>
        <input type="text" size="3" id="miterLimit"/>
        <input type="submit" value="Redraw"/>
      </form>
    </td>
  </tr>
</table>

</article>

</section>

<!-- The Tour Section 
  <div class="w3-white" id="tour">
    <div class="w3-container w3-content w3-padding-14" style="max-width:800px">
        <p class="w3-opacity w3-center">
      <a href="#" title="설명" data-toggle="popover" data-trigger="hover" data-content="Image 영역">
      <i>Select Images!</i>
      </a>
            
      </p>
            
      <br>

      <div class="w3-row-padding w3-padding-5" style="margin:0 -16px">
        <div class="w3-third w3-margin-bottom">
          <img src="./images/2.jpg" class="img-rounded" alt="New York" style="width:100%" class="w3-hover-opacity">
        </div>
        <div class="w3-third w3-margin-bottom">
          <img src="./images/3.jpg" class="img-circle" alt="Paris" style="width:100%" class="w3-hover-opacity">
        </div>
        <div class="w3-third w3-margin-bottom">
          <img src="./images/4.jpg" class="img-thumbnail" alt="San Francisco" style="width:100%" class="w3-hover-opacity">
        </div>
    </div>
  </div>
 </div>
-->

<!-- Footer -->
<footer class="w3-container w3-padding-64 w3-center w3-opacity w3-light-grey w3-xlarge">
  <i class="fa fa-facebook-official w3-hover-opacity"></i>
  <i class="fa fa-instagram w3-hover-opacity"></i>
  <i class="fa fa-snapchat w3-hover-opacity"></i>
  <i class="fa fa-pinterest-p w3-hover-opacity"></i>
  <i class="fa fa-twitter w3-hover-opacity"></i>
  <i class="fa fa-linkedin w3-hover-opacity"></i>
  <p class="w3-medium">Copyright &copy; <a href="https://www.naver.com" target="_blank">mincloud@sk.com</a></p>
</footer>

</body>
</html>