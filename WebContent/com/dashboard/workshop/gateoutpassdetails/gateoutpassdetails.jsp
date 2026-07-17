<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
<title>GOP Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />


  <style type="text/css">
  	:root {
	    --theme-deafult: #7366ff;
	    --theme-secondary: #f73164;
	}
	@font-face {
  		font-family: Poppins;
  		src: url('../../../../vendors/fonts/Poppins/Poppins-Regular.ttf')  format('truetype');
	}
	body{
		font-family:Poppins;
		font-size:12px;
	}
	input.form-control{
		height:34px !important;
		font-size:12px !important;
	}
	p{
		margin-bottom:0;
		
	}
	.panel-body{
		border:0;
	}
    .custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;
	   background-color:red;
	background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);	
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
    .textpanel p.h8{
   		margin-top: 4px;
    	margin-bottom: 3px;
    	text-size:10;
    }
    .load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
	
	/* .card-item{
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
    	display:inline-block;
	}
	.card-item h6{
		color:#fff;
		letter-spacing:0.2px;
		font-weight:200;
		display:inline-block;
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
		display:block;
	}
	.card-item svg.icon-bg{
		position: absolute;right: 2px;
		width: 48px;height:48px;opacity: 0.5;
		transition:all 0.3s ease;
		stroke:#fff;
	} */
	button[data-dismiss="modal"] {
		background-color:#fff;
	}
	.modal .well{
		padding:15px;
		margin-bottom:10px;
	}
	.modal .well fieldset legend{
		margin-bottom:10px;
	}
  </style>
