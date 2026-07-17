<%@ taglib prefix="s" uri="/struts-tags"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="includesdashboard.jsp"></jsp:include> --%>
<link href='http://fonts.googleapis.com/css?family=Mr+Dafoe' rel='stylesheet' type='text/css'> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../../vendors/bootstrap-tagsinput/js/bootstrap-tagsinput.js"></script>
<%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script> --%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="util.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="main.css">
<link rel="stylesheet" href="../../vendors/bootstrap-tagsinput/css/bootstrap-tagsinput.css">
<link rel="stylesheet" href="../../vendors/daterangepicker/daterangepicker.css">

<!-- <link rel="stylesheet" href="../../css/feather-icon.css"> -->
<style type="text/css">
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	:root {
	    --theme-deafult: #7366ff;
	    --theme-secondary: #f73164;
	    --bs-blue: #0d6efd;
	    --bs-indigo: #6610f2;
	    --bs-purple: #6f42c1;
	    --bs-pink: #d63384;
	    --bs-red: #dc3545;
	    --bs-orange: #fd7e14;
	    --bs-yellow: #ffc107;
	    --bs-green: #198754;
	    --bs-teal: #20c997;
	    --bs-cyan: #0dcaf0;
	    --bs-white: #fff;
	    --bs-gray: #6c757d;
	    --bs-gray-dark: #343a40;
	    --bs-primary: #0d6efd;
	    --bs-secondary: #6c757d;
	    --bs-success: #198754;
	    --bs-info: #0dcaf0;
	    --bs-warning: #ffc107;
	    --bs-danger: #dc3545;
	    --bs-light: #f8f9fa;
	    --bs-dark: #212529;
	    --bs-font-sans-serif: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	    --bs-font-monospace: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
	    --bs-gradient: linear-gradient(180deg, rgba(255,255,255,0.15), rgba(255,255,255,0));
	}
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('fonts/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#F7F7F7;
		font-family: Poppins-Regular, sans-serif;
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
		background-color: #F7F7F7;
	}
	.sidebar{
		position:absolute;
		z-index:999999;
		width:100px;
		min-height:100%;
		background-color:#fff;
	}
	
	.admin-cover .panel-body,.chart-panel .panel-body{
		border:none;
	}
		
	.page-loader{
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		z-index:9999999;
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.9);
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: #5867dd;
    	border-color: #5867dd;
		color:#fff;
		margin:0 auto;
		position:absolute;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
	}
	.btn-chartfleetsales.active{
		background-color:#5867dd;
		border-color:#5867dd;
		color:#fff;
	}
	.knob:focus,.knob{
        border: 0;
        outline:0;
    }
    .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
        border-radius: 8px;
        margin-bottom: 15px;
		background-color:#fff;
    }
    .card-container .card-body{
        width: 100%;
        padding-top: 8px;
        padding-bottom: 8px;
    }
    .card-container .card-body .card-chart-container,.card-icon-container{
        width: 30%;
        text-align: center;
        vertical-align: middle;
    }
    .card-container .card-body .card-detail-container{
        width: 68%;
        vertical-align: middle;
    }
    .card-container .card-body>div{
        display: inline-block;
    }
    .card-container .card-body .card-detail-container>div{
        display: inline-block;
        width:24%;
        text-align:center;
    }
    .card-container .card-body .card-detail-container>div:not(:last-child){
    	border-right: 1px solid #efefef;
    }
        
    .chart-gauge {
        width: 200px;
        margin: 10px auto;
    }

    .chart-color1 {
        fill: #43da14;
    }

    .chart-color2 {
        fill: #e0ff00;
    }

    .chart-color3 {
        fill: #e97209;
    }

    .chart-color4 {
        fill: #ff001a;
    }

    .needle,
    .needle-center {
        fill: #464A4F;
    }
    .custom-badge1.badge{
   		margin-left: 10px;
    	border-radius: 3px;
    	background-color: darkblue;
    }
    table tr.active td{
    	background-color:blue;
    	color:#000;
    }
    .btn-table-dropdown,.btn-table-dropdown:focus,.btn-table-dropdown:active,.btn-table-dropdown:hover{
    	margin: 0;
	    padding: 0;
	    outline: 0;
	    border: 0;
	    background-color: transparent;
	    box-shadow: none;
    }
    .panel-heading .dropdown-menu li a[data-target="#"]{
    	cursor:pointer;
    }
    .panel-loader{
   		position: absolute;
    	width: 100%;
    	height: 100%;
    	z-index: 99;
    	background-color: rgba(0,0,0,0.5);
    	margin: 0;
    	padding: 0;
    	overflow: hidden;
    }
    .panel-loader i{
    	color:#fff;
    }
    .no-padding {
   		padding: 0;
   		margin: 0 !important;
	}
	.p-15{
		padding:15px;
	}
	.card-item{
		background-color: #fff;
	    padding-left: 10px;
	    padding-right: 10px;
	    border-radius: 4px;
	    padding-top: 1px;
	    padding-bottom: 4px;
	    margin-bottom:8px;
	    box-shadow:0 5px 10px rgba(154,160,185,.05), 0 15px 40px rgba(166,173,201,.2);
		background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		box-shadow: 0 2px 4px 0 rgb(62 57 107 / 13%);
		position:relative;
		transition:all 0.3s ease;
		cursor:pointer;
		
	}
	.card-item:hover,.card-item.active{
		transform:scale(1.1);
	}
	.card-item.active{
		border-bottom: 5px solid #08ad13;
	}
	.card-item:hover svg,.card-item.active svg {
		transform:rotate(12deg);
	}
	.card-item h2{
		margin-top: 5px;
    	margin-bottom: 5px;
    	color:#fff;
	}
	.card-item h6{
		color:#fff;
		letter-spacing:0.2px;
		font-weight:200;
	}
	.card-item .progress{
		height: 6px;
    	margin-bottom: 6px;
		background-color:#fff;
	}
	.card-item .progress .progress-bar{
		background-color:var(--theme-secondary);
		opacity:0.7;
	}
	.card-item small{
		color: #f8f9fa;
	}
	.card-item svg.icon-bg{
		position: absolute;right: 2px;width: 64px;height: 64px;opacity: 0.5;
		transition:all 0.3s ease;
		stroke:#fff;
	}
	.card-item:hover svg.icon-bg g{
		
	}
	.panel.custom-panel{
		box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	}
	.panel.custom-panel .panel-heading{
		background-color:#fff;
	}
	.panel.custom-panel .panel-heading p{
		color:#000;
	}
	.filter-dropdown .dropdown-menu li .select2-container{
		width: 100%;
    	padding-left: 5px;
    	padding-right: 5px;
    	padding-bottom: 5px;
	}
	.filter-dropdown .dropdown-menu li input{
		width: 100%;
    	margin-left: 5px;
    	margin-right: 8px;
    	margin-bottom: 5px;
	}
	.filter-dropdown .dropdown-menu li button{
		width: 94%;
    	margin-left: 5px;
    	margin-right: 8px;
    	margin-bottom: 5px;
	}
	.tags-container .badge{
		background-color: #0093E9;
		background-image: linear-gradient(90deg, #0093E9 0%, #80D0C7 100%);
		border-radius:4px;
		margin-right:5px;
	}
	.bootstrap-tagsinput {
  		width: 100%;
	}
</style>
</head>
<body>
	<div class="page-loader hidden">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<!-- <div class="sidebar animated slideOutLeft">
		
	</div> -->
	<div class="container-fluid">
	
		<div class="panel panel-default admin-cover animated fadeInDown m-t-10 m-b-8">
	  		<div class="panel-body">
	  			<p style="margin-bottom:0;display:inline-block;" class="fs-12"><strong>Hi <span style="text-transform:capitalize;">Admin</span></strong>, Your Analytics are all set</p>	
	  			<div class="pull-right" style="display:inline-block;">
					<select name="cmbbranch" id="cmbbranch" class="form-control">
						<option value="">--Select--</option>
					</select>
				</div>
	  		</div>
	  	</div>
	  	<div class="row m-b-8">
	  		<div class="col-xs-12 col-sm-12 col-md-10 col-lg-10">
	  			<div class="tags-container">
	  				<input type="text" class="form-control" style="width:100%;" id="filtertagsinput"/>
	  			</div>
	  		</div>
	  		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
	  			<div class="dropleft filter-dropdown" style="display:inline-block;">
					<button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">Filters
						<i class="fa fa-filter"></i>
					</button>
					<ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
						<li role="presentation">
							<select name="cmbbrand" id="cmbbrand" class="form-control" style="width:100%;">
								<option value="">--Select--</option>
							</select>
						</li>
						<li role="presentation">
							<select name="cmbmodel" id="cmbmodel" class="form-control" style="width:100%;">
								<option value="">--Select--</option>
							</select>
						</li>
						<li role="presentation">
							<input type="text" name="daterangefilter" value="" id="daterangefilter" style="font-size: 12px;padding:7px;width: 180px;" class="form-control"/>
						</li>
			</ul>
		</div>
	  		</div>
	  	</div>
	  		
		
		<div id="floorcard">
		<div class="row">
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapsegip">
					<svg  id="svg1" version="1.1" fill="none" height="24" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="icon-bg">
						<path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
						<g>
						<polyline points="10 17 15 12 10 7"></polyline>
						<line x1="15" x2="3" y1="12" y2="12"></line>
						</g>
					</svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Gate In Pass</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapseest">
					<svg class="icon-bg" id="Layer_1" style="enable-background:new 0 0 30 30;" version="1.1" viewBox="0 0 30 30" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M7,22  V4h18v18c0,2.209-1.791,4-4,4" style="fill:none;stroke:#fff;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;"/><path d="M17,22  L17,22H4l0,0c0,2.209,1.791,4,4,4h13C18.791,26,17,24.209,17,22z" style="fill:none;stroke:#fff;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="15" x2="21" y1="13" y2="13"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="11" x2="13" y1="13" y2="13"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="15" x2="21" y1="17" y2="17"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="11" x2="13" y1="17" y2="17"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="15" x2="21" y1="9" y2="9"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="11" x2="13" y1="9" y2="9"/><path style="fill:none;" d="M17,22L17,22H4l0,0c0,2.209,1.791,4,4,4h13C18.791,26,17,24.209,17,22z"/></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Estimation</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item"  data-parent="#floorcard" data-toggle="collapse" data-target="#collapsejob">
					<svg class="icon-bg" height="8.4666mm" style="shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd" version="1.1" viewBox="0 0 846.66 846.66" width="8.4666mm" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><defs><style type="text/css">
   <![CDATA[
    .fil0 {fill:#fff;fill-rule:nonzero}
   ]]>
  </style></defs><g id="Layer_x0020_1"><path class="fil0" d="M57.69 10.3l586.02 0c11.4,0 20.65,9.24 20.65,20.64l0 86.43 124.61 0c11.4,0 20.64,9.24 20.64,20.64l0 677.71c0,11.4 -9.24,20.64 -20.64,20.64l-586.02 0c-11.4,0 -20.65,-9.24 -20.65,-20.64l0 -86.43 -124.61 0c-11.4,0 -20.64,-9.24 -20.64,-20.64l0 -677.71c0,-11.4 9.24,-20.64 20.64,-20.64zm606.67 148.36l0 549.99c0,11.4 -9.25,20.64 -20.65,20.64l-420.11 0 0 65.78 544.72 0 0 -636.41 -103.96 0zm-375.67 176.69c-5.31,26.52 -45.63,18.46 -40.33,-8.06 5.33,-26.52 20.73,-49.83 42.89,-65.22 -1.02,-1.32 -2,-2.68 -2.93,-4.07 -8.05,-12.01 -12.75,-26.38 -12.75,-41.76 0,-41.49 33.64,-75.13 75.13,-75.13 41.49,0 75.13,33.64 75.13,75.13 0,16.64 -5.53,32.68 -15.68,45.83 22.17,15.38 37.57,38.7 42.89,65.22 5.3,26.52 -35.02,34.58 -40.32,8.06 -4.36,-21.68 -20.08,-39.68 -40.91,-47.03 -6.82,2.03 -13.99,3.06 -21.11,3.06 -7.1,0 -14.29,-1.03 -21.11,-3.06 -20.83,7.35 -36.55,25.34 -40.9,47.03zm62.01 -85.26c18.93,0 33.84,-15.08 33.84,-33.85 0,-18.69 -15.15,-33.84 -33.84,-33.84 -18.69,0 -33.84,15.15 -33.84,33.84 0,18.93 15.09,33.85 33.84,33.85zm-151.48 198.89c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm0 149.5c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm0 -74.75c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm423.84 -472.14l-544.72 0 0 636.41 544.72 0 0 -636.41z"/></g></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Job Card</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapsejcc">
					<svg class="icon-bg" style="enable-background:new 0 0 50 50;" version="1.1" viewBox="0 0 50 50" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><style type="text/css">
	.st0{display:none;}
	.st1{display:inline;}
	.st2{display:inline;fill:none;stroke:#fff;stroke-width:3;stroke-miterlimit:10;}
	.st3{display:inline;fill:none;stroke:#fff;stroke-width:5;stroke-linecap:round;stroke-miterlimit:10;}
	.st4{display:inline;fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st5{fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st6{display:inline;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st7{display:none;fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
</style><g class="st0" ><g class="st1"><g><path d="M19.5,8.2c6.2,0,11.3,5.1,11.3,11.3s-5.1,11.3-11.3,11.3S8.2,25.8,8.2,19.5S13.2,8.2,19.5,8.2 M19.5,5.2     c-7.9,0-14.3,6.4-14.3,14.3s6.4,14.3,14.3,14.3s14.3-6.4,14.3-14.3S27.3,5.2,19.5,5.2L19.5,5.2z"/></g></g><line class="st2" x1="28.8" x2="32.1" y1="28.7" y2="32"/><line class="st3" x1="44.8" x2="33" y1="44.8" y2="33"/></g><g class="st0" ><path class="st4" d="M46.3,13.9H3.7c-0.3,0-0.5-0.2-0.5-0.5V6.6c0-0.6,0.4-1,1-1h41.7c0.6,0,1,0.4,1,1v6.8   C46.8,13.7,46.6,13.9,46.3,13.9z"/><path class="st4" d="M42.5,44.4H7.5c-0.6,0-1-0.4-1-1V13.9h37.1v29.5C43.5,43.9,43.1,44.4,42.5,44.4z"/><path class="st4" d="M32.3,26.5H18.2c-1.6,0-2.9-1.3-2.9-2.9v0c0-1.6,1.3-2.9,2.9-2.9h14.1c1.6,0,2.9,1.3,2.9,2.9v0   C35.2,25.1,33.9,26.5,32.3,26.5z"/></g><g class="st0" ><path class="st4" d="M11.6,41.3h-3c-0.6,0-1-0.4-1-1v-32c0-0.6,0.4-1,1-1h3V41.3z"/><path class="st4" d="M32.2,6.1H12.6c-0.6,0-1,0.4-1,1v35.8c0,0.6,0.4,1,1,1h28.9c0.6,0,1-0.4,1-1V15c0-0.3-0.1-0.6-0.4-0.8   l-9.2-7.8C32.7,6.2,32.4,6.1,32.2,6.1z"/><line class="st4" x1="32.2" x2="32.2" y1="6.1" y2="14.9"/><line class="st4" x1="42.4" x2="32.2" y1="15" y2="15"/><g class="st1"><line class="st5" x1="19" x2="36" y1="20.9" y2="20.9"/><line class="st5" x1="19" x2="33.3" y1="26" y2="26"/><line class="st5" x1="19" x2="36" y1="30.9" y2="30.9"/><line class="st5" x1="19" x2="33.3" y1="35.6" y2="35.6"/></g></g><g class="st0" ><path class="st4" d="M38.5,32.6v10.7c0,0.6-0.4,1-0.9,1H9.3c-0.5,0-0.9-0.4-0.9-1V6.6c0-0.6,0.4-1,0.9-1h28.3c0.5,0,0.9,0.4,0.9,1   v10.5"/><path class="st6" d="M28.5,30V20c0-0.2-0.3-0.4-0.5-0.2l-6.6,5c-0.2,0.1-0.2,0.4,0,0.5l6.6,5C28.3,30.4,28.5,30.2,28.5,30z"/><line class="st4" x1="28.5" x2="45.6" y1="25" y2="25"/></g><g class="st0" ><path class="st4" d="M9.9,16.1h31.3v-4.6c0-0.6-0.4-1-1-1H4.4c-0.6,0-1,0.4-1,1v23.2c0,0.6,0.4,1,1,1h4.6V17.1   C8.9,16.5,9.4,16.1,9.9,16.1z"/><path class="st4" d="M46,42.8H9.9c-0.6,0-1-0.4-1-1V17.1c0-0.6,0.4-1,1-1H46c0.6,0,1,0.4,1,1v24.7C47,42.4,46.6,42.8,46,42.8z"/><path class="st4" d="M46,42.8H9.9c-0.6,0-1-0.4-1-1V17.1c0-0.6,0.4-1,1-1l15.3,14.6c1.5,1.5,4,1.5,5.5,0L46,16.1c0.6,0,1,0.4,1,1   v24.7C47,42.4,46.6,42.8,46,42.8z"/><line class="st4" x1="22.3" x2="8.9" y1="27.9" y2="38.6"/><line class="st4" x1="33.6" x2="47" y1="28.1" y2="38.9"/></g><g class="st0" ><path class="st6" d="M30.8,36.6l5.8,8.1c0.1,0.2,0.5,0.2,0.5-0.1l2.5-7.9c0.1-0.2-0.1-0.4-0.3-0.4L31,36.1   C30.8,36.1,30.7,36.4,30.8,36.6z"/><path class="st6" d="M18.7,12.6l-5.8-8.1c-0.1-0.2-0.5-0.2-0.5,0.1l-2.5,7.9c-0.1,0.2,0.1,0.4,0.3,0.4l8.3,0.2   C18.7,13.1,18.9,12.8,18.7,12.6z"/><path class="st4" d="M39.4,36.5c-3.5,4.3-8.7,7-14.6,7c-10.4,0-18.8-8.4-18.8-18.8c0-1.5,0.2-2.9,0.5-4.3"/><path class="st4" d="M10.1,12.6c3.5-4.3,8.7-7,14.6-7c10.4,0,18.8,8.4,18.8,18.8c0,1.5-0.2,2.9-0.5,4.3"/></g><path class="st7" d="M25.1,5.3c-11.5,0-20.9,8.1-20.9,18.2c0,5.8,3.1,11,8,14.3L7.5,45  c-0.2,0.2,0.1,0.5,0.3,0.4c4.7-0.6,8.9-2,12.5-4.3c1.5,0.3,3.1,0.5,4.8,0.5c11.5,0,20.9-8.1,20.9-18.2S36.7,5.3,25.1,5.3z" /><g id="SLA"><path class="st5" d="M43.4,44.4H6.6c-0.6,0-1-0.4-1-1V6.6c0-0.6,0.4-1,1-1h36.8c0.6,0,1,0.4,1,1v36.8   C44.4,43.9,43.9,44.4,43.4,44.4z"/><g><g><line class="st5" x1="11.9" x2="24.4" y1="36.2" y2="36.2"/><line class="st7" x1="30.7" x2="33.2" y1="34.8" y2="37.5"/><line class="st7" x1="38.1" x2="33.2" y1="32.5" y2="37.5"/></g><g><line class="st5" x1="11.9" x2="24.4" y1="26.2" y2="26.2"/><line class="st5" x1="30.7" x2="33.2" y1="24.8" y2="27.5"/><line class="st5" x1="38.1" x2="33.2" y1="22.5" y2="27.5"/></g><g><line class="st5" x1="11.9" x2="24.4" y1="16.2" y2="16.2"/><line class="st5" x1="30.7" x2="33.2" y1="14.8" y2="17.5"/><line class="st5" x1="38.1" x2="33.2" y1="12.5" y2="17.5"/></g></g></g><g class="st0" ><path class="st4" d="M44.2,9.3H5.7c-0.6,0-1-0.4-1-1V4.9c0-0.6,0.4-1,1-1h38.5c0.6,0,1,0.4,1,1v3.4C45.2,8.9,44.7,9.3,44.2,9.3z"/><path class="st4" d="M42.2,38.4H7.7c-0.6,0-1-0.4-1-1V9.3h36.5v28.1C43.2,38,42.7,38.4,42.2,38.4z"/><line class="st4" x1="25" x2="25" y1="42.8" y2="38.4"/><circle class="st4" cx="25" cy="45.6" r="2.2"/><g class="st1"><line class="st5" x1="28" x2="38.7" y1="18.8" y2="18.8"/><line class="st5" x1="28" x2="38.7" y1="23.9" y2="23.9"/><line class="st5" x1="28" x2="38.7" y1="29" y2="29"/><path class="st5" d="M17.8,23.4l-0.6-5.2c0-0.2-0.1-0.3-0.3-0.3c-3.5,0.2-6.2,3.5-5.4,7.1c0.5,2.2,2.3,4,4.5,4.5    c3.7,0.8,6.9-1.9,7.1-5.3c0-0.2-0.1-0.3-0.3-0.3L17.8,23.4z"/></g></g></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Job Card Completed</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapseinv">
					<svg class="icon-bg" style="fill: #fff;stroke: none;" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"><defs><style>.cls-1{fill:none;}</style></defs><title/><g data-name="Layer 2" id="Layer_2"><path d="M26,26H6a3,3,0,0,1-3-3V9A3,3,0,0,1,6,6H26a3,3,0,0,1,3,3V23A3,3,0,0,1,26,26ZM6,8A1,1,0,0,0,5,9V23a1,1,0,0,0,1,1H26a1,1,0,0,0,1-1V9a1,1,0,0,0-1-1Z"/><path d="M14,22H8a1,1,0,0,1,0-2h6a1,1,0,0,1,0,2Z"/><path d="M28,13H4a1,1,0,0,1,0-2H28a1,1,0,0,1,0,2Z"/></g><g id="frame"><rect class="cls-1" height="32" width="32"/></g></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Invoiced</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapserls">
					<svg class="icon-bg" fill="none" height="24" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Released</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="row container-fluid">
				<div class="collapse table-responsive" id="collapsegip">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Date</th>
										<th>Client</th>
										<th>Vehicle Details</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="collapse table-responsive" id="collapseest">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Date</th>
										<th>Client</th>
										<th>Vehicle Details</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="collapse table-responsive" id="collapsejob">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Date</th>
										<th>Client</th>
										<th>Vehicle Details</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="collapse table-responsive" id="collapsejcc">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Date</th>
										<th>Client</th>
										<th>Vehicle Details</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="collapse table-responsive" id="collapseinv">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Date</th>
										<th>Client</th>
										<th>Vehicle Details</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="collapse table-responsive" id="collapserls">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Date</th>
										<th>Client</th>
										<th>Vehicle Details</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
				<div class="panel panel-default apex-chart-panel custom-panel">
					<div class="panel-heading clearfix">
						<p class="panel-title fs-14"><strong style="display:inline-block;">Analytics</strong></p>
					</div>
					<div class="panel-body">
						<div class="current-sale-container">
							<div id="chart-gipgop"></div>
                        </div>
					</div>
					<div class="panel-footer">
							<ul class="list-inline" style="display: flex;justify-content: center;">
							    <li><span></span>Gate In Pass</li>
    							<li><span></span>Estimation</li>
    							<li><span></span>Job Card</li>
    							<li><span></span>Invoiced</li>
    							<li><span></span>Released</li>
  							</ul>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
				<div class="panel panel-default custom-panel" >
					<div class="panel-heading">
						<p class="panel-title fs-14"><strong>Gate In Pass Analysis</strong></p>
					</div>
					<div class="panel-body">
						<div class="radial-chart-container">
							<div id="radialbarchart"></div>
						</div>	
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-8 col-lg-8">
				<div class="panel panel-default custom-panel">
					<div class="panel-heading">
						<p class="panel-title"><strong>Amount Transactions</strong></p>
					</div>
					<div class="panel-body">
						<div class="amount-stacked-container">
							<div id="amountstackedchart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
				<div class="panel panel-default custom-panel vehicle-list">
					<div class="panel-heading">
						<p class="panel-title"><strong>Vehicle List</strong></p>
					</div>
					<div class="panel-body">
						<div class="height-wrapper" style="max-height:350px;overflow-y:auto;">
							<ul class="list-group">
								
							</ul>
						</div>
						
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-8 col-lg-8">
				<div class="panel panel-default custom-panel">
					<div class="panel-heading">
						<p class="panel-title"><strong>New Customers</strong></p>
					</div>
					<div class="panel-body">
						<div class="customers-chart-container">
							<div id="customerschart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
				<div class="panel panel-default custom-panel">
					<div class="panel-heading">
						<p class="panel-title"><strong>Maintenance Analytics</strong></p>
					</div>
					<div class="panel-body">
						<div class="maintenance-chart-container">
							<div id="maintenancechart"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<div class="panel panel-default custom-panel">
					<div class="panel-heading">
						<p class="panel-title"><strong>Technician Productivity</strong></p>
					</div>
					<div class="panel-body table-responsive">
						<table class="table" id="tbltechnician">
							<thead>
								<tr>
									<th>Sr.No</th>
									<th>Technician</th>
									<th>Hours</th>
									<th align="right" class="text-right">Estimate Total</th>
									<th align="right" class="text-right">Customer Total</th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%-- <script src="../../js/chartutils.js"></script> --%>
	<%-- <script src="../../js/dashboard/jquery.knob.min.js"></script> --%>
	<script src="apexcharts-bundle/dist/apexcharts.min.js"></script>
	
	<script type="text/javascript" src="../../vendors/daterangepicker/moment.min.js"></script>
    <script type="text/javascript" src="../../vendors/daterangepicker/daterangepicker.js"></script>
	<script type="text/javascript">
		window.chartColors=["#cee5f2","#accbe1","#7c98b3","#637081","#536b78","#4b3b47","#f9a620","#ffd449","#548c2f","#104911","#9a2144","#065143","#c1292e","#f1d302","#161925"];
    	window.colorScheme1=["#f72585","#b5179e","#7209b7","#3a0ca3","#4361ee","#4cc9f0"];
    	var gipgopchart,gipgopchartoptions,radialchartoptions,amountstackedoptions,customerschartoptions,maintenancechartoptions;
    	function getChartColors(colorlength){
    		var colorArray=new Array();
    		var colorindex=0;
    		while(colorindex<12){
    			colorArray.push(window.chartColors[colorindex]);
    			colorindex++;
    		}
    		return colorArray;
    	}
    	$(document).ready(function(){
    		$('#daterangefilter').daterangepicker({
                showCalendars:true,
                
                startDate: moment().subtract(1,'years'),
    			endDate: moment(),
                locale: {
            		format: 'DD/MM/YYYY'
        		}
        	},function(start, end, label) {
    			//console.log("A new date selection was made: " + start.format('DD-MM-YYYY') + ' to ' + end.format('DD-MM-YYYY'));
  				var filters=$('#filtertagsinput').tagsinput('items');
  				$.each(filters,function(index,value){
  					if(value.id=='date'){
  						$('#filtertagsinput').tagsinput('remove', { id:'date', text:value.text });
  					}
  				});
  				$('#filtertagsinput').tagsinput('add', { id: 'date', text:start.format('DD.MM.YYYY') + ' to ' + end.format('DD.MM.YYYY'),type:'date'});
  			});
    		$('#cmbbranch').select2({
				placeholder:'Select Branch',
				allowClear:true
			});
			$('#cmbbrand').select2({
				placeholder:'Select Brand',
				allowClear:true
			});
			$('#cmbmodel').select2({
				placeholder:'Select Model',
				allowClear:true
			});
			$('.filter-dropdown .dropdown-menu').on('click', function(event) {
    			event.stopPropagation();
			});
    		$("#floorcard .collapse").on('show.bs.collapse', function(){
				$("#floorcard .collapse.in").collapse('hide');
			});
			$('.card-item').click(function(){
				$('.card-item').not(this).each(function(){
					if($(this).hasClass('active')){
						$(this).removeClass('active');		
					}
				});
				
				$(this).toggleClass('active');
			});
			$('#filtertagsinput').tagsinput({
				itemValue: function(item) {
			    	return item.id;
			  	},
			  	itemText: function(item) {
			    	return item.text;
			  	}
			});
			$('#cmbbrand').on('select2:select', function (e) {
  				getAdvFilterData("Brand",$('#cmbbrand').val());
			});
			$('#filtertagsinput').on('beforeItemAdd', function(event) {
				var filteritems=$("#filtertagsinput").tagsinput('items');
				//console.log(filteritems);
			});
			
			$('#cmbbrand,#cmbmodel').on('select2:select', function (e) {
				var filtervalue=$(this).val();
				var filtertext=$(this).find(":selected").text();
				var widgettype='';
				if($(this).attr('id')=='cmbbrand'){
					widgettype='brand';
				}
				if($(this).attr('id')=='cmbmodel'){
					widgettype='model';
				}
				$('#filtertagsinput').tagsinput('add', { id: filtervalue, text:filtertext,type:widgettype });
			});
			
			$('#cmbbranch').on('select2:select', function (e) {
  				if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!='a'){
  					var branchtext=$(this).find(":selected").text();
  					var filters=$('#filtertagsinput').tagsinput('items');
	  				$.each(filters,function(index,value){
	  					if(value.id=='branch'){
	  						$('#filtertagsinput').tagsinput('remove', { id:'branch', text:value.text });
	  					}
	  				});
  					$('#filtertagsinput').tagsinput('add', { id:'branch', text:branchtext,type:'branch'});
  				}
  				//funGetFilterData();
			});
			$('#cmbbranch').on('select2:clear', function (e) {
				var branchtext=$(this).find(":selected").text();
  				$('#filtertagsinput').tagsinput('remove', { id:'branch', text:branchtext });
  				//funGetFilterData();
			});
			$('#filtertagsinput').on('itemAdded', function(event) {
  				funGetFilterData();
			});
			$('#filtertagsinput').on('itemRemoved', function(event) {
  				funGetFilterData();
			});
			funGetFilterData();
    		funGetInitData();		
    	});
		
		function getAdvFilterData(type,value){
			$.get('getAdvFilterData.jsp',{widgettype:type,widgetvalue:value},function(data) {
				data=JSON.parse(data.trim());
				if(type=="Brand"){
					var htmldata='<option value="">--Select--</option>';
					$.each(data.widgetdata,function(index,val){
						htmldata+='<option value="'+val.docno+'">'+val.name+'</option>';
					});
					$('#cmbmodel').html($.parseHTML(htmldata));
					$('#cmbmodel').select2({
						placeholder:'Select Model',
						allowClear:true
					});
				}
			});
		}
		function funGetInitData(){
			$.get('getInitData.jsp', function(data) {
				data=JSON.parse(data);
				var htmldata='<option value="">--Select--</option>';
				$.each(data.branchdata,function(index,value){
					htmldata+='<option value="'+value.docno+'">'+value.name+'</option>';
				});
				$('#cmbbranch').html($.parseHTML(htmldata));
				$('#cmbbranch').select2({
					placeholder:'Select Branch',
					allowClear:true
				});
			});
		}
		function funGetFilterData(){
			var allTags = $("#filtertagsinput").tagsinput('items');
			var brandfilterarray=new Array();
			var modelfilterarray=new Array();
			var startfilterdate='';
			var endfilterdate='';
			if(allTags.length>0){
				$.each(allTags,function(index,val){
	  				if(val.type=='brand'){
	  					brandfilterarray.push(val.id);
	  				}
	  				else if(val.type=='model'){
	  					modelfilterarray.push(val.id);
	  				}
	  				else if(val.type=='date'){
	  					startfilterdate=val.text.split('to')[0].trim();
	  					endfilterdate=val.text.split('to')[1].trim();
	  				}
	  			});	
			}
			
			$.ajax({
				url: "getFilterData.jsp",
				data:{
					startdate:startfilterdate,
					enddate:endfilterdate,
					brandarray:JSON.stringify(brandfilterarray),
					modelarray:JSON.stringify(modelfilterarray),
					brhid:$('#cmbbranch').val()
				},
				success: function(data){
    				data=JSON.parse(data);
	    			radialchartoptions.series=[];
					radialchartoptions.colors=[];
					radialchartoptions.labels=[];
					gipgopchartoptions.series=[];
	    			var gippercent=((parseFloat(data.gipcount)/parseFloat(data.totalcount))*100).toFixed(0);
					var estpercent=((parseFloat(data.estcount)/parseFloat(data.totalcount))*100).toFixed(0);
					var jobpercent=((parseFloat(data.jobcount)/parseFloat(data.totalcount))*100).toFixed(0);
					var jccpercent=((parseFloat(data.jcccount)/parseFloat(data.totalcount))*100).toFixed(0);
					var invpercent=((parseFloat(data.invcount)/parseFloat(data.totalcount))*100).toFixed(0);
					var rlspercent=((parseFloat(data.relcount)/parseFloat(data.totalcount))*100).toFixed(0);
					
					$('.card-item').eq(0).find('.value').text(data.gipcount).closest('.card-item').find('.progress-bar').css('width',gippercent+'%');
					$('.card-item').find('.totalcount').text(data.totalcount);
					$('.card-item').eq(1).find('.value').text(data.estcount).closest('.card-item').find('.progress-bar').css('width',estpercent+'%');
					$('.card-item').eq(2).find('.value').text(data.jobcount).closest('.card-item').find('.progress-bar').css('width',jobpercent+'%');
					$('.card-item').eq(3).find('.value').text(data.jcccount).closest('.card-item').find('.progress-bar').css('width',jccpercent+'%');
					$('.card-item').eq(4).find('.value').text(data.invcount).closest('.card-item').find('.progress-bar').css('width',invpercent+'%');
					$('.card-item').eq(5).find('.value').text(data.relcount).closest('.card-item').find('.progress-bar').css('width',rlspercent+'%');
					
					radialchartoptions.series=[gippercent,estpercent,jobpercent,jccpercent,invpercent,rlspercent];
					radialchartoptions.colors=[window.colorScheme1[0],window.colorScheme1[1],window.colorScheme1[2],window.colorScheme1[3],window.colorScheme1[4],window.colorScheme1[5]];
					radialchartoptions.labels=['Gate In Pass','Estimation','Job Card','Job Card Completed','Invoiced','Released'];
					window.radialchart.updateOptions(radialchartoptions);
					var htmldata='';
					var srno=1;
					$.each(data.gipcarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.vocno+'</td>';
						htmldata+='<td>'+value.date+'</td>';
						htmldata+='<td>'+value.clientname+'</td>';
						htmldata+='<td>'+value.vehicledet+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapsegip table tbody').html($.parseHTML(htmldata));
					htmldata='';
					srno=1;
					$.each(data.estcarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.vocno+'</td>';
						htmldata+='<td>'+value.date+'</td>';
						htmldata+='<td>'+value.clientname+'</td>';
						htmldata+='<td>'+value.vehicledet+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapseest table tbody').html($.parseHTML(htmldata));
					htmldata='';
					srno=1;
					$.each(data.jobcarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.vocno+'</td>';
						htmldata+='<td>'+value.date+'</td>';
						htmldata+='<td>'+value.clientname+'</td>';
						htmldata+='<td>'+value.vehicledet+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapsejob table tbody').html($.parseHTML(htmldata));
					htmldata='';
					srno=1;
					$.each(data.jcccarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.vocno+'</td>';
						htmldata+='<td>'+value.date+'</td>';
						htmldata+='<td>'+value.clientname+'</td>';
						htmldata+='<td>'+value.vehicledet+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapsejcc table tbody').html($.parseHTML(htmldata));
					htmldata='';
					srno=1;
					$.each(data.invcarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.vocno+'</td>';
						htmldata+='<td>'+value.date+'</td>';
						htmldata+='<td>'+value.clientname+'</td>';
						htmldata+='<td>'+value.vehicledet+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapseinv table tbody').html($.parseHTML(htmldata));
					htmldata='';
					srno=1;
					$.each(data.rlscarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.vocno+'</td>';
						htmldata+='<td>'+value.date+'</td>';
						htmldata+='<td>'+value.clientname+'</td>';
						htmldata+='<td>'+value.vehicledet+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapserls table tbody').html($.parseHTML(htmldata));
					
					gipgopchartoptions.series.push({name:'Gate In Pass',data:data.gipseries});
					gipgopchartoptions.series.push({name:'Estimation',data:data.estseries});
					gipgopchartoptions.series.push({name:'Job Card',data:data.jobseries});
					gipgopchartoptions.series.push({name:'Invoiced',data:data.invseries});
					gipgopchartoptions.series.push({name:'Released',data:data.rlsseries});
					gipgopchartoptions.xaxis.categories=data.last12months;
					console.log(data);
					gipgopchartoptions.markers.strokeColors=[window.colorScheme1[0],window.colorScheme1[1],window.colorScheme1[2],window.colorScheme1[3],window.colorScheme1[4]];
					gipgopchartoptions.colors=[window.colorScheme1[0],window.colorScheme1[1],window.colorScheme1[2],window.colorScheme1[3],window.colorScheme1[4]];
					window.gipgopchart.updateOptions(gipgopchartoptions);
					amountstackedoptions.series=[];
					amountstackedoptions.series.push({name:'Labour',data:data.labourseries});
					amountstackedoptions.series.push({name:'Spare',data:data.spareseries});
					amountstackedoptions.xaxis.categories=data.last12months;
					window.amountstackedchart.updateOptions(amountstackedoptions);
					customerschartoptions.series=[];
					customerschartoptions.series.push({name:'New Customers',data:data.customerseries});
					customerschartoptions.xaxis.categories=data.last12months;
					window.customerschart.updateOptions(customerschartoptions);
					maintenancechartoptions.series=[];
					maintenancechartoptions.labels=data.repairtypelabels;
					maintenancechartoptions.colors=getChartColors(data.repairtypelabels.length);
					$.each(data.repairtypevalues,function(index,value){
						maintenancechartoptions.series.push(((parseFloat(value)/parseFloat(data.repairtypetotal))*100));
					});
					window.maintenancechart.updateOptions(maintenancechartoptions);
					htmldata='';
					var animatedelay=0;
					$.each(data.vehiclelistdata,function(index,value){
						var targetid='collapse'+index;
						animatedelay+=0.06;
						htmldata+='<li class="list-group-item animated slideInLeft" data-toggle="collapse" data-target="#'+targetid+'" style="animation-delay:'+animatedelay+'s;">'+value.brandname+' <span class="badge">'+value.totalcount+'</span></li>';
						htmldata+='<div class="collapse" id="'+targetid+'">';
						htmldata+='<ul class="list-group" style="margin-bottom:0px;">';
						$.each(value.modelarray,function(subindex,subvalue){
							htmldata+='<li class="list-group-item" style="border-color:#fff;padding-left: 25px;"><i class="fa fa-chevron-right" style="margin-right:8px;"></i>'+subvalue.name+' <span class="badge">'+subvalue.totalcount+'</span></li>';
						});
						htmldata+='</ul>';
						htmldata+='</div>';
						htmldata+='</li>';
					});
					$('.panel.custom-panel.vehicle-list .panel-body .list-group').html($.parseHTML(htmldata));
					htmldata='<option value="">--Select--</option>';
					$.each(data.vehiclelistdata,function(index,value){
						htmldata+='<option value="'+value.branddocno+'">'+value.brandname+'</option>';
					});
					$('#cmbbrand').html($.parseHTML(htmldata));
					$('#cmbbrand').select2({
						placeholder:'Select Brand',
						allowClear:true
					});
					htmldata='';
					srno=1;
					$.each(data.techniciandata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.refname+'</td>';
						htmldata+='<td>'+value.totalhrs+'</td>';
						htmldata+='<td align="right">'+value.total+'</td>';
						htmldata+='<td align="right">'+value.invoicetotal+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#tbltechnician tbody').html($.parseHTML(htmldata));
					
  				}
  			});
			
		}
		
		maintenancechartoptions = {
          series: [44, 55, 13, 43, 22],
          chart: {
          width: 400,
          type: 'donut',
          
        },
        tooltip:{
        	y:{
        		show:true,
        		formatter:function(val){
        			return val.toFixed(2);
        		}
        	}
        },
        legend: {
        	position: 'bottom'
        },
        labels: ['Team A', 'Team B', 'Team C', 'Team D', 'Team E'],
        responsive: [{
          breakpoint: 480,
          options: {
            chart: {
              width: 200
            },
            legend: {
              position: 'bottom'
            }
          }
        }]
        };
        
        window.maintenancechart = new ApexCharts(document.querySelector("#maintenancechart"), maintenancechartoptions);
        window.maintenancechart.render();
        
		customerschartoptions= {
          series: [{
          name: 'Inflation',
          data: [2.3, 3.1, 4.0, 10.1, 4.0, 3.6, 3.2, 2.3, 1.4, 0.8, 0.5, 0.2]
        }],
          chart: {
          height: 350,
          type: 'bar',
          toolbar: {
            show: false
          }
        },
        plotOptions: {
          bar: {
            borderRadius: 10,
            dataLabels: {
              position: 'top', // top, center, bottom
            },
          }
        },
        dataLabels: {
          enabled: true,
          formatter: function (val) {
            return val;
          },
          offsetY: -20,
          style: {
            fontSize: '12px',
            colors: ["#304758"]
          }
        },
        
        xaxis: {
          categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
          position: 'top',
          axisBorder: {
            show: false
          },
          axisTicks: {
            show: false
          },
          crosshairs: {
            fill: {
              type: 'gradient',
              gradient: {
                colorFrom: '#D8E3F0',
                colorTo: '#BED1E6',
                stops: [0, 100],
                opacityFrom: 0.4,
                opacityTo: 0.5,
              }
            }
          },
          tooltip: {
            enabled: true,
          }
        },
        yaxis: {
          axisBorder: {
            show: false
          },
          axisTicks: {
            show: false,
          },
          labels: {
            show: false,
            formatter: function (val) {
              return val;
            }
          }
        
        }
        };
        window.customerschart = new ApexCharts(document.querySelector("#customerschart"), customerschartoptions);
        window.customerschart.render();
        
		amountstackedoptions = {
          series: [{
          name: 'PRODUCT A',
          data: [44, 55, 41, 67, 22, 43]
        }, {
          name: 'PRODUCT B',
          data: [13, 23, 20, 8, 13, 27]
        }, {
          name: 'PRODUCT C',
          data: [11, 17, 15, 15, 21, 14]
        }, {
          name: 'PRODUCT D',
          data: [21, 7, 25, 13, 22, 8]
        }],
          chart: {
          type: 'bar',
          height: 325,
          stacked: true,
          toolbar: {
            show: false
          },
          zoom: {
            enabled: true
          }
        },
        responsive: [{
          breakpoint: 480,
          options: {
            legend: {
              position: 'bottom',
              offsetX: -10,
              offsetY: 0
            }
          }
        }],
        plotOptions: {
          bar: {
            horizontal: false,
            borderRadius: 10
          },
        },
        xaxis: {
          type: 'category',
          categories: ['01/01/2011 GMT', '01/02/2011 GMT', '01/03/2011 GMT', '01/04/2011 GMT',
            '01/05/2011 GMT', '01/06/2011 GMT'
          ],
        },
        legend: {
          position: 'bottom',
          offsetY: 40
        },
        fill: {
          opacity: 1
        }
        };

        window.amountstackedchart = new ApexCharts(document.querySelector("#amountstackedchart"), amountstackedoptions);
        window.amountstackedchart.render();
		radialchartoptions = {
		  chart: {
		    height: 280,
		    type: "radialBar",
		  },
		  series: [100, 75, 5, 25],
		  plotOptions: {
		    radialBar: {
		      dataLabels: {
		        total: {
		          show: false,
		          label: 'Overall'
		        }
		      }
		    }
		  },
		  colors: ['#1ab7ea', '#0084ff', '#39539E', '#0077B5'],
		  labels: ['Gate In Pass', 'Estimation', 'Job Card', 'Gate Out Pass']
		};
		
        window.radialchart = new ApexCharts(document.querySelector("#radialbarchart"), radialchartoptions);
        window.radialchart.render();
        
		gipgopchartoptions = {
		    series: [{
		        name: 'Gate In Pass',
		        data: [6, 20, 15, 40, 18, 20, 18, 23, 18, 35, 30, 55, 0]
		    }, {
		        name: 'Gate Out Pass',
		        data: [2, 22, 35, 32, 40, 25, 50, 38, 42, 28, 20, 45, 0]
		    }],
		    chart: {
		        height: 240,
		        type: 'area',
		        toolbar: {
		            show: false
		        },
		        animations: {
			        enabled: true,
			        easing: 'easeinout',
			        speed: 800,
			        animateGradually: {
			            enabled: true,
			            delay: 150
			        },
			        dynamicAnimation: {
			            enabled: true,
			            speed: 350
			        }
			    }
		    },
		    dataLabels: {
		        enabled: false
		    },
		    stroke: {
		        curve: 'smooth'
		    },
		    xaxis: {
		        type: 'category',
		        low: 0,
		        offsetX: 0,
		        offsetY: 0,
		        show: true,
		        categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan"],
		        labels: {
		            low: 0,
		            offsetX: 0,
		            show: true,
		        },
		        axisBorder: {
		            low: 0,
		            offsetX: 0,
		            show: true,
		        },
		    },
		    markers: {
		        strokeWidth: 3,
		        colors: "#ffffff",
		        strokeColors: [ '#7366ff' , '#f73164' ],
		        hover: {
		            size: 6,
		        }
		    },
		    yaxis: {
		        low: 0,
		        offsetX: 0,
		        offsetY: 0,
		        show: false,
		        labels: {
		            low: 0,
		            offsetX: 0,
		            show: false,
		        },
		        axisBorder: {
		            low: 0,
		            offsetX: 0,
		            show: false,
		        },
		    },
		    grid: {
		        show: false,
		        padding: {
		            left: 0,
		            right: 0,
		            bottom: -5,
		            top: -20
		        }
		    },
		    colors: [ '#7366ff' , '#f73164' ],
		    fill: {
		        type: 'gradient',
		        gradient: {
		            shadeIntensity: 1,
		            opacityFrom: 0.7,
		            opacityTo: 0.5,
		            stops: [0, 80, 100]
		        }
		    },
		    legend: {
		        show: false,
		    },
		    tooltip: {
		        x: {
		            format: 'MM'
		        },
		    },
		};
		
		window.gipgopchart = new ApexCharts(document.querySelector("#chart-gipgop"), gipgopchartoptions);
		window.gipgopchart.render();
	</script>
</body>
</html>