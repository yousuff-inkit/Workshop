<%@ taglib prefix="s" uri="/struts-tags"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<link href='http://fonts.googleapis.com/css?family=Mr+Dafoe' rel='stylesheet' type='text/css'> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> --%>
<%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script> --%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.min.css">
<style type="text/css">
	html,body{
			background-color: #f9f9fa;
			width: 100%;
			height: 100%;
		}
		:root{
			--primary:#3742fa;
		}
		*{
		    margin: 0;
		    padding: 0;
		}
		html {
		    font-family: sans-serif;
		    line-height: 1.15;
		    -webkit-text-size-adjust: 100%;
		    -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
		}
		body {
		    margin: 0;
		    font-family: "Poppins";
		    font-size: 1.3rem;
		    font-weight: 400;
		    line-height: 1.5;
		    color: #212529;
		    text-align: left;
		    background-color: #F7F7F7;
		    width:100%;
		    overflow:auto;
			height:100%;
			background-color: #f9f9fa;
		}
		.sidebar{
			position:absolute;
			z-index:999999;
			width:100px;
			min-height:100%;
			background-color:#fff;
		}
		.welcome-admin-wrapper{
			width:100%;
			/* border:1px solid #000;  */
			position:relative;
			background-color:#fff;
			margin-top:15px;
			padding-top:1px;
			padding-left:8px;
			padding-bottom:4px;
			box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
	  		transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	  		overflow:inherit !important;
			
		}
		.welcome-admin-wrapper .close-controls{
			position:absolute;
			top:20%;
			right:8px;
			float:right;
			text-align:right;
			z-index:99999;
		}
		.card-wrapper{
			width: 100%;
			background-color: #fff;
			box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
	  		transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	  		padding: 20px;
	  		max-width: 200px;
	  		position: relative;
	  		float: left;display: inline-block;
	  		margin: 10px;
		}
		.card-wrapper .card-wrapper-icon{
			position:absolute;
			top:20%;
			right: 10px;
			float:right;
			text-align:right;
			border-radius: 50%;
			
		}
		.card-wrapper .card-wrapper-icon i{
			font-size: 2.2rem;
			border-radius: 50%;
			padding: 12px;
		}
		.bg-gradient1{
			background-image: linear-gradient(45deg, #ff9a9e 0%, #fad0c4 99%, #fad0c4 100%);
			color: #fff;
		}
		.bg-gradient2{
			background-image: linear-gradient(to top, #a18cd1 0%, #fbc2eb 100%);
			color: #fff;
		}
		.bg-gradient3{
			background-image: linear-gradient(to top, #ff0844 0%, #ffb199 100%);
			color: #fff;
		}
		.bg-gradient4{
			background-image: linear-gradient(to top, #fbc2eb 0%, #a6c1ee 100%);
			color: #fff;
		}
		.bg-gradient5{
			background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
			color: #fff;
		}
		.bg-gradient6{
			background-image: linear-gradient(120deg, #d4fc79 0%, #96e6a1 100%);
			color: #fff;
		}
		.bg-gradient7{
			background-image: linear-gradient(to right, #fa709a 0%, #fee140 100%);
			color: #fff;
		}
		.bg-gradient8{
			background-image: linear-gradient(to top, #30cfd0 0%, #330867 100%);
			color: #fff;
		}
		.bg-gradient9{
			background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: #fff;
		}
		.bg-gradient10{
			background-image: linear-gradient(to right, #6a11cb 0%, #2575fc 100%);
			color: #fff;
		}
		.bg-dark {
		    color: #fff;
		    background-color: #212121;
		    box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 12px -5px rgba(33,33,33,.46);
		}
		.bg-success {
		    color: #fff;
	    	background-color: #4caf50;
	    	box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 12px -5px rgba(76,175,80,.46);
		}
		.bg-danger {
		    color: #fff;
		    background-color: #f44336;
		    box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 12px -5px rgba(244,67,54,.46);
		}
		.bg-warning {
		    color: #fff;
		    background-color: #ff9800;
		    box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 12px -5px rgba(255,152,0,.46);
		}
		.bg-primary {
		    color: #fff;
		    background-color: #9c27b0;
		    box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 12px -5px rgba(156,39,176,.46);
		}
		.bg-info {
		    color: #fff;
		    background-color: #00bcd4;
		    box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 12px -5px rgba(0,188,212,.46);
		}
		.card-color{
			display: block;
			width: 25px;
			height: 2px;
		}
		.progress-wrapper{
			box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
	  		transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	  		padding: 10px;
		}
		.progress-item-color{
			width: 12px;
			height: 12px;
			background-color: #fff;
			display: inline-block;
			border-radius: 50%;
			border-color: #3742fa;
			border-width: 3px;
			border-style: solid;
		}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".welcome-admin-wrapper .dropdown-menu li a").click(function(){
      		$(".welcome-admin-wrapper .btn:first-child").text($(this).text());
   		});
	});
	
</script>
</head>
<body>
	<div class="sidebar animated slideOutLeft">
		
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="welcome-admin-wrapper img-rounded animated fadeInDown">
					<div class="close-controls">
						<p style="color:grey;">Logged <%=session.getAttribute("LOGGEDIN").toString().substring(0,19)%></p>
						<div class="dropdown">
							<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Today
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
							    <li><a href="#">Today</a></li>
							    <li><a href="#">This Week</a></li>
							    <li><a href="#">This Month</a></li>
							</ul>
						</div>
					</div>
					<h3><strong>Workshop Dashboard</strong></h3>
					<h5>Welcome Back,<strong> <%=session.getAttribute("USERNAME")%></strong></h5>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="card-wrapper img-rounded">
					<div class="card-wrapper-icon bg-gradient1">
						<i class="fa fa-car"></i>
					</div>
					<span class="card-color bg-dark"></span>
					<p class="card-info-detail"><strong>1,152</strong></p>
					<p class="card-info-name">GIP Entered</p>
				</div>
				<div class="card-wrapper img-rounded">
					<div class="card-wrapper-icon bg-gradient2">
						<i class="fa fa-location-arrow"></i>
					</div>
					<span class="card-color bg-primary"></span>
					<p class="card-info-detail"><strong>1,152</strong></p>
					<p class="card-info-name">Est. Created</p>
				</div>
				<div class="card-wrapper img-rounded">
					<div class="card-wrapper-icon bg-gradient3">
						<i class="fa fa-cogs"></i>
					</div>
					<span class="card-color bg-info"></span>
					<p class="card-info-detail"><strong>1,152</strong></p>
					<p class="card-info-name">Job Card Created</p>
				</div>
				<div class="card-wrapper img-rounded">
					<div class="card-wrapper-icon bg-gradient7">
						<i class="fa fa-usd" aria-hidden="true"></i>
					</div>
					<span class="card-color bg-warning"></span>
					<p class="card-info-detail"><strong>1,152</strong></p>
					<p class="card-info-name">Invoices Raised</p>
				</div>
				<div class="card-wrapper img-rounded">
					<div class="card-wrapper-icon bg-gradient8">
						<i class="fa fa-retweet"></i>
					</div>
					<span class="card-color bg-warning"></span>
					<p class="card-info-detail"><strong>1,152</strong></p>
					<p class="card-info-name">GOP Generated</p>
				</div>
				<div class="card-wrapper img-rounded">
					<div class="card-wrapper-icon  bg-gradient10">
						<i class="fa fa-money"></i>
					</div>
					<span class="card-color bg-success"></span>
					<p class="card-info-detail"><strong>AED 75000</strong></p>
					<p class="card-info-name">Total Invoices</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
				<div class="progress-wrapper img-rounded">
					<div class="progress-header">
						<p><strong>Fleet Status</strong></p>
						<div class="pull-left">
							
						</div>
					</div>
					<div class="progress">
  						<div class="progress-bar progress-bar-success " role="progressbar" style="width:40%">
  						</div>
  						<div class="progress-bar progress-bar-warning" role="progressbar" style="width:10%">
  						</div>
  						<div class="progress-bar progress-bar-danger" role="progressbar" style="width:20%">
  						</div>
					</div>
					<!-- <div class="list-group event-list">
						<a href="#" class="list-group-item"><span class="progress-item-color"></span>Web Programming<span class="badge">11</span></a>
						<a href="#" class="list-group-item"><span class="progress-item-color">17</span>Visual Design<span class="badge">11</span></a>
						<a href="#" class="list-group-item"><span class="progress-item-color">20</span>Agreement Training<span class="badge">11</span></a>
					</div> -->
					<ul class="list-group">
						<li class="list-group-item"><span class="progress-item-color"></span> Ready To Rent <span class="badge">12</span></li>
						<li class="list-group-item"><span class="progress-item-color"></span> Rental Agreement <span class="badge">5</span></li> 
						<li class="list-group-item"><span class="progress-item-color"></span> Lease Agreement <span class="badge">3</span></li> 
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>