</head>
<body >
	<!-- <div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
    <div class="row" style="margin-top:8px;">
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
					<h6><strong>Job Card Complete</strong></h6>
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
		</div> -->
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="fromdatepanel custompanel">
      <table>
      <tr><td  align="right" ><label class="branch" style="font-size: 13px">From &nbsp;&nbsp;</label></td>
	 	<td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td></tr>
      </table>
      </div>
      <div class="todatepanel custompanel">
      <table>
      <tr><td  align="right" ><label class="branch" style="font-size: 13px">To &nbsp;&nbsp;</label></td>
      <td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td></tr>                 
	 </table>
      </div>  
        <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<div class="dropdown" style="display:inline-block;">
        		<button type="button" class="btn btn-default dropdown-toggle" id="btninfo" data-toggle="dropdown"><i class="fa fa-info-circle " data-toggle="tooltip" title="Info" data-placement="bottom" aria-hidden="true"></i></button>
	        	<ul class="dropdown-menu">
	    			<li style="padding-left:10px;"><span class="badge redClass" style="margin-right:10px;">&nbsp;</span>Back Jobs</a></li>
	  			</ul>
        	</div>
        	
        	<select name="cmbbranch" id="cmbbranch" style="min-width:125px;"><option value="">--Select--</option></select>
        </div>
        <!-- <div class="actionpanel custompanel">
          <button type="button" class="btn btn-default" id="btnvehmovupdate" data-target="#modalvehmovupdate" ><i class="fa fa-car " aria-hidden="true" data-toggle="tooltip" title="Vehicle Movement Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnjobstatus"  data-target="#modaljobstatus" ><i class="fa fa-filter " aria-hidden="true" data-toggle="tooltip" title="Job Status" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnteamselection" data-target="#modalteamselection"><i class="fa fa-users " aria-hidden="true" data-toggle="tooltip" title="Team Selection" data-placement="bottom"></i></button>
        </div> -->
        <!-- <div class="warningpanel custompanel">
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnpartsdelay" data-toggle="tooltip" title="Parts Delay" data-placement="bottom" data-filtervalue="Delayed" data-datafield="partsstatus" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-cogs " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-partsdelay">3</span>
          </div>	
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnhrsexceeded" data-toggle="tooltip" title="Hours Exceeded" data-placement="bottom"  data-filtervalue="0" data-datafield="hrsdiff" data-filtertype="numericfilter"  data-filtercondition="GREATER_THAN"><i class="fa fa-hourglass-2 " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-hrsexceeded">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnoverdue" data-toggle="tooltip" title="Overdue" data-placement="bottom"   data-filtervalue="0" data-datafield="promiseddate" data-filtertype="datefilter"  data-filtercondition="LESS_THAN"><i class="fa fa-toggle-up " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-overdue">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnextendeddate" data-toggle="tooltip" title="Extended Date" data-placement="bottom"  data-filtervalue="0" data-datafield="extdate" data-filtertype="datefilter"  data-filtercondition="NOT_NULL"><i class="fa fa-level-up " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-extendeddate">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnhighpriority" data-toggle="tooltip" title="High Priority" data-placement="bottom" data-filtervalue="High" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-exclamation-triangle " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-highpriority">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnunattended" data-toggle="tooltip" title="Un Attended" data-placement="bottom" data-filtervalue="0" data-datafield="unattendedstatus" data-filtertype="numericfilter"  data-filtercondition="GREATER_THAN"><i class="fa fa-low-vision " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-unattended">3</span>
          </div>
        	
        </div> -->
        <!-- <div class="detailpanel custompanel">
          	<button type="button" class="btn btn-default" id="btncreateclient" ><i class="fa fa-user-plus" aria-hidden="true" data-toggle="tooltip" title="Create Client" data-placement="bottom"></i></button>
          	<button type="button" class="btn btn-default" id="btnchangebillto"><i class="fa fa-address-book " aria-hidden="true" data-toggle="tooltip" title="Change Bill To" data-placement="bottom"></i></button>
          	<button type="button" class="btn btn-default" id="btncreateest" ><i class="fa fa-copy " aria-hidden="true" data-toggle="tooltip" title="Create Estimation" data-placement="bottom"></i></button>
          	<button type="button" class="btn btn-default" id="btnqotapproval" ><i class="fa fa-calendar-check-o " aria-hidden="true" data-toggle="tooltip" title="Quotation Approval" data-placement="bottom"></i></button>
          	<button type="button" class="btn btn-default" id="btncreatejobcard"><i class="fa fa-briefcase " aria-hidden="true" data-toggle="tooltip" title="Create Job Card" data-placement="bottom"></i></button>
          	<button type="button" class="btn btn-default" id="btncreategateoutpass"><i class="fa fa-sign-out " aria-hidden="true" data-toggle="tooltip" title="Create Gate Out Pass" data-placement="bottom"></i></button>
          	<button type="button" class="btn btn-default" id="btnrelease"><i class="fa fa-external-link" aria-hidden="true" data-toggle="tooltip" title="Release" data-placement="bottom"></i></button>  
        	<button type="button" class="btn btn-default" id="btnvirtual"><i class="fa fa-car" aria-hidden="true" data-toggle="tooltip" title="Physical Availability" data-placement="bottom"></i></button>
        	<button type="button" class="btn btn-default" id="btnclosegip"><i class="fa fa-times" aria-hidden="true" data-toggle="tooltip" title="Close GIP" data-placement="bottom"></i></button>
          	<button type="button" class="btn btn-default" id="btnchecklist" ><i class="fa fa-check" aria-hidden="true" data-toggle="tooltip" title="Checklist" data-placement="bottom"></i></button>
        	
        </div> -->
        <div class="otherpanel custompanel">
        	<div class="dropdown" style="display:inline-block;">
  				<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-list" aria-hidden="true" data-toggle="tooltip" title="View Estimation" data-placement="bottom"></i>
  					<span class="caret"></span>
  				</button>
  				<ul class="dropdown-menu">
    				
  				</ul>
			</div>
        	<!-- <button type="button" class="btn btn-default" id="btnviewest" ><i class="fa fa-list" aria-hidden="true" data-toggle="tooltip" title="View Estimation" data-placement="bottom"></i></button> -->
        	<div class="btn-group">
        		<button type="button" class="btn btn-default" id="btnprintgip" data-toggle="tooltip" title="Print Gate In Pass" data-placement="bottom"><i class="fa fa-print" aria-hidden="true" ></i></button>
        		<span class="badge badge-notify">G</span>
        	</div>
        	<!-- <div class="btn-group" hidden="true">
        		<button type="button" class="btn btn-default" id="btnprintest" data-toggle="tooltip" title="Print Estimation" data-placement="bottom"><i class="fa fa-print" aria-hidden="true" ></i></button>
        		<span class="badge badge-notify">E</span>
        	</div> -->
        	<div class="btn-group">
        		<button type="button" class="btn btn-default" id="btnprintjobcard" data-toggle="tooltip" title="Print Job Card" data-placement="bottom"><i class="fa fa-print" aria-hidden="true" ></i></button>
        		<span class="badge badge-notify">J</span>
        	</div>
        	<div class="btn-group" >
        		<button type="button" class="btn btn-default" id="btnprintopenjobcard" data-toggle="tooltip" title="Print Open Job Card List" data-placement="bottom"><i class="fa fa-print" aria-hidden="true" ></i></button>
        		<span class="badge badge-notify">OJ</span>
        	</div>
        	<!-- <div class="btn-group" >
        		<button type="button" class="btn btn-default" id="btnprintopengip" data-toggle="tooltip" title="Print Open Inspection Report" data-placement="bottom"><i class="fa fa-print" aria-hidden="true" ></i></button>
        		<span class="badge badge-notify" id="textgip">IR</span>
        	</div> -->
	        <button type="button" class="btn btn-default" id="btnattach"><i class="fa fa-paperclip" aria-hidden="true" data-toggle="tooltip" title="GIP Attachments" data-placement="bottom"></i></button>
	        
	        <button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>
        <div class="textpanel custompanel" style="max-width:300px;height:55px;">
			<p style="word-wrap: break-word;font-size:1.1rem;">&nbsp;</p>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="gateoutpassdetailsGriddiv"><jsp:include page="gateoutpassdetailsGrid.jsp"></jsp:include></div>
      </div>
    </div>
	<div id="modalprintjobcard" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Print Job Card #<span class="jobvocno"></span></h4>
          		</div>
          		<div class="modal-body" style="background: #E0ECF8;">
					<div id="printjccontainer"><jsp:include page="printVoucherWindow.jsp"></jsp:include></div>    				       	
            	</div>
          	</div>
		</div>
	</div>
	<!-- Modal GIP Close -->
	<div id="modalclosegip" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Close GIP #<span class="gipvocno"></span></h4>
          		</div>
          		<div class="modal-body">
    				<div class="form-horizontal">
    					<div class="form-group">
    						<label class="control-label col-sm-3" for="createclientname">Reason:</label>
    						<div class="col-sm-9">
      							<input type="text" name="closegipreason" id="closegipreason" class="form-control">
    						</div>
    					</div>
    				</div>        	
            	</div>
          		<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" name="btnclosegipsave" id="btnclosegipsave" class="btn btn-default btn-primary">Update</button>
          		</div>
          	</div>
		</div>
	</div>
	<div id="modalvirtual" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Update Physical Availability</h4>
          		</div>
          		<div class="modal-body">
    				<div class="form-horizontal">
    					<div class="form-group">
    						<label class="control-label col-sm-5" for="createclientname">Physically Not Available:</label>
    						<div class="col-sm-7">
      							<select name="cmbvirtual" id="cmbvirtual" class="form-control" style="width:100%;">
      								<option value="1">Yes</option>
      								<option value="0">No</option>
      							</select>
    						</div>
    					</div>
    				</div>        	
            	</div>
          		<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" name="btnvirtualsave" id="btnvirtualsave" class="btn btn-default btn-primary">Update</button>
          		</div>
          	</div>
		</div>
	</div>
	<!-- Client Creation Modal -->
	<div id="modalcreateclient" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Client Creation</span></h4>
          		</div>
          		<div class="modal-body">
    				<div class="form-horizontal">
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="createclientname">Client Name:</label>
    						<div class="col-sm-10">
      							<input type="text" class="form-control" id="createclientname" placeholder="Enter Name">
    						</div>
    					</div>
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="createclientmobile">Mobile:</label>
    						<div class="col-sm-10">
      							<input type="text" class="form-control" id="createclientmobile" placeholder="Enter Mobile No">
    						</div>
    					</div>
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="createclientemail">Email:</label>
    						<div class="col-sm-10">
      							<input type="text" class="form-control" id="createclientemail" placeholder="Enter E-Mail Id">
    						</div>
    					</div>
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="createclientaddress">Address:</label>
    						<div class="col-sm-10">
      							<input type="text" class="form-control" id="createclientaddress" placeholder="Enter Address">
    						</div>
    					</div>
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="createclientcategory">Category:</label>
    						<div class="col-sm-10">
      							<select name="cmbcreateclientcat" id="cmbcreateclientcat" class="form-control" style="width:100%;">
      								<option value="">--Select--</option>
      							</select>
    						</div>
    					</div>
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="createclienttrno">TRNO:</label>
    						<div class="col-sm-10">
      							<input type="text" class="form-control" id="createclienttrn" placeholder="Enter TRNO">
    						</div>
    					</div>
    					
    				</div>        	
            	</div>
          		<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" name="btncreateclientsave" id="btncreateclientsave" class="btn btn-default btn-primary">Update</button>
          		</div>
          	</div>
		</div>
	</div>
		<!-- checklist -->
	
	 <div id="modalchecklist" class="modal fade" role="dialog">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Check List</h4>
          </div>
        <div class="modal-body">
            		<div class="form-horizontal">
						  <div class="form-group">
    						<label class="control-label col-sm-3" for="policereportno">Police Report No</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="policereportno" name="policereportno" style="width:20%;"  >
    						</div>   						     
  						</div>
  						 <div class="form-group">
						     <label class="control-label col-sm-3" for="policereportdate">Police Report Date</label>   
						      <div class="col-sm-9 input-container">
						     <div id="policereportdate"></div>
						     <input type="hidden" id="hidpolicereportdate" name="hidpolicereportdate"  />
						     
						     </div>
						  </div>
  						<div class="form-group">
						     <label class="control-label col-sm-3" for="regexpirydate"> Registration Card Expiry</label>   
						      <div class="col-sm-9 input-container">
						     <div id="regexpirydate"></div>
						     <input type="hidden" id="hidregexpirydate" name="hidregexpirydate"  />
						     
						     </div>
						  </div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbdrvlicence">Driving Licence</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbdrvlicence" name="cmbdrvlicence" style="width:20%;">
      							<option value="0">--Select--</option><option value="1">Yes</option><option value="2">No</option></select>
    						<input type="hidden" id="hidcmbdrvlicence" name="hidcmbdrvlicence" />
    					
    						</div>   						     
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbemiratesid">Emirates ID</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbemiratesid" name="cmbemiratesid" style="width:20%;" ><option value="0">--Select--</option><option value="1">Yes</option><option value="2">No</option></select>
    						<input type="hidden" id="hidcmbemiratesid" name="hidcmbemiratesid"  />
    						
    						</div>   						     
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbcolor">Car Colour</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbcolor" name="cmbcolor" style="width:20%;"><option value="0">--Select--</option></select>
      							<input type="hidden" id="hidcmbcolor" name="hidcmbcolor"  />
      							
    						</div>   						     
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbpriority">Priority</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbpriority" name="cmbpriority" style="width:20%;">
      							<option value="0">--Select--</option>
      							<option value="1" >Normal</option>
								<option value="2">High</option>
      							</select>
      							<input type="hidden" id="hidcmbpriority" name="hidcmbpriority"  />
      							
    						</div>   						     
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbinstype">Insurance Type</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbinstype" name="cmbinstype" style="width:20%;">
      							<option value="0">--Select--</option>
      							<option value="1">Comprehensive</option>
		  								<option value="2">Non Comprehensive</option>
		  								
      							</select>
      							<input type="hidden" id="hidcmbinstype" name="hidcmbinstype"  />
      							
    						</div>   						     
  						</div>
  						
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbclaimtype">Fault Type</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbclaimtype" name="cmbclaimtype" style="width:20%;">
      							<option value="0">--Select--</option>
      							<option value="1">Third party </option>
		  								<option value="2">Own</option>
		  							<option value="3">Recovery</option>
		  								
      							</select>
      							<input type="hidden" id="hidcmbclaimtype" name="hidcmbclaimtype"  />
      							
    						</div>   						     
  						</div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="marketingperson">Estimator</label>    
						<div class="col-sm-9 input-container">
      							<input type="text" id="marketingperson" name="marketingperson" style="width:40%;" onkeydown="getMarketingPerson(event);" placeholder="Press F3 to Search" >
  											<input type="hidden" id="hidmarketingperson" name="hidmarketingperson" />
  						
  						</div>
  						</div> 
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="chklistremarks">Remarks</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="chklistremarks" name="chklistremarks" style="width:40%;"  >
    						</div>   						     
  						</div>	
  						<div class="form-group">
						     <label class="control-label col-sm-3" for="referencedby">Referred By</label>    
						<div class="col-sm-9 input-container">
      							<input type="text" id="referencedby" name="referencedby" style="width:40%;" onkeydown="getReferencedBy(event);" placeholder="Press F3 to Search" >
  											<input type="hidden" id="hidreferencedby" name="hidreferencedby" />
  						
  						</div>
  						</div> 		 
  						</div>  
            		</div>
          <div class="modal-footer">
          			<button type="button" name="btnchecklistsave" id="btnchecklistsave" class="btn btn-default btn-primary">Save</button>
          
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
	
	
	
	<!-- Qotation Approval Modal -->
	<div id="modalqotapproval" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Quotation Approval of GIP #<span class="gipvocno"></span></h4>
          		</div>
          		<div class="modal-body">
    				<div class="form-horizontal">
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="qotpono">PO No:</label>
    						<div class="col-sm-10">
      							<input type="text" class="form-control" id="qotpono" placeholder="Enter PO No">
    						</div>
    					</div>
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="qotdesc">Description:</label>
    						<div class="col-sm-10">
      							<input type="text" class="form-control" id="qotdesc" placeholder="Enter Description">
    						</div>
    					</div>
    					<div class="form-group">
    						<label class="control-label col-sm-2" for="chkqotexcess">Excess:</label>
    						<div class="col-sm-1">
    							<div class="checkbox" style="padding-top:0px;">
    								<input type="checkbox" class="form-control" id="chkqotexcess" style="margin-top:0px;margin-left:0px;" onchange="setQotExcess();">
    							</div>
    						</div>
    						<div class="col-sm-9">
    							<input type="text" class="form-control text-right" id="qotexcessamt" placeholder="Enter Excess Amount" disabled onblur="funRoundAmt(value,id);">
    						</div>
    					</div>
    				</div>        	
            	</div>
          		<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" name="btnqotapprovalsave" id="btnqotapprovalsave" class="btn btn-default btn-primary">Update</button>
          		</div>
          	</div>
		</div>
	</div>	
	
    <!-- Bill To Modal-->
    <div id="modalchangebillto" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Change Bill To</h4>
          </div>
          <div class="modal-body">
          	  	<div class="panel panel-default">
	          		<div class="panel-heading">
	          			<p>Bill To Insurance Company</p>
	          		</div>
	          		<div class="panel-body" style="border:0;">
	          			<select class="cmbbilltoinsur" name="cmbbilltoinsur" id="cmbbilltoinsur" style="width: 100%">
	 						<option value="">--Select--</option>
						</select>
	          		</div>          		
	          	</div>
	          	<div class="panel panel-default">
	          		<div class="panel-heading">
	          			<p>Client</p>
	          		</div>
	          		<div class="panel-body" style="border:0;">
	          			<select class="cmbbilltoclient" name="cmbbilltoclient" id="cmbbilltoclient" style="width: 100%">
	  						<option value="">--Select--</option>
						</select>
	          		</div>          		
	          	</div>
          
            </div>
          	<div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          	<button type="button" name="btnbilltoupdate" id="btnbilltoupdate" class="btn btn-default btn-primary">Update</button>
          </div>
          </div>
          
        </div>
      </div>
    </div>

    <!-- Job Status Modal-->
    <div id="modalgateoutpass" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Create Gate Out Pass</h4>
          </div>
          <div class="modal-body">
          	<div class="container-fluid">
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
            			<label name="lblgopdetails" id="lblgopdetails"></label>
            		</div>
            	</div>
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            			Date
            		</div>
            		<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            			<div id="gopdate"></div>
					</div>
            	</div>
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            			Time
            		</div>
            		<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            			<div id="goptime"></div>
					</div>
            	</div>
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            			Km
            		</div>
            		<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            			<input type="text" name="gopkm" id="gopkm" class="form-control">
					</div>
            	</div>
            	<div class="row rowgap">
            		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            			Fuel
            		</div>
            		<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            			<select name="cmbgopfuel" id="cmbgopfuel" class="form-control" style="width:100%;">
							<option value="">--Select--</option>
							<option value="0.000">Level 0/8</option>
							<option value="0.125">Level 1/8</option>
							<option value="0.250">Level 2/8</option>
							<option value="0.375">Level 3/8</option>
							<option value="0.500">Level 4/8</option>
    						<option value="0.625">Level 5/8</option>
    						<option value="0.750">Level 6/8</option>
    						<option value="0.875">Level 7/8</option>
    						<option value="1.000">Level 8/8</option>
            			</select>
					</div>
            	</div>
            </div>
          </div>
		<div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-default btn-primary" id="btngopupdate">Update</button>
        </div>
        </div>
      </div>
    </div>

    <!-- Team Selection Modal-->
    <div id="modalteamselection" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Team Selection</h4>
          </div>
          <div class="modal-body">
            <div class="container-fluid">
            	<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#tabteamstoselect">To Be Selected</a></li>
				    <li><a data-toggle="tab" href="#tabselectedteams">Selected Teams</a></li>
				</ul>
				<div class="tab-content">
    				<div id="tabteamstoselect" class="tab-pane fade in active">
      					<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<h4>Select Zone</h4>  
            						</div>
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<div class="checkbox">
		  									<label><input type="checkbox" value="" class="chkallbays">All Zones</label>
										</div>
            						</div>
            					</div>
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	            						<select class="cmbteamupdatebay form-control" id="cmbteamupdatebay" name="cmbteamupdatebay" style="width: 100%">
		  									<option value="">--Select--</option>
										</select>
									</div>
            					</div>
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            					<h4>Select Team</h4>
            					<select class="cmbteamupdate form-control" id="cmbteamupdate" name="cmbteamupdate[]" multiple="multiple" style="width: 100%">
									<option value="">--Select--</option>
								</select>
            				</div>
            			</div>
            			<div class="row">
            				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
            					<button type="button" class="btn btn-default" name="btnteamupdate" id="btnteamupdate">UPDATE</button>
            				</div>
            			</div>
    				</div>
    				<div id="tabselectedteams" class="tab-pane fade">
      					<div id="selectedteamsgriddiv"><jsp:include page="selectedTeamsGrid.jsp"></jsp:include></div>
    				</div>
            	</div>
          	</div>
          	<div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          	</div>
        </div>
      </div>
    </div>
</div>
    <!-- Parts Details Modal-->
    <div id="modalpartsdetails" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Parts Details</h4>
          </div>
          <div class="modal-body">
            <div id="partsdetailsgriddiv"><jsp:include page="partsDetailsGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Work Details Modal-->
    <div id="modalworksdetails" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Work Details</h4>
          </div>
          <div class="modal-body">
            <div id="jobworkersgriddiv"><jsp:include page="jobWorkersGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Vehicle Movement List Modal-->
    <div id="modalvehmovement" class="modal fade" role="dialog">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Vehicle Movement List</h4>
          </div>
          <div class="modal-body">
            <div id="baymovgriddiv"><jsp:include page="bayMovGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Comments Modal-->
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Comments</h4>
          </div>
          <div class="modal-body">
            <div class="comments-outer-container container-fluid">
              <div class="comments-container">
                
              </div>
              <div class="create-msg-container">
                <!-- <div class="container-fluid"> -->
                  <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                      <div class="input-group">
                        <input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                        <div class="input-group-btn">
                          <button type="button" id="btncommentsend" class="btn btn-default">
                            <i class="fa fa-paper-plane"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                <!-- </div> -->
              </div>
            </div>
          </div>
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
        </div>
      </div>
    </div>
  </div>
  <input type="hidden" name="docno" id="docno">
  <input type="hidden" name="vocno" id="vocno">
  <input type="hidden" name="rowindex" id="rowindex">
  <input type="hidden" name="z2count" id="z2count">
  <input type="hidden" name="z3count" id="z3count">
  <input type="hidden" name="z4count" id="z4count">
  <input type="hidden" name="z5count" id="z5count">
  <input type="hidden" name="z6count" id="z6count">
  <input type="hidden" name="z7count" id="z7count">
  <input type="hidden" name="z8count" id="z8count">
  <input type="hidden" name="z9count" id="z9count">
  <input type="hidden" name="z10count" id="z10count">
  <input type="hidden" name="z11count" id="z11count">
  <input type="hidden" name="z12count" id="z12count">
  <input type="hidden" name="z13count" id="z13count">
  <input type="hidden" name="z14count" id="z14count">
  <input type="hidden" name="gatedocno" id="gatedocno">
  <input type="hidden" name="estdocno" id="estdocno">
  <input type="hidden" name="branch" id="branch">
  <input type="hidden" name="refno" id="refno">
   <input type="hidden" name="fileattachconfig" id="fileattachconfig">
     <input type="hidden" name="attachmethod" id="attachmethod">
     <input type="hidden" name="checklistconfig" id="checklistconfig">
       <input type="hidden" name="accidentconfig" id="accidentconfig">
  
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<!--  -->
<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>

<script type="text/javascript">
	 var rawfilterdata=[];  

    $(document).ready(function(){
    	$("#btncreateclient").hide();
    	$("#btnchangebillto").hide();
    	$("#btncreateest").hide();
    	$("#btnqotapproval").hide();
    	$("#btncreatejobcard").hide();
    	$("#btncreategateoutpass").hide();
    	$("#btnrelease").hide();
    	$("#btnvirtual").hide();
    	$("#btnclosegip").hide();
    	$("#btnchecklist").hide(); 
        $('[data-toggle="tooltip"]').tooltip();
        $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		  
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	    $('#todate').on('change', function (event) {
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 lead
			  // out date
			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
			 	 
			   if(fromdates>todates){
				   
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				 
			   return false;
			   }}) 
        $("#goptime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",value:new Date(),showCalendarButton:false});  
	 	$("#gopdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#policereportdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$('#marketingpersonwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Estimator Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 	$('#marketingpersonwindow').jqxWindow('close');
	 	$('#referencedbywindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Referred By Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 	$('#referencedbywindow').jqxWindow('close');

	 	$("#hidpolicereportdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#regexpirydate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#hidregexpirydate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	   $('#cmbbranch,.cmbbaystatus,.cmbbaystatusupdate,.cmbteamupdatebay,#cmbgopfuel').select2();
        $('#cmbvirtual,.cmbteamupdate').select2();
        $('.cmbbilltoclient').select2({
        	placeholder:"Select Client",
        	allowClear:true
        });
        $('.cmbbilltoinsur').select2({
        	placeholder:"Select Insurance Company",
        	allowClear:true
        });
        $( "#marketingperson" ).dblclick(function() {
        	$('#marketingpersonwindow').jqxWindow('open');
        	$('#marketingpersonwindow').jqxWindow('focus');
        	SearchContent('marketingPersonSearchGrid.jsp?id=1','marketingpersonwindow');
        });
        $( "#referencedby" ).dblclick(function() {
        	$('#referencedbywindow').jqxWindow('open');
        	$('#referencedbywindow').jqxWindow('focus');
        	SearchContent('referencedBySearchGrid.jsp?id=1','referencedbywindow');
        });
        //$("#btnprintopengip").hide();
        //$("#textgip").hide();
        getconfig();
        funGetCountData();
        /* funGetFilterData(); */
        getAllBays();
        getTeam();
        getColor();
        $('.load-wrapp').hide();
        $('#btnattach').click(function(){
        	var targetid=$(this).attr('id');
        	var rowindex=$('#rowindex').val();
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
			var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	if(docno=='' || docno==null || docno=="undefined" || typeof(docno)=="undefined"){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
        	var formname="Gate In Pass";
        	var  myWindow= window.open("../../../../com/common/Attachmaster.jsp?formCode=GIP&docno="+docno+"&brchid="+brhid+"&frmname="+formname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
        });
         
        
        
        
        $('#btnprintopenjobcard').click(function(){
        	var url=document.URL;
        	var reurl=url.split("com/dashboard/");
 			var gatedocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
 			var estdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estdocno');
 			var jobdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'jobdocno');
 			var brhid=$('#cmbbranch').val();
            var jobdet=1;
            if(brhid=='' || brhid==null || brhid=="undefined" || typeof(brhid)=="undefined"){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a branch'
				});
				return false;
        	}
 			var path= "com/dashboard/workshop/gopdetails/printgopdetails.action?branch="+brhid;  
 			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
 			win.focus();
        });
        
        $('#btnprintopengip').click(function(){
        	var url=document.URL;
        	var rowindex=$('#rowindex').val();
        	var reurl=url.split("com/dashboard/");
 			var gatedocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
 			var estdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estdocno');
 			var jobdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'jobdocno');
 			var brhid=$('#cmbbranch').val();
            var jobdet=1;
            if(brhid=='' || brhid==null || brhid=="undefined" || typeof(brhid)=="undefined"){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a branch'
				});
				return false;
        	}
        	if(gatedocno=='' || gatedocno==null || gatedocno=="undefined" || typeof(gatedocno)=="undefined"){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
 			var path= "com/dashboard/workshop/gipmgmt/printgipmgmt.action?branch="+brhid+"&docno="+gatedocno+"&printmode=1";  
 			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
 			win.focus();
        });
        
        
        $('#btnprintgip,#btnprintest,#btnprintjobcard').click(function(){
        	var targetid=$(this).attr('id');
        	var rowindex=$('#rowindex').val();
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
			var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	if(docno=='' || docno==null || docno=="undefined" || typeof(docno)=="undefined"){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
        	var url=document.URL;
        	if (targetid=="btnprintgip") {
				var reurl=url.split("com/dashboard/");
				//var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
				//alert(reurl[0])
				var win= window.open(reurl[0]+"Gateinpassprint?docno="+docno+"&brhid="+brhid+"&formdetailcode=GIP","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				//http://localhost:8999/WORKSHOP/com/workshop/gateinpassmaster/Gateinpassprint?docno=21&branch=1&formdetailcode=GIP
				win.focus();
			}
            else if(targetid=="btnprintest") {
				if(parseInt(processstatus)<2){
	        		Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Please create estimation before proceeding'
					});
					return false;
	        	}
				var reurl=url.split("com/dashboard/");
				var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estdocno');
				var estvocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estvocno');
				var gatedoc=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
				var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');      
				var path= "com/workshop/estimationpal/printEstimation1.action?estDocno="+estvocno+"&docno="+docno+"&gatedocno="+gatedoc+"&branch="+brhid+"&addition="+0+"&withvat="+1;       
				var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=700,Height=600,location=no,scrollbars=yes,toolbar=yes");	          	
				win.focus();	                
			}
            else if(targetid=="btnprintjobcard") {
               	if(parseInt(processstatus)<5){
	        		Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Please create job card before proceeding'
					});
					return false;
	        	}
	        	var jobvocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'jobvocno');
	        	$('span.jobvocno').text(jobvocno);
	        	$('#modalprintjobcard').modal('show');
	        	
	 			/*var reurl=url.split("com/dashboard/");
	 			var gatedocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
	 			var estdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estdocno');
	 			var jobdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'jobdocno');
	 			var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');
	            var jobdet=1;
	 			var path= "com/workshop/jobcardpal/WSJobCardPrintPalAction1?docno="+jobdocno+"&gatedocno="+gatedocno+"&estdocno="+estdocno+"&branch="+brhid+"&refno="+estdocno+"&jobdet="+jobdet;  
	 			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
	 			win.focus();*/
			}
           
        });
        $('#btnviewest').click(function(){
        	var rowindex=$('#rowindex').val();
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	if(docno==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
        	else if(parseInt(processstatus)<2){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create estimation'
				});
				return false;
        	}
        	else{
        		var url=document.URL;
				var reurl=url.split("com/");
				var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estdocno');
				var estvocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estvocno');
				var gatedoc=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
				var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');
				window.parent.formName.value="Estimation";
			  	window.parent.formCode.value="EST";
			  	var detName="Estimation";
			  	var path= "com/workshop/estimationpal/estimationPalView.action?id=2&mode=view&docno="+docno+"&gipnoo="+gatedoc;
			 	top.addTab( detName,reurl[0]+""+path);
        	}
        });
        /*$("#qotexcessamt").keypress(function(){
  			var excessamt=$(this).val();
  			if(isNaN(excessamt)){
       			$('#qotexcessamt').closest('div').find('span.help-block').remove();
       			$('#qotexcessamt').closest('div').append('<span class="help-block" style="color:red;"><small>Only Numbers Allowed</small></span>');
       			$('#qotexcessamt').focus();
       			return false;
       		}
       		else{
       			$('#qotexcessamt').closest('div').find('span.help-block').remove();
       		}
		});*/
            $('#btnsubmit').click(function(){
        	/* funGetFilterData(); */
        	$('.page-loader').show();
        	funload();
        });
        $('#btnvirtual').click(function(){
        	var rowindex=$('#rowindex').val();
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	if(docno==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
        	else{
        		$('#modalvirtual').modal('show');	
        	}
        	
        });
        $('#btnchecklist').click(function(){
        	var docno=$('#gatedocno').val();
        	if(docno==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
        	else{
        		$('#modalchecklist').modal('show');	
        	}
        	
        });
        $('#btnvirtualsave').click(function(){
        	var rowindex=$('#rowindex').val();
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	
        	if(docno!=''){
        		Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to save changes of GIP#"+vocno,
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				$('.page-loader').show();
	    				$.post('updateVirtual.jsp',
	    					{
	    						virtual:$('#cmbvirtual').val(),
	    						docno:docno
	    					},
	    					function(data,status){
	    						$('.page-loader').hide();
	    						data=JSON.parse(data);
	    						if(data.errorstatus=='0'){
	    							Swal.fire({
										icon:'success',
										type: 'success',
										title: 'Success',
										text: 'Updated successfully'
									});
				          			$('#gateoutpassdetailsGriddiv').load('gateoutpassdetailsGrid.jsp?id=1&brhid='+$("#cmbbranch").val());
	    						}
	    						else{
	    							Swal.fire({
										icon:'warning',
										type: 'error',
										title: 'Warning',
										text: 'Not Updated'
									});
									return false;	
	    						}
	    					});
	  					}
					});
        		}
        });
        
        
        
        $('#btnchecklistsave').click(function(){
        	var gatedocno=$('#gatedocno').val();
        	var policereportno=$('#policereportno').val();
        	var policereportdate=$('#policereportdate').jqxDateTimeInput('val');
        	var regexpirydate=$('#regexpirydate').jqxDateTimeInput('val');
        	var drvlicence=$('#cmbdrvlicence').val();
        	var emiratesid=$('#cmbemiratesid').val();
        	var carcolor=$('#cmbcolor').val();
        	var claimtype=$('#cmbclaimtype').val();
        	var priority=$('#cmbpriority').val();
        	var estimator=$('#hidmarketingperson').val();
        	var instype=$('#cmbinstype').val();
        	var chklistremarks=$('#chklistremarks').val();
        	var referencedby=$('#hidreferencedby').val();

        	
        	
        	if(policereportno==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Enter Police Report'
				});
				return false;
        	}
        	else if(policereportdate==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Police Report Date'
				});
				return false;
        	}
        	else if(regexpirydate==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Reg. Expiry Date'
				});
				return false;
        	}
        	else if(drvlicence=='' || drvlicence=='0'){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Driving Licence '
				});
				return false;
        	}
        	else if(emiratesid=='' || emiratesid=='0'){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Emirates ID'
				});
				return false;
        	}
        	
        	else if(carcolor=='' ||carcolor=='0'){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Car Colour'
				});
				return false;
        	}
        	
        	else if(priority=='' || priority=='0'){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Priority'
				});
				return false;
        	}
        	else if(instype=='' || instype=='0'){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Insurance Type'
				});
				return false;
        	}
        	else if(claimtype=='' || claimtype=='0'){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Fault Type'
				});
				return false;
        	}
        	
        	else if(estimator=='' || estimator=='0'){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Estimator'
				});
				return false;
        	}
        	
        	else if(chklistremarks==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Enter Remarks'
				});
				return false;
        	}
        	else if(referencedby=='' || referencedby=='0'){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please Select Referenced By'
				});
				return false;
        	}
        	  $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
        	 		if (r){
        	 				
        	 			
        	 		 	
        		        	funChecklist(gatedocno,policereportno,policereportdate,regexpirydate,drvlicence,emiratesid,carcolor,claimtype,priority,estimator,instype,chklistremarks,referencedby);

        	 		 }
          	
          });
        });
        
        
        $('#btnqotapprovalsave').click(function(){
        	var rowindex=$('#rowindex').val();
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	
        	var pono=$('#qotpono').val();
        	var description=$('#qotdescription').val();
        	var chkexcess=0;
        	if($('#chkqotexcess').is(':checked')){
        		chkexcess=1;
        	}
        	else{
        		chkexcess=0;
        	}
        	var excessamt=$('#qotexcessamt').val();
        	if(excessamt!=''){
        		
        		if(isNaN(excessamt)){
        			$('#qotexcessamt').closest('div').find('span.help-block').remove();
        			$('#qotexcessamt').closest('div').append('<span class="help-block" style="color:red;"><small>Only Numbers Allowed</small></span>');
        			$('#qotexcessamt').focus();
        			return false;
        		}
        		else{
        			$('#qotexcessamt').closest('div').find('span.help-block').remove();
        		}
        	}
        	else{
        		$('#qotexcessamt').closest('div').find('span.help-block').remove();
        	}
        	if(docno!=''){
        		var estdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estdocno');
        		Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to approve GIP#"+vocno,
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				$('.page-loader').show();
		        		$.ajax({ 
			          		type: "POST", 
			          		url: "setApproval.jsp", 
			          		data: { 
								gipno: docno,
								estDocno:estdocno,
								pono:pono,
								desc:description,
								excess:chkexcess,
								excessamt:excessamt,
								brhid:$('#cmbbranch').val(),
								tobe:1,
								action:1,
								
							},
			      		}).success(function(ajaxresult,status,xhr) {
			          		if(ajaxresult.trim()=="0"){
			          			$('.page-loader').hide();
			          			$('#modalqotapproval').modal('hide');
			          			Swal.fire({
									icon:'success',
									type: 'success',
									title: 'Success',
									text: 'Quotation approved successfully'
								});
			          			$('#gateoutpassdetailsGriddiv').load('gateoutpassdetailsGrid.jsp?id=1&brhid='+$("#cmbbranch").val());	
			          		}
			          		else if(ajaxresult.trim()=="-1"){
			          			$('.page-loader').hide();
			          			$('#modalqotapproval').modal('hide');
			          			Swal.fire({
									icon:'warning',
									type: 'error',
									title: 'Warning',
									text: 'Additions Present,Please Approve from QOT Approval Form'
								});
								return false;
			          		}
			          		else{
			          			$('.page-loader').hide();
			          			Swal.fire({
									icon:'warning',
									type: 'error',
									title: 'Warning',
									text: 'Not Approved'
								});
								return false;
			          		}
			      		});			
	  				}
				});
        		
        	}
        });
        $('#btnqotapproval').click(function(){
       		var rowindex=$('#rowindex').val();
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
	        if($('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'customertype')=='New'){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create client before proceeding'
				});
				return false;
	        }
	        if(parseInt(processstatus)<2){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create Estimation before proceeding'
				});
				return false;
	        }
	        if(parseInt(processstatus)>=4){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Quotation already approved'
				});
				return false;
	        }
	        $('#modalqotapproval').find('.gipvocno').text(vocno);
	        $('#modalqotapproval').modal('show');
	        
        });
        $('#btnrelease').click(function(){
        	var rowindex=$('#rowindex').val();
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno');
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
	        if($('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'customertype')=='New'){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create client before proceeding'
				});
				return false;
	        }
	        if(parseInt(processstatus)==10){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Vehicle already released'
				});
				return false;
	        }
	        if(parseInt(processstatus)<5){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Job card not created'
				});
				return false;
	        }
        	if(docno!=''){
        		Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to release vehicle with GIP#"+vocno,
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				$('.page-loader').show();
		        		$.ajax({ 
			          		type: "POST", 
			          		url: "releaseVehicle.jsp", 
			          		data: { 
								gatedocno: docno
							}
			      		}).success(function(ajaxresult,status,xhr) {
			          		if(ajaxresult.trim()=="0"){
			          			$('.page-loader').hide();
			          			Swal.fire({
									icon:'success',
									type: 'success',
									title: 'Success',
									text: 'Vehicle released successfully'
								});
			          			$('#gateoutpassdetailsGriddiv').load('gateoutpassdetailsGrid.jsp?id=1&brhid='+$("#cmbbranch").val());	
			          		}
			          		else{
			          			$('.page-loader').hide();
			          			Swal.fire({
									icon:'warning',
									type: 'error',
									title: 'Warning',
									text: 'Not Released'
								});
								return false;
			          		}
			      		});			
	  				}
				});
        		
        	}
        });
        $('#btnchangebillto').click(function(){
        	$.get("getCountData.jsp", function(data, status){
    			data=JSON.parse(data);
    			var htmldata='<option value="">--Select--</option>';
				$.each(data.clientdata,function(index,value){
	  				htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbilltoclient').html($.parseHTML(htmldata));
	  			$('.cmbbilltoclient').select2({
	  				placeholder:"Select Client",
	  				allowClear:true
	  			});
	  			var rowindex=$('#rowindex').val();
	  			var cldocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'cldocno');
			 	var insurcompcldocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'insurcldocno');
			 	if(parseInt(cldocno)>0){
			 		$('#cmbbilltoclient').val(cldocno).trigger('change');
			 	}
			 	if(parseInt(insurcompcldocno)>0){
			 		$('#cmbbilltoinsur').val(insurcompcldocno).trigger('change');
			 	}
        		var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
        		var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        		if(parseInt(processstatus)==10){
		        	Swal.fire({
						type: 'error',
						icon:'warning',
						title: 'Warning',
						text: 'Vehicle already released'
					});
					return false;
		        }
		        /*else if($('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'customertype')=='New'){
		        	Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						icon:'warning',
						text: 'Please create client before proceeding'
					});
					return false;
		        }*/
		        else{
		        	$('#modalchangebillto').modal('show');
		        }
	        });
        });
        $('#btnbilltoupdate').click(function(){
        	
				var rowindex=$('#rowindex').val();
	        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
	        	var clientcldocno=$('#cmbbilltoclient').val();
	        	var insurcldocno=$('#cmbbilltoinsur').val();
	        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
	        	if(parseInt(processstatus)==10){
		        	Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Vehicle already released'
					});
					return false;
		        }
	        	if(clientcldocno!='' || insurcldocno!=''){
		        	Swal.fire({
		  				title: 'Are you sure?',
		  				text: "Do you want to update bill to!",
		  				icon: 'warning',
		  				showCancelButton: true,
		  				confirmButtonColor: '#3085d6',
		  				cancelButtonColor: '#d33',
		  				confirmButtonText: 'Yes'
					}).then((result) => {
		  				if (result.isConfirmed) {
		  					$('.page-loader').show();
			        		$.ajax({ 
				          		type: "POST", 
				          		url: "updateBillTo.jsp", 
				          		data: { 
									clientcldocno: clientcldocno,
									insurcldocno: insurcldocno,
									docno: docno
								}
				      		}).success(function(result,status,xhr) {
				          		if(result.trim()=="0"){
				          			$('.page-loader').hide();
				          			Swal.fire({
										icon:'success',
										type: 'success',
										title: 'Success',
										text: 'Bill to updated successfully'
									});
									$('#modalchangebillto').modal('hide');
				          			$('#gateoutpassdetailsGriddiv').load('gateoutpassdetailsGrid.jsp?id=1&brhid='+$("#cmbbranch").val());	
				          		}
				      		});
		        		}
					});
	        	}
        });
        $('#btncreateclient').click(function(){
        	var rowindex=$('#rowindex').val();
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	var clientname=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'refname');
	        var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
	        $('#createclienttrn').val(0);
        	if(parseInt(processstatus)==10){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Vehicle already released'
				});
				return false;
	        }
	        $('#modalcreateclient').modal('show');
        });
        
        $('#btncreateclientsave').click(function(){
        	var rowindex=$('#rowindex').val();
        	var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	var clientname=$('#createclientname').val();
	        var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
	        var clientmobile=$('#createclientmobile').val();
	        var clientemail=$('#createclientemail').val();
	        var clientaddress=$('#createclientaddress').val();
	        var clientcat=$('#cmbcreateclientcat').val();
	        var clienttrn=$('#createclienttrn').val();
        	if($('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'customertype')=='New'){
				if(clientcat==''){
					$('#cmbcreateclientcat').parent().find('span.help-block').remove();
					$('#cmbcreateclientcat').parent().append('<span class="help-block" style="color:red;"><small>Category is mandatory</small></span>');
					return false;
				}
				else{
					$('#cmbcreateclientcat').parent().find('span.help-block').remove();
				}
				if(clienttrn==''){
					$('#createclienttrn').parent().find('span.help-block').remove();
					$('#createclienttrn').parent().append('<span class="help-block" style="color:red;"><small>TRN is mandatory</small></span>');
					return false;
				}
				else{
					$('#createclienttrn').parent().find('span.help-block').remove();
				}
				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create client with "+clientname,
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				$.ajax({ 
			          		type: "POST", 
			          		url: "createClient.jsp", 
			          		data: { 
								clientname: clientname,
								docno: docno,
								clientmobile:clientmobile,
								clientemail:clientemail,
								clientaddress:clientaddress,
								clientcat:clientcat,
								clienttrn:clienttrn
							}
			      		}).success(function(result,status,xhr) {
			          		if(result.trim()=="0"){
			          			$('.page-loader').hide();
			          			Swal.fire({
									icon:'success',
									type: 'success',
									title: 'Success',
									text: 'Client created successfully'
								});
			          			$('#gateoutpassdetailsGriddiv').load('gateoutpassdetailsGrid.jsp?id=1&brhid='+$("#cmbbranch").val());	
			          			$('#modalcreateclient').modal('hide');
			          		}
							else{
								var errortitle="";
								if(result.trim()=="-2"){
									errortitle="Mobile No already exists";
								}
								else if(result.trim()=="-3"){
									errortitle="Telephone No already exists";
								}
								else if(result.trim()=="-4"){
									errortitle="Email Id already exists";
								}
								else{
									errortitle="Client not generated";
								}
								$('.page-loader').hide();
			          			Swal.fire({
									icon:'warning',
									type: 'error',
									title: 'Error',
									text: errortitle
								});
							}
			      		});
	  				}
				});        		
        	}
        	else{
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Customer already created'
				});
				return false;
        	}
        		
        });
        $('#btncreateest').click(function(){
        
	        var rowindex=$('#rowindex').val();
	        var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
	        var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');
	        var config=$('#attachmethod').val();
	        var count=$('#fileattachconfig').val();
	        var checklist=$('#checklistconfig').val();
	        var accident=$('#accidentconfig').val();

	      //  alert("attachmethod==="+config+"fileattachconfig===="+count);
			if(parseInt(config)==1 && parseInt(accident)==1)
					{
						if(parseInt(count)<4)
						 {
							Swal.fire({
							icon:'warning',
							type: 'error',
							title: 'Warning',
							text: 'Please Complete File Attachments'
							});
							return false;
					     }
						
						if(parseInt(checklist)<1)
						 {
							Swal.fire({
							icon:'warning',
							type: 'error',
							title: 'Warning',
							text: 'Please Complete Checklist'
							});
							return false;
					     }
						
						
						
					}
	        var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	if(parseInt(processstatus)==10){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Vehicle already released'
				});
				return false;
	        }
	        if($('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'customertype')=='New'){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create client before proceeding'
				});
				return false;
	        }
	        if(parseInt(processstatus)>=2){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Estimation already created'
				});
				return false;
	        }
	        var url=document.URL;
	     	var reurl=url.split("com/");
	     	var path1=window.estimationpath;
  	     	var path= path1+"?gipno="+docno+"&id=3&brhid="+brhid;
  	     	window.parent.formName.value="Estimation";
			window.parent.formCode.value="EST";
			//alert(path);
		 	top.addTab( "Estimation",reurl[0]+""+path);
        });
        $('#btncreatejobcard').click(function(){
	        var rowindex=$('#rowindex').val();
	        var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
	        var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');
	        if($('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'customertype')=='New'){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create client before proceeding'
				});
				return false;
	        }
	        var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	if(parseInt(processstatus)==10){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Vehicle already released'
				});
				return false;
	        }
	        var estdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estdocno');
	        if(processstatus=="1" || estdocno=="" || estdocno=="0"){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create estimation before proceeding'
				});
				return false;
	        }
	        if(parseInt(processstatus)<4){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Estimation not Approved'
				});
				return false;
	        }
	        if(processstatus=="5"){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Job Card already created'
				});
				return false;
	        }
	        var url=document.URL;
	     	var reurl=url.split("com/");
	     	var path1=window.jobcardpath;
  	     	var path= path1+"?gatedocno="+docno+"&estdocno="+estdocno+"&id=3&brhid="+brhid;
  	     	window.parent.formName.value="Job Card";
			window.parent.formCode.value="JBC";
		 	top.addTab( "Job Card",reurl[0]+""+path);
		 	
        });
        $('#btncreategateoutpass').click(function(){
	        var rowindex=$('#rowindex').val();
	        var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno');
	        var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');
	        var processstatus=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	if(parseInt(processstatus)==10){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Vehicle already released'
				});
				return false;
	        }
	        var estdocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'estdocno');
	        if(processstatus=="1" || estdocno=="" || estdocno=="0"){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create estimation before proceeding'
				});
				return false;
	        }
	        else if(parseInt(processstatus)<5){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please create job card before proceeding'
				});
				return false;
	        }
	        else if(parseInt(processstatus)<7){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please complete job card before proceeding'
				});
				return false;
	        }
	        else if(parseInt(processstatus)==8){
	        	Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Gate Out Pass already created'
				});
				return false;
	        }
	        else if(parseInt(processstatus)==7){
        		$('#lblgopdetails').text('GIP#'+$('.textpanel p').text());
        		$('#modalgateoutpass').modal('show');
	        }
			
        	
        });
        $('#btnexcel').click(function(){
        	$("#gateoutpassdetailsGrid").excelexportjs({
				containerid: "gateoutpassdetailsGrid",
				datatype: 'json',
				dataset: null,
				gridId: "gateoutpassdetailsGrid",
				columns: getColumns("gateoutpassdetailsGrid"),
				worksheetName: "GOP Details"
			});
        });
        
        $('.actionpanel button,.detailpanel button,.otherpanel button').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(jobcarddocno==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	var modaltarget=$(this).attr('data-target');
        	$(modaltarget).modal('show');
        });
        $('#btnteamupdate').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	var cmbteamupdatebay=$('#cmbteamupdatebay').val();
        	var cmbteamupdate=$('#cmbteamupdate').val();
        	if(jobcarddocno==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
			if(cmbteamupdate==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select atleast 1 team'
				});
        		return false;
        	}
        	if(cmbteamupdatebay==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a zone'
				});
        		return false;
        	}
        	funTeamUpdate();
        });
        $('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var jobcarddocno=$('#docno').val();
        	if(txtcomment==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(jobcarddocno==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
        
        $('#btnbaymovupdate').click(function(){
        	if($('#jobcarddocno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	if($('.cmbbaymovupdate').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a zone'
				});
        		return false;
        	}
        	funUpdateBayMov();
        });
        
        $('#btnbaystatusupdate').click(function(){
        	if($('#jobcarddocno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	if($('.cmbbaystatusupdate').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a zone'
				});
        		return false;
        	}
        	if($('.cmbbaystatus').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a status'
				});
        		return false;
        	}
        	funUpdateBayStatus();
        });
        $('.warningpanel div button').click(function(){
        	var gridrows=$('#gateoutpassdetailsGrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please submit'
				});
				return false;
        	}
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('id'),$(this).attr('data-filtervalue'),$(this).attr('data-datafield'),$(this).attr('data-filtertype'),$(this).attr('data-filtercondition'));
        	}
        	else{
        		$('#gateoutpassdetailsGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });
        
        $('#btngopupdate').click(function(e){
        	var gopdate=$('#gopdate').jqxDateTimeInput('val');
        	var goptime=$('#goptime').jqxDateTimeInput('val');
        	var gopkm=$('#gopkm').val();
        	var gopfuel=$('#cmbgopfuel').val();
        	var rowindex=$('#rowindex').val();
        	var brhid=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'brhid');
        	var docno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'docno'); 
        	var vocno=$('#gateoutpassdetailsGrid').jqxGrid('getcellvalue',rowindex,'vocno'); 
        	if(gopdate=="" || gopdate=="undefined" || gopdate==null){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'warning',
					text: 'Date is mandatory'
				});
				return false;
        	}
        	else if(goptime=="" || goptime=="undefined" || goptime==null){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'warning',
					text: 'Time is mandatory'
				});
				return false;
        	}
        	else if(funDateInPeriod(gopdate)!=1){
        		return false;
        	}
        	else if(gopkm=="" || gopkm=="undefined" || gopkm==null){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'warning',
					text: 'Km is mandatory'
				});
				return false;
        	}
        	else if(isNaN(gopkm)){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'warning',
					text: 'Enter Km in numbers only'
				});
				return false;
        	}
        	else if(gopfuel=="" || gopfuel=="undefined" || gopfuel==null){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'warning',
					text: 'Fuel is mandatory'
				});
				return false;
        	}
        	else{
        		Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create Gate Out Pass for GIP#"+vocno,
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Save'
				}).then((result) => {
	  				if (result.isConfirmed) {
	    				var x=new XMLHttpRequest();
						x.onreadystatechange=function(){
							if (x.readyState==4 && x.status==200)
							{
								var items=x.responseText.trim();
								if(items=="0"){
									Swal.fire({
										icon:'success',
										type: 'success',
										title: 'Message',
										text: 'Successfully Updated'
									});
									$('#modalgateoutpass').modal('hide');
									$('#btnsubmit').trigger('click');
									//funreload("");
								}
								else{
									Swal.fire({
										icon:'warning',
										type: 'error',
										title: 'warning',
										text: 'Not Updated'
									});
								}
							}
							else
							{
							}
						}
						x.open("GET","createGOP.jsp?gopdate="+gopdate+"&goptime="+goptime+"&gopkm="+gopkm+"&gopfuel="+gopfuel+"&docno="+docno+"&brhid="+brhid,true);
						x.send();
	  				}
				});
        		
        	}
        	
        });
        
        
        $('#btnchecklist').click(function(){
        	var gatedocno=$('#gatedocno').val();

        	if($('#gatedocno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}


         	
    });
    }); 
    function funload(){
		// $('.load-wrapp').show();
		 $('.page-loader').show();
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();   
		 var id=1;
		 var brhid=$('#cmbbranch').val();
		 $('#gateoutpassdetailsGriddiv').load('gateoutpassdetailsGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id='+id+'&brhid='+brhid);  
	} 
    function setQotExcess(){
    	if($('#chkqotexcess').is(':checked')){
    		$('#qotexcessamt').attr('disabled',false);
    	}
    	else{
    		$('#qotexcessamt').attr('disabled',true);
    	}
    }
    function funTeamUpdate(){
    	var jobcarddocno=$('#jobcarddocno').val();
        var cmbteamupdatebay=$('#cmbteamupdatebay').val();
        var cmbteamupdate=$('#cmbteamupdate').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					Swal.fire({
						icon:'success',
						type: 'success',
						title: 'Message',
						text: 'Successfully Updated'
					});
					$('#selectedteamsgriddiv').load('selectedTeamsGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
				}
				else{
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'warning',
						text: 'Not Updated'
					});
				}
			}
			else
			{
			}
		}
		x.open("GET","updateTeam.jsp?cmbteamupdatebay="+cmbteamupdatebay+"&jobcarddocno="+jobcarddocno+"&cmbteamupdate="+cmbteamupdate,true);
		x.send();
    }
    function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	if(id=="btnoverdue"){
    		filtervalue=new Date();
    	} 
    	//var filtercondition = 'contains';
    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#gateoutpassdetailsGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#gateoutpassdetailsGrid").jqxGrid('applyfilters');
 	}
    function saveComment(){
    	var comment=$('#txtcomment').val();
    	var docno=$('#docno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				getComments();		
			}
			else
			{
			}
		}
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&docno="+docno,true);
		x.send();
    }
    function getComments(){
    	var jobcarddocno=$('#docno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				if(x.responseText.trim()!=""){
					var items=x.responseText.trim().split(",");
					var str='';
					for(var k=0;k<items.length;k++){
						str+='<div class="comment"><div class="msg"><p>'+items[k].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[k].split("::")[1]+' - '+items[k].split("::")[2]+'</p></div></div>';
					}
					$('.comments-container').html($.parseHTML(str));		
				}
			
			}
			else
			{
			}
		}
		x.open("GET","getComments.jsp?docno="+jobcarddocno,true);
		x.send();
    }
    function getColor() {
    	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var modelItems = items[0].split(",");
				var modelidItems = items[1].split(",");
				var optionsmodel = '<option value="0">--Select--</option>';
				if(modelItems!=''){
				for (var j = 0; j < modelItems.length; j++) {
					optionsmodel += '<option value="' + modelidItems[j] + '">'
							+ modelItems[j] + '</option>';
				}
				}
				$("#cmbcolor").html(optionsmodel);
				if ($('#hidcmbcolor').val()!="") {
					$('#cmbcolor').val($('#hidcmbcolor').val());
				}
			} else {
			}
		}
		x.open("GET","getColor.jsp", true);
		x.send();
	}
    function SearchContent(url,id) {
        $.get(url).done(function (data) {
      $('#'+id).jqxWindow('setContent', data);
    }); 
    }
    function getMarketingPerson(event){
    	
    	var x= event.keyCode;
        if(x==114){
        	$('#marketingpersonwindow').jqxWindow('open');
    		$('#marketingpersonwindow').jqxWindow('focus');
    		SearchContent('marketingPersonSearchGrid.jsp?id=1','marketingpersonwindow');
        }
        else{
        }
    }
    function getReferencedBy(event){
    	
    	var x= event.keyCode;
        if(x==114){
        	$('#referencedbywindow').jqxWindow('open');
    		$('#referencedbywindow').jqxWindow('focus');
    		SearchContent('referencedBySearchGrid.jsp?id=1','referencedbywindow');
        }
        else{
        }
    }
    
    function setValues()
    {
  	  if($('#hidcmbclaimtype').val()!=""){
		  $('#cmbclaimtype').val($('#hidcmbclaimtype').val());
	  }
	  if($('#hidcmbdrvlicence').val()!=""){
		  $('#cmbdrvlicence').val($('#hidcmbdrvlicence').val());
	  }
	  if($('#hidcmbemiratesid').val()!=""){
		  $('#cmbemiratesid').val($('#hidcmbemiratesid').val());
	  } 
	  if($('#hidcmbcolor').val()!=""){
		  $('#cmbcolor').val($('#hidcmbcolor').val());
	  }
    	if($('#hidcmbpriority').val()!=""){
		  $('#cmbpriority').val($('#hidcmbpriority').val());
	  }
    	if($('#hidcmbinstype').val()!=""){
  		  $('#cmbinstype').val($('#hidcmbinstype').val());
  	  }
	 /*  if($('#hidpolicereportdate').val()!=""){
		  $('#policereportdate').jqxDateTimeInput('val',$('#hidpolicereportdate').val());

	  } 
	  if($('#hidregexpirydate').val()!=""){
		  $('#regexpirydate').jqxDateTimeInput('val',$('#hidregexpirydate').val());
	  } */
	 
	  
    }
   function getAllBays(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='<option value="">--Select--</option>';
				for(var i=0;i<items.length;i++){
					str+='<option value="'+items[i].split("::")[0]+'">'+items[i].split("::")[1]+'</option>';
				}
				$('.cmbbaymovupdate').html(str);	
				$('.cmbbaystatusupdate').html(str);	
				$('.cmbteamupdatebay').html(str);
			}
			else
			{
			}
		}
		x.open("GET","getAllBayData.jsp",true);
		x.send();
    }
    
    function getBays(jobdocno){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				if(x.responseText.trim()==""){
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Please Complete Job Planning'
					});
					return false;
				}
				var items=x.responseText.trim().split(",");
				var str='<option value="">--Select--</option>';
				for(var i=0;i<items.length;i++){
					str+='<option value="'+items[i].split("::")[0]+'">'+items[i].split("::")[1]+'</option>';
				}
				$('.cmbbaymovupdate').html(str);	
				$('.cmbbaystatusupdate').html(str);	
				$('.cmbteamupdatebay').html(str);
			}
			else
			{
			}
		}
		x.open("GET","getBayData.jsp?jobdocno="+jobdocno,true);
		x.send();
    }
    function getTeam(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='<option value="">--Select--</option>';
				for(var i=0;i<items.length;i++){
					str+='<option value="'+items[i].split("::")[0]+'">'+items[i].split("::")[1]+'</option>';
				}
				$('.cmbteamupdate').html(str);
			}
			else
			{
			}
		}
		x.open("GET","getTeamData.jsp",true);
		x.send();
    }
    
    
    
    
    function funUpdateBayMov(){
    	var jobcarddocno=$('#jobcarddocno').val();
    	var cmbbaymovupdate=$('.cmbbaymovupdate').val();
    	var baymovupdateindate=$('#baymovupdateindate').jqxDateTimeInput('val');
    	var baymovupdateintime=$('#baymovupdateintime').jqxDateTimeInput('val');
    	var baymovupdateoutdate=$('#baymovupdateoutdate').jqxDateTimeInput('val');
    	var baymovupdateouttime=$('#baymovupdateouttime').jqxDateTimeInput('val');
    	var baymovupdateremarks=$('#baymovupdateremarks').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items.split("::")[0]=="0"){
					Swal.fire({
						icon:'success',
						type: 'success',
						title: 'Message',
						text: 'Zone Movement Updated'
					});
					$('#btnsubmit').trigger('click');
				}
				else{
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: items.split("::")[1]
					});
				}
				
			}
			else
			{
			}
		}
		x.open("GET","bayMovUpdate.jsp?jobcarddocno="+jobcarddocno+"&cmbbaymovupdate="+cmbbaymovupdate+"&baymovupdateindate="+baymovupdateindate+"&baymovupdateintime="+baymovupdateintime+"&baymovupdateoutdate="+baymovupdateoutdate+"&baymovupdateouttime="+baymovupdateouttime+"&baymovupdateremarks="+baymovupdateremarks,true);
		x.send();
    }
   
    
    function funChecklist(gatedocno,policereportno,policereportdate,regexpirydate,drvlicence,emiratesid,carcolor,claimtype,priority,estimator,instype,chklistremarks,referencedby){
    	
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="1"){
					Swal.fire({
						icon:'success',
						type: 'success',
						title: 'Message',
						text: 'Saved Successfully'
					});
					$('#btnsubmit').trigger('click');
					
				}
				else{
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Not Saved'
					});
				}
				$('input[type=text],[type=hidden]').val('');

        		$('#modalchecklist').modal('hide');

			}
			else
			{
			}
		}
		x.open("GET","checklistData.jsp?gatedocno="+gatedocno+"&policereportno="+policereportno+"&policereportdate="+policereportdate+"&regexpirydate="+regexpirydate+"&drvlicence="+drvlicence+"&emiratesid="+emiratesid+"&carcolor="+carcolor+"&claimtype="+claimtype+"&priority="+priority+"&estimator="+estimator+"&instype="+instype+"&chklistremarks="+chklistremarks+"&referencedby="+referencedby,true);
		x.send();
    }
    
    
    
    function funUpdateBayStatus(){
    	var jobcarddocno=$('#jobcarddocno').val();
    	var cmbbaystatusupdate=$('.cmbbaystatusupdate').val();
    	var cmbbaystatus=$('#cmbbaystatus').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					Swal.fire({
						icon:'success',
						type: 'success',
						title: 'Message',
						text: 'Zone Status Updated'
					});
					$('#btnsubmit').trigger('click');
				}
				else{
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Not Updated'
					});
				}
				
			}
			else
			{
			}
		}
		x.open("GET","bayStatusUpdate.jsp?jobcarddocno="+jobcarddocno+"&cmbbaystatusupdate="+cmbbaystatusupdate+"&cmbbaystatus="+cmbbaystatus,true);
		x.send();
    }
    
    function funGetCountData(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				items=JSON.parse(items);
				var htmldata='';
				$.each(items.branchdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbranch').html($.parseHTML(htmldata));
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.clientdata,function(index,value){
	  				htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
	  			});
				$('.page-loader').show();
				//funGetFilterData();
				$('#gateoutpassdetailsGriddiv').load('gateoutpassdetailsGrid.jsp?id=1&brhid='+$("#cmbbranch").val());
	  			$('#cmbbilltoclient').html($.parseHTML(htmldata));
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.insurdata,function(index,value){
	  				htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbilltoinsur').html($.parseHTML(htmldata));
	  			$('.cmbbilltoclient').select2({
	  				placeholder:"Select Client",
	  				allowClear:true
	  			});
	  			$('.cmbbilltoinsur').select2({
	  				placeholder:"Select Insurance Company",
	  				allowClear:true
	  			});
	  			$('#cmbbranch').select2({
	  				placeholder:"Select Branch",
	  				allowClear:true
	  			});
				htmldata='<option value="">--Select--</option>';
				$.each(items.clientcatdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbcreateclientcat').html($.parseHTML(htmldata));
	  			$('#cmbcreateclientcat').select2({
	  				placeholder:"Select Category",
	  				allowClear:true
	  			});
				window.estimationpath=items.estimationpath;
				window.jobcardpath=items.jobcardpath;
				//alert("==="+items.estimationaction)   
				window.estimationaction=items.estimationaction;
				window.estimationaddaction=items.estimationaddaction;
			}
			else
			{
			}
		}
		x.open("GET","getCountData.jsp",true);
		x.send();
    }

	/* function funGetFilterData(){
		$.get('getFilterData.jsp', { brhid:$('#cmbbranch').val() }, function(data) {
   			data=JSON.parse(data);
   			var gippercent=((parseFloat(data.gipcount)/parseFloat(data.totalcount))*100).toFixed(0);
			var estpercent=((parseFloat(data.estcount)/parseFloat(data.totalcount))*100).toFixed(0);
			var jobpercent=((parseFloat(data.jobcount)/parseFloat(data.totalcount))*100).toFixed(0);
			var jccpercent=((parseFloat(data.jcccount)/parseFloat(data.totalcount))*100).toFixed(0);
			var invpercent=((parseFloat(data.invcount)/parseFloat(data.totalcount))*100).toFixed(0);
			var rlspercent=((parseFloat(data.relcount)/parseFloat(data.totalcount))*100).toFixed(0);
			if (isNaN(gippercent)) gippercent = 0;
			if (isNaN(estpercent)) estpercent = 0;
			if (isNaN(jobpercent)) jobpercent = 0;
			if (isNaN(jccpercent)) jccpercent = 0;
			if (isNaN(invpercent)) invpercent = 0;
			if (isNaN(rlspercent)) rlspercent = 0;
			$('.card-item').eq(0).find('.value').text(data.gipcount).closest('.card-item').find('.progress-bar').css('width',gippercent+'%');
			$('.card-item').find('.totalcount').text(data.totalcount);
			$('.card-item').eq(1).find('.value').text(data.estcount).closest('.card-item').find('.progress-bar').css('width',estpercent+'%');
			$('.card-item').eq(2).find('.value').text(data.jobcount).closest('.card-item').find('.progress-bar').css('width',jobpercent+'%');
			$('.card-item').eq(3).find('.value').text(data.jcccount).closest('.card-item').find('.progress-bar').css('width',jccpercent+'%');
			$('.card-item').eq(4).find('.value').text(data.invcount).closest('.card-item').find('.progress-bar').css('width',invpercent+'%');
			$('.card-item').eq(5).find('.value').text(data.relcount).closest('.card-item').find('.progress-bar').css('width',rlspercent+'%');
		});
	} */
function funDateInPeriod(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
    	//$.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
     	Swal.fire({
			icon:'warning',
			type: 'error',
			title: 'Warning',
			text: 'Transaction prior or after Account Period is not valid.'
		});
     $('#txtvalidation').val(1);
     return 0;
    }
     if(value>currentDate){
    	 //$.messager.alert('Warning',"Future Date, Transaction Restricted. ");
     	Swal.fire({
			icon:'warning',
			type: 'error',
			title: 'Warning',
			text: 'Future Date, Transaction Restricted.'
		});
     $('#txtvalidation').val(1);
     return 0;
    } 
    if(value<=mclose){
    	//$.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
     	Swal.fire({
			icon:'warning',
			type: 'error',
			title: 'Warning',
			text: 'Closing Done, Transaction Restricted.'
		});
     $('#txtvalidation').val(1);
     return 0;
    }
    
    $('#txtvalidation').val(0);
     return 1;
 }
 function funRoundAmt(value,id){
    var res=parseFloat(value).toFixed(window.parent.amtdec.value);
    var res1=(res=='NaN'?"0":res);
    document.getElementById(id).value=res1;  
   }
 
 function getconfig(){
 	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				 if(parseInt(items.split("::")[0])>0){
					 $("#btnprintopengip").show();
					 $("#textgip").show();
				 }else{
					 $("#btnprintopengip").hide();
					 $("#textgip").hide();
				 }
				 if(parseInt(items.split("::")[1])>0){
					 $('#btnqotapproval').hide();
				 }else{
					 $('#btnqotapproval').show();
				 }
				 if(parseInt(items.split("::")[2])>0){
					 $('#btnchecklist').show();
				 }else{
					 $('#btnchecklist').hide();
				 }
				 
			}
			else
			{
			}
		}
		x.open("GET","getconfig.jsp",true);
		x.send();
 }
 
 
 function getfileattachConfig(docno){
	 	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
						 $('#attachmethod').val(items.split("::")[0]);
						 $('#fileattachconfig').val(items.split("::")[1]);
						 $('#checklistconfig').val(items.split("::")[2]);
						 $('#accidentconfig').val(items.split("::")[3]);

				}
				else
				{
				}
			}
			x.open("GET","getfileattachConfig.jsp?docno="+docno,true);
			x.send();
	 }
 
 
 
</script>
<div id="marketingpersonwindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="referencedbywindow">
		<div><img id="loadingImage" src="../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
</body>
</html>
